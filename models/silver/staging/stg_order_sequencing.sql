WITH user_first_order AS (
    -- Get the first order for each customer based on customer_id
    SELECT
        customer_id,
        MIN(created_timestamp) AS first_order_date,
        ARRAY_AGG(order_id ORDER BY created_timestamp ASC LIMIT 1)[OFFSET(0)] AS first_order_id,
        -- Capture referring site for the first order
        ARRAY_AGG(referring_site ORDER BY created_timestamp ASC LIMIT 1)[OFFSET(0)] AS first_referring_site
    FROM {{ ref("shopify__orders") }}
    GROUP BY customer_id
)

-- Main select query with sequence numbers and marketing attribution for first order only
SELECT
    so.order_id,
    so.customer_id,
    so.email,
    so.created_timestamp AS order_date,
    so.customer_order_seq_number AS customer_order_sequence,
    -- Referring site for current order
    so.referring_site AS current_referring_site,
    ufo.first_order_id,
    ufo.first_order_date,
    DATE_DIFF(
        CAST(so.created_timestamp AS DATE), CAST(ufo.first_order_date AS DATE), DAY
    ) AS days_between_orders,
    DATE_DIFF(
        DATE_TRUNC(CAST(so.created_timestamp AS DATE), MONTH),
        DATE_TRUNC(CAST(ufo.first_order_date AS DATE), MONTH),
        MONTH
    ) AS months_between_orders_rounded_down,

    -- Get marketing source and medium for the first order using the macros
    {{ get_marketing_source('ufo.first_referring_site') }} AS first_order_marketing_source,
    {{ get_marketing_medium('ufo.first_referring_site') }} AS first_order_marketing_medium

FROM {{ ref("shopify__orders") }} AS so
LEFT JOIN user_first_order AS ufo
    ON so.customer_id = ufo.customer_id