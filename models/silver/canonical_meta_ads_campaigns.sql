select *
from {{ ref("stg_meta_ads_insights") }} as ad
-- inner join
--     {{ ref("stg_meta_ads_campaigns") }} as c
--     on ad.ads_insights_campaign_id = c.campaign_id    
order by date_start desc, ad_id desc