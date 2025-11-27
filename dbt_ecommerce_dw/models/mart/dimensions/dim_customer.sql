{{ config(materialized='incremental', unique_key='customer_id') }}

with src as (
    select * from {{ ref('int_customer') }}
),

segment as (
    select customer_id, segment_sk
    from {{ ref('dim_customer_segment') }}
)

select
    u.customer_id,
    u.nombre,
    u.apellido,
    u.email,
    u.fecha_registro,
    s.segment_sk,
    true as current_flag,
    current_timestamp as eff_from,
    null as eff_to,
    null as notes
from src u
left join segment s on u.customer_id = s.customer_id