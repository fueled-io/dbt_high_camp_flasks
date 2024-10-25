{{ config(
    materialized='ephemeral'
) }}

SELECT
    campaign_id,
    campaign_name,
    campaign_advertising_channel_type,
    campaign_advertising_channel_sub_type,
    segments_ad_network_type,
    segments_date,
    SUM(metrics_clicks) AS total_clicks,
    SUM(metrics_impressions) AS total_impressions,
    SUM(metrics_conversions) AS total_conversions,
    SUM(metrics_conversions_value) AS total_conversions_value
FROM {{ ref("stg_google_ads_airbyte__campaign") }}
GROUP BY
    campaign_id, campaign_name, campaign_status, campaign_advertising_channel_type,
    campaign_advertising_channel_sub_type, segments_ad_network_type, segments_date