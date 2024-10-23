select *
from {{ ref("stg_google_ads_ad_group_campaign_segments") }} ad
join {{ ref("stg_google_ads_distinct_campaigns") }} c on ad.ad_campaign_id = c.campaign_id
