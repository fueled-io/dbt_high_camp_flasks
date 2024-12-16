{{ config(
    materialized='table'
) }}

select
    order_id,
    refund_transaction_timestamp,
    -- Convert refund_transaction_timestamp to Los Angeles Pacific Time
    TIMESTAMP(FORMAT_TIMESTAMP('%F %T', refund_transaction_timestamp, 'America/Los_Angeles')) as refund_transaction_timestamp_pt,
    refund_transaction_amount
from {{ ref('canonical_refund_transactions') }}
