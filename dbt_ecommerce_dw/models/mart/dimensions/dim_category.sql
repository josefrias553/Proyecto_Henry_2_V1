{{ config(materialized='incremental', unique_key='category_id') }}

with src as (
    select * from {{ ref('int_category') }}
)

select
    src.categoria_id as category_id,
    src.nombre as name,
    src.descripcion
from src