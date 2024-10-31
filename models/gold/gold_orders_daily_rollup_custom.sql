{{ config(
    enabled=false
) }}

select
    date_trunc(so.created_at_timestamp, DAY) as order_date,
    case
        when so.customer_order_seq_number = 1 then 'First Time Customer'
        else 'Returning Customer'
    end as customer_type,
    count(distinct so.order_id) as order_count,
    sum(so.total_line_items_price) as sum_total_line_items_price,
    sum(so.total_price) as sum_total_price,
    sum(so.subtotal_price) as sum_subtotal_price,
    sum(so.total_tax) as sum_total_tax,
    sum(so.total_discounts) as sum_total_discounts,
    count(distinct so.customer_id) as unique_customers

from {{ ref("canonical_orders") }} so
where 
    so.created_at_timestamp >= '2023-01-01' -- Only return orders since the start of 2023.
    and not (lower(so.order_tags) like '%sample%') -- Exclude sample orders.

group by 1, 2
order by 1 asc, 2 desc
