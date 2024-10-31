{{ config(
    materialized='ephemeral'
) }}

with line_item_costs as (
    select
        o.id as order_id,
        cast(json_extract_scalar(item, '$.variant_id') as int64) as variant_id,
        cast(json_extract_scalar(item, '$.quantity') as int64) as quantity,
        pv.variant_cost,
        cast(json_extract_scalar(item, '$.quantity') as int64) * pv.variant_cost as total_line_item_cost
    from 
        {{ source('shopify_prod_airbyte', 'orders') }} as o,
        unnest(json_extract_array(o.line_items)) as item
    left join 
        {{ ref('stg_shopify_products_variants_tmp') }} as pv
    on 
        cast(json_extract_scalar(item, '$.variant_id') as int64) = pv.variant_id
)

select 
    order_id,
    sum(total_line_item_cost) as total_order_cogs
from 
    line_item_costs
group by 
    order_id
