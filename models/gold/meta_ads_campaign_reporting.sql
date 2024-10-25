SELECT 
    ai.ad_id,
    ai.ad_name,
    ai.campaign_id,
    cd.campaign_name,
    cd.objective,
    ai.spend_date,
    ai.daily_spend,
    ai.daily_clicks,
    ai.daily_impressions,
    ai.avg_cpc,
    ai.avg_cpm,
    ai.avg_ctr,
    cd.spend_cap,
    cd.daily_budget,
    cd.lifetime_budget,
    cd.effective_status,
    cd.buying_type
FROM 
    {{ ref('meta_ads_stats') }} ai
LEFT JOIN 
    {{ ref('meta_campaigns') }} cd
ON 
    ai.campaign_id = cd.campaign_id
ORDER BY 
    ai.spend_date, ai.ad_id