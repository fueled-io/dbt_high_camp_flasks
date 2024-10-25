{{ config(
    materialized='ephemeral'
) }}

select 
    id as customer_id,
    created_at as created_at_timestamp,
    * 
from {{ source('shopify_prod_airbyte','customers') }}