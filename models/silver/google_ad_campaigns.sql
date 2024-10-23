    SELECT
        c.campaign_id,
        c.campaign_name,
        c.campaign_status,
        ad.segments_date,    
        SUM(ad.total_ad_spend) AS daily_ad_spend
    FROM
        {{ ref('stg_google_ads_ad_group_campaign_segments') }} ad
    JOIN
        {{ ref('stg_google_ads_distinct_campaigns') }} c
        ON ad.campaign_id = c.campaign_id
    GROUP BY
        c.campaign_id, c.campaign_name, c.campaign_status, ad.segments_date
    ORDER BY
        ad.segments_date, c.campaign_id