select *
from {{ ref("google_ad_campaigns") }}
group by campaign_id, campaign_name, campaign_status, segments_date
order by segments_date, campaign_id
