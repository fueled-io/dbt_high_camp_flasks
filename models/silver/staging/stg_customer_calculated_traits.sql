SELECT
    customer_id,
    DATE_DIFF(CURRENT_DATE(), DATE(first_order_timestamp), DAY) AS days_since_first_order,
    DATE_DIFF(CURRENT_DATE(), DATE(most_recent_order_timestamp), DAY) AS days_since_most_recent_order,
    first_order_referring_site,
    most_recent_order_referring_site
FROM (
    SELECT
        customer_id,
        FIRST_VALUE(referring_site) OVER (PARTITION BY customer_id ORDER BY created_timestamp) AS first_order_referring_site,
        FIRST_VALUE(created_timestamp) OVER (PARTITION BY customer_id ORDER BY created_timestamp) AS first_order_timestamp,
        FIRST_VALUE(referring_site) OVER (PARTITION BY customer_id ORDER BY created_timestamp DESC) AS most_recent_order_referring_site,
        FIRST_VALUE(created_timestamp) OVER (PARTITION BY customer_id ORDER BY created_timestamp DESC) AS most_recent_order_timestamp,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY created_timestamp) AS row_num
    FROM {{ ref("shopify__orders") }}
    WHERE customer_id IS NOT NULL -- Ensure customer_id is not null
)
WHERE row_num = 1