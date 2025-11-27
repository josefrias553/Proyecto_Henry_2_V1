select
    carrito_id,
    usuario_id,
    producto_id,
    cantidad,
    fecha_agregado
from {{ ref('stg_carrito') }}