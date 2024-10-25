select
    ad_id,
    ad_name,
    campaign_id,
    date(date_start) as spend_date,
    sum(spend) as daily_spend,
    sum(clicks) as daily_clicks,
    sum(impressions) as daily_impressions,
    avg(cpc) as avg_cpc,
    avg(cpm) as avg_cpm,
    avg(ctr) as avg_ctr
from {{ ref("stg_meta_ads_ads_stats") }}
group by ad_id, ad_name, campaign_id, date(date_start)
