{{ config(
    materialized='ephemeral'
) }}

-- This model extracts all fulfillments from the raw Orders table ingested by AirByte.

-- First, we get all fulfillments for each order.
with orders_with_fulfillments as (
    select
        id as order_id,
        fulfillments
    from {{ source('shopify_prod_airbyte', 'orders') }}
),

-- Then, we parse this Fulfillments JSON document.
parsed_fulfillments as (
    select
        order_id,
        (
            select max(timestamp(fulfillment_value))
            from unnest(json_extract_array(fulfillments)) as fulfillment
            cross join unnest([json_extract_scalar(fulfillment, '$.created_at')]) as fulfillment_value
        ) as most_recent_fulfillment_created_at
    from orders_with_fulfillments
)

-- Finally, we select the most recently created fulfillment per orders as the final day of fulfillment.
select
    order_id,
    most_recent_fulfillment_created_at
from parsed_fulfillments
