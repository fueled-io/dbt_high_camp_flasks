{{ config(materialized="ephemeral") }}

SELECT
    ad.ad_id,
    ad.ad_name,
    ad.ads_insights_campaign_id,
    ad.date_start,
    ad.spend,
    ad.clicks,
    ad.conversions,
    ad.impressions,
    ad.costs_per_link_click,
    ad.costs_per_thousand_impressions,
    ad.click_through_rate,
    -- Including available purchase-related columns from the extract actions model
    COALESCE(ea.purchase_count, 0) AS purchase_count,
    COALESCE(ea.purchase_value, 0) AS purchase_value,
FROM {{ ref("stg_meta_ads_airbyte__ads_insights") }} AS ad
LEFT JOIN {{ ref("stg_meta_ads_insights_extract_actions") }} AS ea
    ON ad.ad_id = ea.ad_id AND ad.date_start = ea.date_start
ORDER BY ad.spend DESC, ad.date_start DESC, ad.ad_id DESC
