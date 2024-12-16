{{ config(
    materialized='ephemeral'
) }}

with refund_transactions as (
    select
        order_id,
        timestamp(json_value(transaction, '$.created_at')) as refund_transaction_timestamp,
        cast(json_value(transaction, '$.amount') as float64) as transaction_amount
    from {{ source('shopify_prod_airbyte', 'order_refunds') }},
    unnest(json_extract_array(transactions)) as transaction -- Extract transactions directly from the column
)

select
    order_id,
    refund_transaction_timestamp,
    sum(transaction_amount) as refund_transaction_amount
from refund_transactions
group by order_id, refund_transaction_timestamp
