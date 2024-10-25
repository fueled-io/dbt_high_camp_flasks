{{ config(
    materialized='ephemeral'
) }}

select
    id as order_id,
    created_at as created_at_timestamp,
    landing_site_ref as landing_site_base_url,
    cast({{ fivetran_utils.json_parse(string="customer", string_path=["id"]) }} as bigint) as customer_id,
    JSON_VALUE(billing_address, '$.address1') as billing_address_1,
    JSON_VALUE(billing_address, '$.address2') as billing_address_2,
    JSON_VALUE(billing_address, '$.city') as billing_city,
    JSON_VALUE(billing_address, '$.company') as billing_company,
    JSON_VALUE(billing_address, '$.country') as billing_country,
    JSON_VALUE(billing_address, '$.country_code') as billing_country_code,
    JSON_VALUE(billing_address, '$.first_name') as billing_first_name,
    JSON_VALUE(billing_address, '$.last_name') as billing_last_name,
    JSON_VALUE(billing_address, '$.latitude') as billing_latitude,
    JSON_VALUE(billing_address, '$.longitude') as billing_longitude,
    JSON_VALUE(billing_address, '$.name') as billing_name,
    JSON_VALUE(billing_address, '$.phone') as billing_phone,
    JSON_VALUE(billing_address, '$.province') as billing_province,
    JSON_VALUE(billing_address, '$.province_code') as billing_province_code,
    JSON_VALUE(billing_address, '$.zip') as billing_zip,
    *
from {{ source('shopify_prod_airbyte','orders') }}
