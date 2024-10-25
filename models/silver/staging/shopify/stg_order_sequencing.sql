{{ config(
    materialized='ephemeral'
) }}

WITH user_first_order AS (
    -- Get the first order for each customer based on customer_id
    SELECT
        customer_id,
        MIN(created_at_timestamp) AS first_order_date,
        ARRAY_AGG(order_id ORDER BY created_at_timestamp ASC LIMIT 1)[OFFSET(0)] AS first_order_id,
        -- Capture referring site for the first order
        ARRAY_AGG(referring_site ORDER BY created_at_timestamp ASC LIMIT 1)[OFFSET(0)] AS first_referring_site
    FROM {{ ref("shopify__orders") }}
    GROUP BY customer_id
),

orders_with_seq AS (
    -- Calculate customer_order_seq_number for each order
    SELECT
        order_id,
        customer_id,
        email,
        created_at_timestamp AS order_date,
        referring_site,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY created_at_timestamp
        ) AS customer_order_seq_number
    FROM {{ ref("shopify__orders") }}
)

-- Main select query with sequence numbers and marketing attribution for first order only
SELECT
    ow.order_id,
    ow.customer_id,
    ow.email,
    ow.order_date,
    ow.customer_order_seq_number,
    -- Referring site for current order
    ow.referring_site AS current_referring_site,
    ufo.first_order_id,
    ufo.first_order_date,
    DATE_DIFF(
        CAST(ow.order_date AS DATE), CAST(ufo.first_order_date AS DATE), DAY
    ) AS days_between_orders,
    DATE_DIFF(
        DATE_TRUNC(CAST(ow.order_date AS DATE), MONTH),
        DATE_TRUNC(CAST(ufo.first_order_date AS DATE), MONTH),
        MONTH
    ) AS months_between_orders_rounded_down,

    -- Get marketing source and medium for the first order using the macros
    {{ get_marketing_source('ufo.first_referring_site') }} AS first_order_marketing_source,
    {{ get_marketing_medium('ufo.first_referring_site') }} AS first_order_marketing_medium

FROM orders_with_seq AS ow
LEFT JOIN user_first_order AS ufo
    ON ow.customer_id = ufo.customer_id