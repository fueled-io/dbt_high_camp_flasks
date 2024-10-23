SELECT
    ad.ad_campaign_id,
    c.campaign_name,
    c.campaign_status,
    ad.segments_date,
    ad.total_ad_spend,   -- Adding spend information for further aggregation at the gold level
    c.campaign_advertising_channel_type,
    c.campaign_advertising_channel_sub_type,
    c.segments_ad_network_type,
    c.total_clicks,
    c.total_impressions,
    c.total_conversions,
    c.total_conversions_value
FROM {{ ref("google_ads_ad_group_campaigns_segments") }} ad
JOIN {{ ref('google_ads_campaigns_summary_stats') }} c
    ON ad.ad_campaign_id = c.campaign_id
    AND ad.segments_date = c.segments_date