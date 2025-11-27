select
    producto_id,
    current_date as snapshot_date,
    stock,
    0 as stock_reserved,
    avg(precio) over () as avg_cost
from {{ ref('stg_productos') }}