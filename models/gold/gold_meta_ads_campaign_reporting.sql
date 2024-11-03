{{ config(materialized="table") }}

SELECT
    date_start as campaign_date,
    --ad_id,
    ads_insights_campaign_id AS campaign_id,
    SUM(spend) AS daily_ad_spend,
    SUM(clicks) AS total_daily_clicks,
    SUM(impressions) AS total_daily_impressions,
    SUM(purchase_count) AS daily_purchase_count_per_campaign,
    ROUND(SUM(purchase_value), 2) AS daily_purchase_total_value_per_campaign
FROM {{ ref("canonical_meta_ads_campaigns") }}
GROUP BY date_start, campaign_id
ORDER BY date_start DESC

