{{ config(
    materialized='ephemeral'
) }}

SELECT
    customer_id,
    customer_lifetime_order_count,
    customer_lifetime_total_value_sum,
    customer_lifetime_total_value_avg,
    DATE_DIFF(CURRENT_DATE(), DATE(first_order_timestamp), DAY) AS days_since_first_order,
    DATE_DIFF(CURRENT_DATE(), DATE(most_recent_order_timestamp), DAY) AS days_since_most_recent_order,
    first_order_referring_site,
    most_recent_order_referring_site
FROM (
    SELECT
        customer_id,
        FIRST_VALUE(referring_site) OVER (PARTITION BY customer_id ORDER BY created_at_timestamp) AS first_order_referring_site,
        FIRST_VALUE(created_at_timestamp) OVER (PARTITION BY customer_id ORDER BY created_at_timestamp) AS first_order_timestamp,
        FIRST_VALUE(referring_site) OVER (PARTITION BY customer_id ORDER BY created_at_timestamp DESC) AS most_recent_order_referring_site,
        FIRST_VALUE(created_at_timestamp) OVER (PARTITION BY customer_id ORDER BY created_at_timestamp DESC) AS most_recent_order_timestamp,
        COUNT(*) OVER (PARTITION BY customer_id) AS customer_lifetime_order_count,
        SUM(total_price) OVER (PARTITION BY customer_id) AS customer_lifetime_total_value_sum,
        AVG(total_price) OVER (PARTITION BY customer_id) AS customer_lifetime_total_value_avg,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY created_at_timestamp) AS row_num
    FROM {{ ref("shopify__orders") }}
    WHERE customer_id IS NOT NULL -- Ensure customer_id is not null
)
WHERE row_num = 1
