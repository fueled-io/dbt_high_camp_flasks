select *
from {{ ref("stg_meta_ads_ads_stats") }} as ad
inner join
    {{ ref("stg_meta_ads_campaigns") }} as c
    on ad.ads_insights_campaign_id = c.campaign_id    