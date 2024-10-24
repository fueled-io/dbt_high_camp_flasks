select *
from {{ ref("google_ads_ad_group_campaigns_segments") }} ad
join
    {{ ref("google_ads_campaigns_summary_stats") }} c
    on ad.ad_group_campaign_id = c.campaign_id
    and ad.ad_group_segments_date = c.segments_date
