    SELECT
        ad_campaign_id,
        ad_group_id,
        segments_date,
        SUM(metrics_cost_micros) / 1e6 AS total_ad_spend  -- Convert micros to standard currency
    FROM
        {{ ref('stg_google_ads_airbyte__ad_group') }}
    GROUP BY
        ad_campaign_id, ad_group_id, segments_date