SELECT
    segments_date,
    campaign_id,
    campaign_name,
    campaign_advertising_channel_type,
    campaign_advertising_channel_sub_type,
    segments_ad_network_type,
    total_ad_spend,
    total_clicks,
    total_impressions,
    total_conversions,
    total_conversions_value
FROM {{ ref("stg_google_ads_campaigns_stats") }}
order by segments_date desc, campaign_id desc
