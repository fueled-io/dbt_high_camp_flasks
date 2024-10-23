select
    campaign_id,
    campaign_name,
    campaign_status,
    campaign_advertising_channel_type,
    campaign_advertising_channel_sub_type,
    segments_date,
    segments_ad_network_type,
    metrics_clicks,
    metrics_impressions,
    metrics_conversions,
    metrics_conversions_value
from {{ ref("stg_google_ads_airbyte__campaign") }}
