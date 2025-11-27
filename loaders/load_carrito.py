import csv
from sqlalchemy import exc
from datetime import datetime
from M2_V1.db import SessionLocal
from M2_V1.models import Carrito, Usuario, Producto
from M2_V1.utils import map_row_keys, exists_by_unique, get_csv_path

CSV_PATH = get_csv_path("7.carrito.csv")

def load_carrito(csv_path=CSV_PATH):
    with SessionLocal() as session:
        created = 0
        with open(csv_path, encoding="utf-8") as f:
            reader = csv.DictReader(f)

            for raw in reader:
                row = map_row_keys(raw)

                usuario_id = row.get("usuarioid")
                producto_id = row.get("productoid")
                cantidad = row.get("cantidad")

                if not usuario_id or not producto_id or not cantidad:
                    continue

                if not session.get(Usuario, int(usuario_id)):
                    continue
                if not session.get(Producto, int(producto_id)):
                    continue

                if exists_by_unique(session, Carrito, usuario_id=int(usuario_id), producto_id=int(producto_id)):
                    continue

                try:
                    cantidad_val = int(cantidad)
                except (TypeError, ValueError):
                    cantidad_val = 1

                fecha_raw = row.get("fechaagregado")
                fecha_agregado = None
                if fecha_raw:
                    try:
                        fecha_agregado = datetime.strptime(fecha_raw, "%Y-%m-%d %H:%M:%S")
                    except ValueError:
                        pass

                carrito_item = Carrito(
                    usuario_id=int(usuario_id),
                    producto_id=int(producto_id),
                    cantidad=cantidad_val,
                    fecha_agregado=fecha_agregado
                )

                session.add(carrito_item)
                created += 1

        try:
            session.commit()
        except exc.SQLAlchemyError:
            session.rollback()
            raise

        print(f"[Carrito] Inserciones: {created}")