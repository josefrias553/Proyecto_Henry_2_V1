{{ config(materialized='incremental', unique_key='payment_method_id') }}

with src as (
    select * from {{ ref('stg_metodospago') }}
)

select
    cast(src.metodo_pago_id as int) as payment_method_id,
    src.nombre as name,
    src.descripcion
from src