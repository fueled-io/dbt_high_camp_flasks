SELECT
    campaign_id,
    campaign_name,
    campaign_status,
    segments_date,
    ROUND(SUM(total_ad_spend), 2) AS daily_ad_spend,
    SUM(total_clicks) AS total_daily_clicks,
    SUM(total_impressions) AS total_daily_impressions,
    SUM(total_conversions) AS total_daily_conversions,
    SUM(total_conversions_value) AS total_daily_conversions_value
FROM {{ ref('google_ads_campaigns') }}
GROUP BY
    campaign_id, campaign_name, campaign_status, segments_date