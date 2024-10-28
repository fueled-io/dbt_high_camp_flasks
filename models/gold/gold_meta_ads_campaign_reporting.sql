{{ config(materialized="table") }}

select
    date(date_start) as campaign_date,
    campaign_id,
    campaign_name,
    sum(spend) as daily_ad_spend,
    sum(clicks) as total_daily_clicks,
    sum(impressions) as total_daily_impressions,
-- TODO: Need conversions and conversions_value
from {{ ref("canonical_meta_ads_campaigns") }}
group by campaign_id, campaign_name, campaign_date
order by campaign_date desc, campaign_name desc
