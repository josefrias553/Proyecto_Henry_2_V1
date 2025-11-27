with src as (
    select * from {{ ref('int_order') }}
),
dim_status as (
    select status_code, order_status_sk from {{ ref('dim_order_status') }}
),
dim_time as (
    select date_value, date_sk from {{ ref('dim_time') }}
)
select
    {{ dbt_utils.generate_surrogate_key(['src.orden_id']) }} as order_sk,
    src.orden_id as order_id,
    dt.date_sk,
    ds.order_status_sk
from src
left join dim_status ds on lower(src.estado) = ds.status_code
left join dim_time dt on src.fecha_orden::date = dt.date_value