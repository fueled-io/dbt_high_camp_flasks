{{ config(
    materialized='ephemeral'
) }}

with variant_costs as (
    select
        pv.id as variant_id,
        pv.created_at as created_at_timestamp,
        pv.updated_at as variant_updated_at,
        pv.*,
        ii.cost as variant_cost  -- Adding the cost from inventory_items
    from 
        {{ source('shopify_prod_airbyte', 'product_variants') }} as pv
    left join 
        {{ source('shopify_prod_airbyte', 'inventory_items') }} as ii
    on 
        pv.inventory_item_id = ii.id
)

select * from variant_costs
