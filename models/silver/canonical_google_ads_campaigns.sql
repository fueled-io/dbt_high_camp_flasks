select *
from {{ ref("stg_google_ads_ad_group_campaign_segments") }} as ad
inner join
    {{ ref("stg_google_ads_campaigns_stats") }} as c
    on
        ad.ad_group_campaign_id = c.campaign_id
        and ad.ad_group_segments_date = c.segments_date
