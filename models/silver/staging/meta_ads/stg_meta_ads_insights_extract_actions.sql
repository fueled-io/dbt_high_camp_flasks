{{ config(materialized="view") }}

-- Extract values from the `action_values` column
WITH actions_value_extracted AS (
    SELECT
        date_start,
        ads_insights_campaign_id,
        ad_id,
        ad_name,
        -- Sum the value for 'purchase' action types in `action_values`
        SUM(
            CASE 
                WHEN JSON_EXTRACT_SCALAR(action_value, '$.action_type') = 'purchase' THEN SAFE_CAST(JSON_EXTRACT_SCALAR(action_value, '$.value') AS FLOAT64)
                ELSE 0
            END
        ) AS purchase_value
    FROM {{ ref("stg_meta_ads_airbyte__ads_insights") }},
    UNNEST(JSON_EXTRACT_ARRAY(action_values)) AS action_value
    GROUP BY
        date_start,
        ads_insights_campaign_id,
        ad_id,
        ad_name
),

-- Extract values from the `actions` column
actions_extracted AS (
    SELECT
        date_start,
        ads_insights_campaign_id,
        ad_id,
        ad_name,
        -- Sum the value for 'purchase' action types in `actions`
        SUM(
            CASE 
                WHEN JSON_EXTRACT_SCALAR(action, '$.action_type') = 'purchase' THEN SAFE_CAST(JSON_EXTRACT_SCALAR(action, '$.value') AS FLOAT64)
                ELSE 0
            END
        ) AS purchase_count
    FROM {{ ref("stg_meta_ads_airbyte__ads_insights") }},
    UNNEST(JSON_EXTRACT_ARRAY(actions)) AS action
    GROUP BY
        date_start,
        ads_insights_campaign_id,
        ad_id,
        ad_name
)

-- Combine results
SELECT
    av.date_start,
    av.ads_insights_campaign_id,
    av.ad_id,
    av.ad_name,
    ac.purchase_count,
    av.purchase_value
FROM actions_value_extracted AS av
LEFT JOIN actions_extracted AS ac
    ON av.date_start = ac.date_start
    AND av.ads_insights_campaign_id = ac.ads_insights_campaign_id
    AND av.ad_id = ac.ad_id
    AND av.ad_name = ac.ad_name
ORDER BY av.date_start DESC, av.ads_insights_campaign_id ASC, av.ad_id ASC
