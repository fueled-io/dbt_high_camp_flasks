select
    ad.campaign_id,
    ad.campaign_name,
    ad.campaign_status,
    ad.segments_date,
    sum(ad.total_ad_spend) as daily_ad_spend
from {{ ref("google_ad_campaigns") }} ad
group by
    ad.campaign_id,
    ad.campaign_name,
    ad.campaign_status,
    ad.segments_date
order by
    ad.segments_date, ad.campaign_id
