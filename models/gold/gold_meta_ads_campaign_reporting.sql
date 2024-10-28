select
    ad_id,
    ad_name,
    campaign_id,
    campaign_name,
    objective,
    date(date_start) as spend_date,
    sum(spend) as daily_spend,
    sum(clicks) as daily_clicks,
    sum(impressions) as daily_impressions,
    avg(costs_per_link_click) as avg_costs_per_link_click,
    avg(costs_per_thousand_impressions) as avg_costs_per_thousand_impressions,
    avg(click_through_rate) as avg_click_through_rate,
    spend_cap,
    daily_budget,
    lifetime_budget,
    effective_status,
    buying_type
from {{ ref("canonical_meta_ads_campaigns") }}
group by
    ad_id,
    ad_name,
    campaign_id,
    campaign_name,
    objective,
    spend_date,
    spend_cap,
    daily_budget,
    lifetime_budget,
    effective_status,
    buying_type
ORDER BY spend_date DESC, campaign_name DESC
