{{ config(
    materialized='ephemeral'
) }}

with shipping_fees as (
    select
        id as order_id,  -- The Shopify Order ID
        sum(cast(json_extract_scalar(line, '$.price') as float64)) as total_shipping_fees
    from
        {{ source('shopify_prod_airbyte', 'orders') }},
        unnest(json_extract_array(shipping_lines)) as line
    group by
        order_id
)

select
    order_id,
    total_shipping_fees
from
    shipping_fees
