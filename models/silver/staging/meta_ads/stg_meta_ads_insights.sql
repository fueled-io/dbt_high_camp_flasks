select
    ad_id,
    ad_name,
    ads_insights_campaign_id,
    date_start,
    spend,
    clicks,
    conversions,
    impressions,
    costs_per_link_click,
    costs_per_thousand_impressions,
    click_through_rate
from {{ ref("stg_meta_ads_airbyte__ads_insights") }}
