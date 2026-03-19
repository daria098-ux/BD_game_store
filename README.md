# Sistema de Base de Datos - Tienda de Videojuegos
#### ¡Bienvenido! 

Este proyecto nace de un problema ficticio que fue planteado en clase; consiste en el diseño e implementación de una base de datos para una tienda de videojuegos
con múltiples sucursales que tiene múltiples necesidades, como el poder organizar el caos que supone gestionar las tiendas y permitir que los productos lleguen a los jugadores,
que el inventario nunca se quede en cero y que las ventas fluyan sin errores.

##### El sistema está basado en un modelo relacional y le podemos poner el objetivo de gestionar las principales entidades que pudimos identificar para el negocio.
| Productos, en este caso videojuegos y accesorios, etc.  |
| ------------ |
|Clientes los principales compradores en las tiendas.  |
|Empleados que trabajan en cada una de las sucursales. |
|Sucursales que hay en esta cadena de tiendas.  |
|Inventario por cada sucursal. |
|Productos, en este caso videojuegos y accesorios, etc.  |
|Ventas de cada sucursal.|
|Proveedores que tiene la cadena de tienda en general  |
|Almacén de todas las tiendas. |
|Boletos de cada compra. |
|Roles de los empleados. |
|Departamentos que hay en cada sucursal.|

---

#### Las funcionalidades que queremos que tenga este sistema en general:

- Poder tener un control de inventario por sucursal.

- Tener un registro de ventas con detalles.

- Las relaciones de productos con proveedores

- La auditoría de operaciones que se hacen.

- Uso de triggers para automatización.

- Procedimientos almacenados para inserciones.

- Las vistas como reportes para el análisis.

#### Las características técnicas principales son el uso de claves primarias y extranjeras, normalización de datos, activadores para actualización automática, vistas para informes y procedimientos almacenados.
---
#### Los reportes que se hacen en esta base de datos son hechos directamente con vistas; en ellos se incluyen reportes para el análisis de datos.
1. Inventario por sucursal: el inventario que hay en cada tienda.

2. Reporte de ventas por cliente: ¿Quiénes son nuestros clientes más recurrentes?

3. Reporte productos más vendidos: ¿Cuáles son los productos más vendidos en todas las sucursales?

4. Reporte fidelidad: ¿Quiénes son nuestros clientes más recurrentes?

5. Reporte stock crítico: ¿Qué sucursal necesita reabastecimiento urgente?

-------- 

###### Este proyecto es de carácter educativo.

