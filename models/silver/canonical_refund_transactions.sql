{{ config(
    materialized='table'
) }}

select
    order_id,
    refund_transaction_timestamp,
    refund_transaction_amount
from {{ ref('shopify__refund_transactions') }}
