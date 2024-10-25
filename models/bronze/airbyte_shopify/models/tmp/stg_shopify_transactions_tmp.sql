{{ config(
    materialized='ephemeral'
) }}

select *
from {{ source('shopify_prod_airbyte','transactions') }}