{{ config(
    materialized='ephemeral'
) }}

select
    id as product_id,
    created_at as created_at_timestamp,
    *
from {{ source('shopify_prod_airbyte','products') }} 