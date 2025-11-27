with src as (
    select * from {{ ref('int_order_line') }}
),
dim_product as (
    select product_id, product_sk, categoria_id from {{ ref('dim_product') }} where current_flag = true
),
dim_category as (
    select category_id, category_sk from {{ ref('dim_category') }}
),
dim_time as (
    select date_value, date_sk from {{ ref('dim_time') }}
)
select
    {{ dbt_utils.generate_surrogate_key(['dt.date_sk','dp.product_sk','dc.category_sk']) }} as agg_id,
    dt.date_sk,
    dp.product_sk,
    dc.category_sk,
    sum(src.cantidad) as cantidad_total,
    sum(src.total) as ingreso_total,
    count(distinct src.orden_id) as numero_ordenes
from src
join dim_product dp on src.producto_id = dp.product_id
join dim_category dc on dp.categoria_id = dc.category_id
join dim_time dt on src.fecha_orden = dt.date_value
group by dt.date_sk, dp.product_sk, dc.category_sk
