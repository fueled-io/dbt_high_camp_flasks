select 
    id as refund_id,
    *
from {{ source('shopify_prod_airbyte','order_refunds') }}