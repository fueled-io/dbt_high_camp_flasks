select
    id as variant_id, 
    created_at as created__at_timestamp,
    updated_at as variant_updated_at,
    *
from {{ source('shopify_prod_airbyte','product_variants') }}   