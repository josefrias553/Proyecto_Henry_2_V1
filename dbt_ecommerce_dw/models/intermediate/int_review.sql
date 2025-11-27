with resenas as (
    select * from {{ ref('stg_resenasproductos') }}
),
usuarios as (
    select * from {{ ref('stg_usuarios') }}
),
productos as (
    select * from {{ ref('stg_productos') }}
)
select
    r.resena_id,
    r.usuario_id,
    u.nombre as usuario_nombre,
    r.producto_id,
    p.nombre as producto_nombre,
    r.calificacion,
    length(r.comentario) as comment_length,
    r.fecha
from resenas r
join usuarios u on r.usuario_id = u.usuario_id
join productos p on r.producto_id = p.producto_id