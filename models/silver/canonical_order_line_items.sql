{{ config(enabled=false) }}

select
    sol.*,
from {{ ref("shopify__order_lines") }} as sol