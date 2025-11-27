# 📘 Documentación y Justificación del Diseño del Data Warehouse

## 🎯 Enfoque Metodológico
El modelo se diseñó siguiendo la metodología **Kimball**, que propone un esquema en estrella donde:
- Las **tablas de hechos** capturan eventos medibles del negocio.
- Las **dimensiones** permiten filtrar, segmentar y contextualizar esos hechos.

El objetivo central fue responder preguntas de negocio clave relacionadas con **ventas**, **pagos**, **usuarios**, **productos** y **stock**.

---

## 🛒 Hechos Seleccionados
Cada tabla de hechos se definió con un **grain** (nivel de detalle) claro y específico:

### **fact_order** (nivel orden)
- Captura cada orden realizada.
- **Justificación:** permite medir ticket promedio, cantidad de órdenes y variación mensual.

### **fact_order_line** (nivel ítem)
- Registra cada producto dentro de una orden.
- **Justificación:** habilita análisis de productos más vendidos, volumen por categoría y ventas por día.

### **fact_payment**
- Registra cada pago asociado a una orden.
- **Justificación:** responde preguntas sobre métodos de pago, montos promedio y pagos fallidos o en proceso.

### **fact_inventory_snapshot**
- Snapshot diario del stock por producto.
- **Justificación:** permite analizar disponibilidad, faltantes y la relación stock vs ventas.

### **fact_order_accum**
- Acumula fechas clave del ciclo de vida de una orden.
- **Justificación:** mide tiempos de procesamiento, envío y entrega.

### **fact_ventas_agg_daily**
- Agregados diarios por producto y categoría.
- **Justificación:** optimiza consultas sobre ingresos y volumen por día para análisis de alto nivel.

> **Cada hecho fue elegido porque representa un evento medible directamente asociado a una pregunta de negocio.**

---

## 👤 Dimensiones y Estrategia SCD
Las dimensiones se diseñaron para permitir análisis flexibles en múltiples ejes. Se aplicaron estrategias de **Slowly Changing Dimensions (SCD)** de acuerdo con la naturaleza de cada dimensión:

### **dim_customer — SCD2**
- Cambian atributos como email, teléfono o segmento.
- Se requiere historial para análisis de comportamiento y fidelidad.

### **dim_product — SCD2 parcial**
- Cambian precio, estado o categoría.
- Se conserva historial de atributos críticos como precio o estado activo.

### **dim_address — SCD2**
- Las direcciones cambian con frecuencia.
- Necesario preservar la dirección vigente al momento del envío.

### **dim_category — SCD2 / SCD3**
- Las jerarquías pueden reorganizarse.
- Puede aplicarse SCD2 para historial completo o SCD3 si sólo interesa estado previo y actual.

### **dim_customer_segment — SCD1**
- Cambios no requieren historial.
- Reglas de segmentación se sobrescriben.

### **dim_payment_method — SCD1**
- Métodos de pago son estáticos.
- Suficiente con sobrescribir cambios.

### **dim_order_status — SCD1**
- Estados del flujo transaccional no requieren versiones históricas.

### **dim_review — SCD1**
- Cada reseña es un evento único y no se actualiza.

---

## 🔗 Relaciones
- Cada tabla de hechos se conecta a sus dimensiones mediante **surrogate keys** (`*_sk`).
- Las relaciones son **1:N**, donde una dimensión describe múltiples registros en una tabla de hechos.

Ejemplos:
- Un cliente en **dim_customer** puede tener muchas órdenes en **fact_order**.
- Un producto en **dim_product** puede aparecer en múltiples líneas de **fact_order_line**.

---

## ✅ Conclusión
Las decisiones de diseño se tomaron para garantizar:

- Granularidad precisa en cada tabla de hechos.  
- Conservación del historial en dimensiones críticas mediante SCD2.  
- Optimización de consultas analíticas con snapshots y agregados diarios.  
- Simplicidad y performance en dimensiones estáticas mediante SCD1.  

El resultado es un **modelo lógico robusto, escalable y alineado a las preguntas de negocio**, permitiendo análisis confiables y eficientes.
