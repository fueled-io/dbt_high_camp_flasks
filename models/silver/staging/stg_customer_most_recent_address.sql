WITH ranked_orders AS (
    SELECT
        customer_id,
        email,
        billing_address_address_1 AS billing_address_1,
        billing_address_address_2 AS billing_address_2,
        billing_address_city AS billing_city,
        billing_address_province AS billing_state,
        billing_address_province_code AS billing_state_code,
        billing_address_zip AS billing_zip,
        billing_address_country AS billing_country,
        billing_address_country_code AS billing_country_code,
        ROW_NUMBER()
            OVER (PARTITION BY customer_id ORDER BY created_timestamp DESC)
            AS row_num
    FROM {{ ref("shopify__orders") }}
    WHERE customer_id IS NOT NULL -- Exclude rows with null customer_id
)

SELECT
    customer_id,
    email,
    billing_address_1,
    billing_address_2,
    billing_city,
    billing_state,
    billing_state_code,
    billing_zip,
    billing_country,
    billing_country_code
FROM ranked_orders
WHERE row_num = 1