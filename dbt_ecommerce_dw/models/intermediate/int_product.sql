with productos as (
    select * from {{ ref('stg_productos') }}
),
categorias as (
    select * from {{ ref('stg_categorias') }}
)
select
    p.producto_id,
    p.nombre,
    p.descripcion,
    p.precio,
    c.categoria_id,
    c.nombre as categoria_nombre
from productos p
left join categorias c
    on p.categoria_id = c.categoria_id