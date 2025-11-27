with src as (
    select * from {{ ref('int_inventory_snapshot') }}
),
dim_product as (
    select product_id, product_sk from {{ ref('dim_product') }} where current_flag = true
),
dim_time as (
    select date_value, date_sk from {{ ref('dim_time') }}
)
select
    {{ dbt_utils.generate_surrogate_key(['src.producto_id','src.snapshot_date']) }} as inventory_sk,
    dp.product_sk,
    dt.date_sk,
    src.stock,
    src.stock_reserved,
    src.avg_cost,
    current_timestamp as created_at
from src
left join dim_product dp on src.producto_id = dp.product_id
left join dim_time dt on src.snapshot_date = dt.date_value