with src as (
    select * from {{ ref('int_payment') }}
),
dim_method as (
    select payment_method_id, payment_method_sk from {{ ref('dim_payment_method') }}
),
dim_time as (
    select date_value, date_sk from {{ ref('dim_time') }}
),
fact_order as (
    select order_id, order_sk from {{ ref('fact_order') }}
)
select
    {{ dbt_utils.generate_surrogate_key(['src.pago_id']) }} as payment_sk,
    src.pago_id as payment_id,
    src.orden_id as order_id,
    fo.order_sk,
    dm.payment_method_sk,
    dt.date_sk,
    src.monto as amount,
    src.estado_pago as state_code,
    src.fecha_pago as created_at
from src
left join dim_method dm on src.metodo_pago_id = dm.payment_method_id
left join dim_time dt on src.fecha_pago::date = dt.date_value
left join fact_order fo on src.orden_id = fo.order_id