# DbGardenTaller
## Taller SQL
```
use dbgarden;
```
##### 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
```
select o.codigo_oficina, c.nombre_ciudad
from oficina o
join codigo_postal cp on cp.cod_postal = o.codigo_postal
join ciudad c on c.codigo_ciudad = cp.codigo_ciudad;

+----------------+-------------------+
| codigo_oficina | nombre_ciudad     |
+----------------+-------------------+
| OF004          | Ciudad de México  |
| OF002          | Medellín          |
| OF008          | Barcelona         |
| OF001          | Bogotá            |
| OF007          | Madrid            |
| OF012          | Miami             |
| OF009          | Sevilla           |
| OF005          | Guadalajara       |
| OF006          | Monterrey         |
| OF003          | Cali              |
| OF011          | Houston           |
| OF010          | Los Ángeles       |
+----------------+-------------------+
```
##### 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

```
SELECT c.nombre_ciudad, t.fijo as "Numero fijo"
FROM tel_oficina t
JOIN oficina o ON o.codigo_oficina = t.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad c ON c.codigo_ciudad = cp.codigo_ciudad
JOIN region r ON r.codigo_region = c.codigo_region
JOIN pais p ON p.codigo_pais = r.codigo_pais
WHERE p.nombre_pais = "España";

+---------------+-------------+
| nombre_ciudad | Numero fijo |
+---------------+-------------+
| Madrid        | 4567890     |
| Barcelona     | 5678901     |
| Sevilla       | 6789012     |
+---------------+-------------+


```
#####  3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.  

```
SELECT e.nombre, CONCAT(e.apellido1 , " " , e.apellido2) as apellidos, e.email
FROM empleado e
WHERE e.codigo_jefe = 7;

+--------+---------------------+-----------------------------+
| nombre | apellidos           | email                       |
+--------+---------------------+-----------------------------+
| Juan   | Pérez López         | juan.perez@empresa.com      |
| Ana    | Gómez Martínez      | ana.gomez@empresa.com       |
| Luis   | Ruiz Sánchez        | luis.ruiz@empresa.com       |
| Elena  | Martínez García     | elena.martinez@empresa.com  |
| María  | López Fernández     | maria.lopez@empresa.com     |
| José   | Sánchez Rodríguez   | jose.sanchez@empresa.com    |
| Lucía  | Hernández Jiménez   | lucia.hernandez@empresa.com |
| Pedro  | García Vega         | pedro.garcia@empresa.com    |
| Laura  | Díaz Cruz           | laura.diaz@empresa.com      |
| Miguel | Torres Navarro      | miguel.torres@empresa.com   |
+--------+---------------------+-----------------------------+

```

##### 4 Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

```
SELECT ce.nombre_cargo as "nombre del puesto", e.nombre, CONCAT(e.apellido1 , " " , e.apellido2) as apellidos, e.email
FROM empleado e
JOIN cargo_empleado ce ON ce.codigo_cargo = e.codigo_cargo
WHERE e.codigo_jefe IS NULL;

+-------------------+--------+---------------+--------------------------+
| nombre del puesto | nombre | apellidos     | email                    |
+-------------------+--------+---------------+--------------------------+
| Gerente           | Carlos | Gómez Pérez   | carlos.gomez@empresa.com |
+-------------------+--------+---------------+--------------------------+


```
##### 5 Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantesde ventas.


```
SELECT e.nombre, CONCAT(e.apellido1 , " " , e.apellido2) as apellidos, ce.nombre_cargo
FROM empleado e
JOIN cargo_empleado ce ON ce.codigo_cargo = e.codigo_cargo
WHERE ce.nombre_cargo <> "Representante de ventas";

+--------+---------------------+---------------+
| nombre | apellidos           | nombre_cargo  |
+--------+---------------------+---------------+
| Carlos | Gómez Pérez         | Gerente       |
| María  | López Fernández     | Asistente     |
| Laura  | Díaz Cruz           | Asistente     |
| José   | Sánchez Rodríguez   | Desarrollador |
| Miguel | Torres Navarro      | Desarrollador |
| Lucía  | Hernández Jiménez   | Diseñador     |
+--------+---------------------+---------------+

```

##### 6. Devuelve un listado con el nombre de los todos los clientes españoles. 
```
SELECT c.nombre_cliente
FROM cliente c
JOIN codigo_postal cp on cp.cod_postal = c.codigo_postal
JOIN ciudad ci on ci.codigo_ciudad = cp.codigo_ciudad
JOIN region r on r.codigo_region = ci.codigo_region
JOIN pais p on p.codigo_pais = r.codigo_pais
WHERE p.nombre_pais = "España";

+------------------------+
| nombre_cliente         |
+------------------------+
| Cliente D              |
| Cliente E              |
| Cliente F              |
| Cliente J              |
| Cliente MOROSO         |
| Cliente de FUENLABRADA |
| Cliente que            |
| Cliente PIDENOPAGA     |
+------------------------+

```
##### 7.Devuelve un listado con los distintos estados por los que puede pasar un pedido

```
SELECT *
FROM estado_pedido;

+---------------+--------------------+
| codigo_estado | descripcion_estado |
+---------------+--------------------+
|             1 | entregado          |
|             2 | pendiente          |
|             3 | devuelto           |
|             4 | rechazado          |
+---------------+--------------------+

```
##### 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
- Utilizando la función YEAR de MySQL.
- Utilizando la función DATE_FORMAT de MySQL.
- Sin utilizar ninguna de las funciones anteriores */
--• Utilizando la función YEAR de MySQL.
```
SELECT c.codigo_cliente
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE YEAR(p.fecha_pago) = "2008";

+----------------+
| codigo_cliente |
+----------------+
|              1 |
|              4 |
|              7 |
|              9 |
+----------------+

```
-- • Utilizando la función DATE_FORMAT de MySQL.
```
SELECT c.codigo_cliente
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE DATE_FORMAT(p.fecha_pago,"%Y") = "2008";

+----------------+
| codigo_cliente |
+----------------+
|              1 |
|              4 |
|              7 |
|              9 |
+----------------+

```
-- • Sin utilizar ninguna de las funciones anteriores */
```
SELECT c.codigo_cliente
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_pago BETWEEN "2008-01-01" AND "2008-12-31";

+----------------+
| codigo_cliente |
+----------------+
|              1 |
|              4 |
|              7 |
|              9 |
+----------------+

```
##### 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

```
SELECT p.codigo_pedido, c.codigo_cliente, p.fecha_esperada, p.fecha_entrega
FROM cliente c
JOIN pedido p ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

+---------------+----------------+----------------+---------------+
| codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
+---------------+----------------+----------------+---------------+
|             2 |              2 | 2023-06-10     | 2023-06-12    |
|             4 |              4 | 2023-08-10     | 2023-08-14    |
|             7 |              7 | 2023-11-10     | 2023-11-13    |
|            10 |             10 | 2024-02-10     | 2024-02-12    |
|            12 |              1 | 2009-02-25     | 2024-02-06    |
+---------------+----------------+----------------+---------------+

```
##### 10 Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
• Utilizando la función ADDDATE de MySQL.
• Utilizando la función DATEDIFF de MySQL.
• ¿Sería posible resolver esta consulta utilizando el operador de suma + o
resta -? */

-- Utilizando la función ADDDATE de MySQL.
```

select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where P.fecha_entrega <= ADDDATE(P.fecha_esperada,  -2 );
 -- la logica seria. donde fecha de entrega sea menor o igual a la fecha esperada restandole 2 dias
```
-- Utilizando DATEDIFF
```
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where datediff(P.fecha_esperada , P.fecha_entrega) >= 2 ; -- La opcion DATEDIFF ME DEVUELVE UN NUMERO ENTERO, le resta la diferencia del primer parametro al segundo
```
-- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -? -- 
-- si es posible -- 
```
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where (P.fecha_esperada - P.fecha_entrega) >= 2 ;
```


##### 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
```
SELECT *
from pedido as p
JOIN estado_pedido as ep ON ep.codigo_estado = p.codigo_estado 
where DATE_FORMAT(p.fecha_pedido, '%Y') = 2009 AND ep.descripcion_estado = "rechazado" ;
+---------------+--------------+----------------+---------------+----------------------+----------------+---------------+---------------+--------------------+
| codigo_pedido | fecha_pedido | fecha_esperada | fecha_entrega | comentarios          | codigo_cliente | codigo_estado | codigo_estado | descripcion_estado |
+---------------+--------------+----------------+---------------+----------------------+----------------+---------------+---------------+--------------------+
|            14 | 2009-02-01   | 2009-02-25     | NULL          | rechazado por impago |              5 |             4 |             4 | rechazado          |
+---------------+--------------+----------------+---------------+----------------------+----------------+---------------+---------------+--------------------+

```
##### 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año. */ 
```
SELECT * 
from pedido as P
where DATE_FORMAT(P.fecha_pedido, '%m') = 01;

+---------------+--------------+----------------+---------------+-----------------------+----------------+---------------+
| codigo_pedido | fecha_pedido | fecha_esperada | fecha_entrega | comentarios           | codigo_cliente | codigo_estado |
+---------------+--------------+----------------+---------------+-----------------------+----------------+---------------+
|             9 | 2024-01-01   | 2024-01-10     | NULL          | Pedido aún pendiente  |              9 |             2 |
+---------------+--------------+----------------+---------------+-----------------------+----------------+---------------+

```
##### 13  Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
```
select p.codigo_cliente, p.id_transaccion, p.fecha_pago, p.total
from forma_pago as fp
JOIN pago p ON p.codigo_forma_pago = fp.codigo_forma_pago
JOIN cliente c ON c.codigo_cliente = p.codigo_cliente
where DATE_FORMAT(p.fecha_pago, '%Y') = 2008 AND fp.descripcion = "Paypal"
ORDER BY p.total DESC;

+----------------+----------------+------------+---------+
| codigo_cliente | id_transaccion | fecha_pago | total   |
+----------------+----------------+------------+---------+
|              9 | TXN0009        | 2008-06-10 | 3200.00 |
|              4 | TXN0004        | 2008-07-30 | 1250.00 |
+----------------+----------------+------------+---------+

```
##### 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
```
SELECT fp.descripcion
FROM forma_pago fp;

+---------------+
| descripcion   |
+---------------+
| Efectivo      |
| Tarjeta       |
| Transferencia |
| PayPal        |
| Cheque        |
+---------------+

```
##### 15 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock.  El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.  
```
 select *
 from producto as P
 where P.gama = "Ornamentales" and P.cantidad_en_stock > 100
 order by P.precio_venta desc;

 +-----------------+---------------+--------------+--------------+----------------------------+-------------------+--------------+------------------+------------------+
| codigo_producto | nombre        | gama         | dimiensiones | descripcion                | cantidad_en_stock | precio_venta | precio_proveedor | codigo_proovedor |
+-----------------+---------------+--------------+--------------+----------------------------+-------------------+--------------+------------------+------------------+
| P013            | Geranio       | Ornamentales | 25 cm        | Colorido geranio en maceta |               150 |         6.00 |             3.50 |                1 |
| P014            | PRODUCTO FEO  | Ornamentales | 25 cm        | color caca                 |               150 |         6.00 |             3.50 |                1 |
+-----------------+---------------+--------------+--------------+----------------------------+-------------------+--------------+------------------+------------------+

 ```
 ##### 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga  el código de empleado 11 o 30.

```
SELECT *
FROM cliente c
JOIN codigo_postal cp ON cp.cod_postal = c.codigo_postal
JOIN ciudad ci ON cp.codigo_ciudad = ci.codigo_ciudad
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE ci.nombre_ciudad = "Madrid" AND e.codigo_empleado = 11 OR e.codigo_empleado =30;
Empty set (0,00 sec)

```

  #### Consultas multitabla (Composición interna)  

 ##### 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas. 
```
SELECT c.nombre_cliente, CONCAT(e.nombre," ", e.apellido1)
FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

+------------------------+-----------------------------------+
| nombre_cliente         | CONCAT(e.nombre," ", e.apellido1) |
+------------------------+-----------------------------------+
| Cliente A              | Juan Pérez                        |
| Cliente B              | Ana Gómez                         |
| Cliente C              | Luis Ruiz                         |
| Cliente D              | Elena Martínez                    |
| Cliente E              | Juan Pérez                        |
| Cliente F              | Ana Gómez                         |
| Cliente G              | Luis Ruiz                         |
| Cliente H              | Elena Martínez                    |
| Cliente I              | Juan Pérez                        |
| Cliente J              | Ana Gómez                         |
| Cliente MOROSO         | Ana Gómez                         |
| Cliente de FUENLABRADA | Pedro García                      |
| Cliente que            | Pedro García                      |
| Cliente PIDENOPAGA     | Pedro García                      |
+------------------------+-----------------------------------+

```
##### 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas. 

```
SELECT c.nombre_cliente, CONCAT(e.nombre," ", e.apellido1) as nombre_representante
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

+------------------------+----------------------+
| nombre_cliente         | nombre_representante |
+------------------------+----------------------+
| Cliente A              | Juan Pérez           |
| Cliente F              | Ana Gómez            |
| Cliente MOROSO         | Ana Gómez            |
| Cliente de FUENLABRADA | Pedro García         |
| Cliente que            | Pedro García         |
| Cliente B              | Ana Gómez            |
| Cliente G              | Luis Ruiz            |
| Cliente C              | Luis Ruiz            |
| Cliente H              | Elena Martínez       |
| Cliente que            | Pedro García         |
| Cliente D              | Elena Martínez       |
| Cliente I              | Juan Pérez           |
| Cliente E              | Juan Pérez           |
| Cliente J              | Ana Gómez            |
+------------------------+----------------------+

```
##### 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas 
```
SELECT c.nombre_cliente, CONCAT(e.nombre," ", e.apellido1) as nombre_representante
FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente NOT IN (
    SELECT p.codigo_cliente
    FROM pago p
);
+--------------------+----------------------+
| nombre_cliente     | nombre_representante |
+--------------------+----------------------+
| Cliente PIDENOPAGA | Pedro García         |
+--------------------+----------------------+

```
##### 4.Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante 
```
SELECT c.nombre_cliente, e.nombre, ci.nombre_ciudad
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad ci ON cp.codigo_ciudad = ci.codigo_ciudad;
+------------------------+--------+---------------+
| nombre_cliente         | nombre | nombre_ciudad |
+------------------------+--------+---------------+
| Cliente A              | Juan   | Bogotá        |
| Cliente F              | Ana    | Medellín      |
| Cliente MOROSO         | Ana    | Medellín      |
| Cliente de FUENLABRADA | Pedro  | Cali          |
| Cliente que            | Pedro  | Cali          |
| Cliente B              | Ana    | Medellín      |
| Cliente G              | Luis   | Cali          |
| Cliente C              | Luis   | Cali          |
| Cliente H              | Elena  | Madrid        |
| Cliente que            | Pedro  | Cali          |
| Cliente D              | Elena  | Madrid        |
| Cliente I              | Juan   | Bogotá        |
| Cliente E              | Juan   | Bogotá        |
| Cliente J              | Ana    | Medellín      |
+------------------------+--------+---------------+

```
##### 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante 
```
SELECT c.nombre_cliente, e.nombre, ci.nombre_ciudad
FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad ci ON cp.codigo_ciudad = ci.codigo_ciudad
WHERE c.codigo_cliente NOT IN(
    SELECT p.codigo_cliente
    FROM pago p
);
+--------------------+--------+---------------+
| nombre_cliente     | nombre | nombre_ciudad |
+--------------------+--------+---------------+
| Cliente PIDENOPAGA | Pedro  | Cali          |
+--------------------+--------+---------------+
```
##### 6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada */ 
```
SELECT DISTINCT o.linea_direccion1
FROM oficina o
JOIN empleado e ON e.codigo_oficina = o.codigo_oficina
JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN codigo_postal cp ON cp.cod_postal = c.codigo_postal
JOIN ciudad ci ON ci.codigo_ciudad = cp.codigo_ciudad
WHERE ci.nombre_ciudad = "Fuenlabrada"; 
+-------------------+
| linea_direccion1  |
+-------------------+
| Avenida 3 # 45-67 |
+-------------------+
```
##### 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante 
```
SELECT c.nombre_cliente, CONCAT(e.nombre, " ", e.apellido1) , ci.nombre_ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o  ON o.codigo_oficina = e.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad ci ON ci.codigo_ciudad = cp.codigo_ciudad;
+------------------------+------------------------------------+---------------+
| nombre_cliente         | CONCAT(e.nombre, " ", e.apellido1) | nombre_ciudad |
+------------------------+------------------------------------+---------------+
| Cliente A              | Juan Pérez                         | Bogotá        |
| Cliente B              | Ana Gómez                          | Medellín      |
| Cliente C              | Luis Ruiz                          | Cali          |
| Cliente D              | Elena Martínez                     | Madrid        |
| Cliente E              | Juan Pérez                         | Bogotá        |
| Cliente F              | Ana Gómez                          | Medellín      |
| Cliente G              | Luis Ruiz                          | Cali          |
| Cliente H              | Elena Martínez                     | Madrid        |
| Cliente I              | Juan Pérez                         | Bogotá        |
| Cliente J              | Ana Gómez                          | Medellín      |
| Cliente MOROSO         | Ana Gómez                          | Medellín      |
| Cliente de FUENLABRADA | Pedro García                       | Cali          |
| Cliente que            | Pedro García                       | Cali          |
| Cliente PIDENOPAGA     | Pedro García                       | Cali          |
+------------------------+------------------------------------+---------------+
```

##### 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes. 
```
SELECT  CONCAT(j.nombre, " ", j.apellido1, " ", j.apellido2) as " nombre empleado" , CONCAT(e.nombre, " ", e.apellido1," ", e.apellido2) as " nombre jefe"
FROM empleado e
JOIN empleado j ON  j.codigo_jefe = e.codigo_empleado ;

+----------------------------+----------------------+
| nombre empleado            | nombre jefe          |
+----------------------------+----------------------+
| Juan Pérez López           | Carlos Gómez Pérez   |
| Ana Gómez Martínez         | Carlos Gómez Pérez   |
| Luis Ruiz Sánchez          | Carlos Gómez Pérez   |
| Elena Martínez García      | Carlos Gómez Pérez   |
| María López Fernández      | Carlos Gómez Pérez   |
| José Sánchez Rodríguez     | Carlos Gómez Pérez   |
| Lucía Hernández Jiménez    | Carlos Gómez Pérez   |
| Pedro García Vega          | Carlos Gómez Pérez   |
| Laura Díaz Cruz            | Carlos Gómez Pérez   |
| Miguel Torres Navarro      | Carlos Gómez Pérez   |
+----------------------------+----------------------+

```
#####  9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe 
```

SELECT e1.nombre AS empleado, e2.nombre AS jefe, e3.nombre AS jefe_del_jefe
FROM empleado as e1
JOIN empleado as e2 ON e1.codigo_jefe = e2.codigo_empleado 
LEFT JOIN empleado as e3 ON e2.codigo_jefe = e3.codigo_empleado;
+----------+--------+---------------+
| empleado | jefe   | jefe_del_jefe |
+----------+--------+---------------+
| Juan     | Carlos | NULL          |
| Ana      | Carlos | NULL          |
| Luis     | Carlos | NULL          |
| Elena    | Carlos | NULL          |
| María    | Carlos | NULL          |
| José     | Carlos | NULL          |
| Lucía    | Carlos | NULL          |
| Pedro    | Carlos | NULL          |
| Laura    | Carlos | NULL          |
| Miguel   | Carlos | NULL          |
+----------+--------+---------------+
```

##### 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido. 
```
SELECT DISTINCT c.nombre_cliente
FROM cliente as c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada OR p.fecha_entrega IS NULL;
+----------------+
| nombre_cliente |
+----------------+
| Cliente B      |
| Cliente D      |
| Cliente E      |
| Cliente G      |
| Cliente H      |
| Cliente I      |
| Cliente J      |
| Cliente A      |
+----------------+

SELECT COUNT(*) FROM pedido p
WHERE p.fecha_entrega > p.fecha_esperada OR p.fecha_entrega IS NULL; -- CONFIRMAR INFORMACION
+----------+
| COUNT(*) |
+----------+
|        9 |
+----------+

```
#####  11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente  
```
SELECT DISTINCT c.nombre_cliente, gp.gama
FROM cliente as c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido as dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto as pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto  as gp ON pr.gama = gp.gama
ORDER BY c.nombre_cliente, gp.gama;
+----------------+--------------+
| nombre_cliente | gama         |
+----------------+--------------+
| Cliente A      | Ornamentales |
| Cliente B      | Frutales     |
| Cliente C      | Aromaticas   |
| Cliente D      | Medicinales  |
| Cliente E      | Cactus       |
| Cliente E      | Ornamentales |
| Cliente F      | Suculentas   |
| Cliente G      | Carnivoras   |
| Cliente H      | Acuaticas    |
| Cliente I      | Trepadoras   |
| Cliente J      | Bulbosas     |
| Cliente J      | Ornamentales |
+----------------+--------------+
```
####  Consultas multitabla (Composición externa)
##### 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago. 
```
SELECT *
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.id_transaccion IS NULL;
+----------------+--------------------+-----------------+-------------------+----------+----------------------+------------------+---------------+----------------------------+----------------+----------------+----------------+------------+-------+-------------------+
| codigo_cliente | nombre_cliente     | nombre_contacto | apellido_contacto | fax      | linea_direccion1     | linea_direccion2 | codigo_postal | codigo_empleado_rep_ventas | limite_credito | codigo_cliente | id_transaccion | fecha_pago | total | codigo_forma_pago |
+----------------+--------------------+-----------------+-------------------+----------+----------------------+------------------+---------------+----------------------------+----------------+----------------+----------------+------------+-------+-------------------+
|             14 | Cliente PIDENOPAGA | pero            | NOPAGA            | 666-3456 | Calle yselas # 10-10 | NULL             | 28936         |                          9 |       75000.00 |           NULL | NULL           | NULL       |  NULL |              NULL |
+----------------+--------------------+-----------------+-------------------+----------+----------------------+------------------+---------------+----------------------------+----------------+----------------+----------------+------------+-------+-------------------+

```
##### 2. . Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido. 
```
SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_pedido IS NULL;
+------------------------+
| nombre_cliente         |
+------------------------+
| Cliente MOROSO         |
| Cliente de FUENLABRADA |
| Cliente que            |
+------------------------+

```
##### 3.  Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido  
```

SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente
WHERE p.codigo_pedido IS NULL and pa.id_transaccion IS NULL; 
Empty set (0,00 sec)

```

##### 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.  
```
SELECT *
FROM empleado e
WHERE e.codigo_oficina IS NULL;
Empty set (0,01 sec)

```
##### 5.  Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
```
SELECT e.nombre, e.apellido1
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;
+--------+------------+
| nombre | apellido1  |
+--------+------------+
| María  | López      |
| José   | Sánchez    |
| Carlos | Gómez      |
| Lucía  | Hernández  |
| Laura  | Díaz       |
| Miguel | Torres     |
+--------+------------+

```
##### 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
```
SELECT e.nombre, e.apellido1, o.codigo_oficina
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NULL;
+--------+------------+----------------+
| nombre | apellido1  | codigo_oficina |
+--------+------------+----------------+
| María  | López      | OF008          |
| José   | Sánchez    | OF009          |
| Carlos | Gómez      | OF001          |
| Lucía  | Hernández  | OF002          |
| Laura  | Díaz       | OF007          |
| Miguel | Torres     | OF008          |
+--------+------------+----------------+

```
##### 7. Devuelve un listado que muestre los empleados que no tienen una oficinaasociada y los que no tienen un cliente asociado. 
```
SELECT * 
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL AND e.codigo_oficina is NULL;
Empty set (0,01 sec)

```
##### 8.  Devuelve un listado de los productos que nunca han aparecido en un pedido. 
```
SELECT p.codigo_producto, p.nombre
FROM producto p
LEFT JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
WHERE d.codigo_pedido is null;
+-----------------+---------------+
| codigo_producto | nombre        |
+-----------------+---------------+
| P014            | PRODUCTO FEO  |
+-----------------+---------------+
```
##### 9. . Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto. 
```
SELECT p.codigo_producto, p.nombre, p.descripcion ,g.imagen
FROM producto p
LEFT JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
JOIN gama_producto g ON g.gama = p.gama
WHERE d.codigo_pedido is null;
+-----------------+---------------+-------------+---------------------------+
| codigo_producto | nombre        | descripcion | imagen                    |
+-----------------+---------------+-------------+---------------------------+
| P014            | PRODUCTO FEO  | color caca  | imagenes/ornamentales.jpg |
+-----------------+---------------+-------------+---------------------------+

```
##### 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales  
```
SELECT o.codigo_oficina
FROM oficina o
WHERE o.codigo_oficina NOT IN (SELECT o.codigo_oficina
FROM oficina o
LEFT JOIN empleado e ON e.codigo_oficina = o.codigo_oficina
JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN pedido p ON p.codigo_cliente = c.codigo_cliente
JOIN detalle_pedido d ON d.codigo_pedido = p.codigo_pedido
JOIN producto pr ON pr.codigo_producto = d.codigo_producto
WHERE pr.gama = "Frutales");
+----------------+
| codigo_oficina |
+----------------+
| OF004          |
| OF008          |
| OF001          |
| OF007          |
| OF012          |
| OF009          |
| OF005          |
| OF006          |
| OF003          |
| OF011          |
| OF010          |
+----------------+
```

##### 11. . Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago 
```
SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
WHERE p.id_transaccion is NULL;
+--------------------+
| nombre_cliente     |
+--------------------+
| Cliente PIDENOPAGA |
+--------------------+
```
##### 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado. 
```
SELECT e.* , j.nombre
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;
+-----------------+--------+------------+------------+-----------+-----------------------------+----------------+-------------+--------------+--------+
| codigo_empleado | nombre | apellido1  | apellido2  | extension | email                       | codigo_oficina | codigo_jefe | codigo_cargo | nombre |
+-----------------+--------+------------+------------+-----------+-----------------------------+----------------+-------------+--------------+--------+
|               5 | María  | López      | Fernández  | 1006      | maria.lopez@empresa.com     | OF008          |           7 |            2 | Carlos |
|               6 | José   | Sánchez    | Rodríguez  | 1007      | jose.sanchez@empresa.com    | OF009          |           7 |            3 | Carlos |
|               8 | Lucía  | Hernández  | Jiménez    | 1008      | lucia.hernandez@empresa.com | OF002          |           7 |            4 | Carlos |
|              10 | Laura  | Díaz       | Cruz       | 1010      | laura.diaz@empresa.com      | OF007          |           7 |            2 | Carlos |
|              11 | Miguel | Torres     | Navarro    | 1011      | miguel.torres@empresa.com   | OF008          |           7 |            3 | Carlos |
+-----------------+--------+------------+------------+-----------+-----------------------------+----------------+-------------+--------------+--------+

```
#### CONSULTA RESUMEN 

##### 1. ¿Cuántos empleados hay en la compañía?
```
SELECT COUNT(*)
FROM empleado;
+----------+
| COUNT(*) |
+----------+
|       11 |
+----------+

```
##### 2. ¿Cuántos clientes tiene cada país?
```
SELECT p.nombre_pais, COUNT(cl.codigo_cliente)
FROM pais p
JOIN region r ON r.codigo_pais = p.codigo_pais
JOIN ciudad c ON c.codigo_region = r.codigo_region
JOIN codigo_postal cp ON cp.codigo_ciudad = c.codigo_ciudad
JOIN cliente cl ON cl.codigo_postal = cp.cod_postal
GROUP BY p.nombre_pais;
+-------------+--------------------------+
| nombre_pais | COUNT(cl.codigo_cliente) |
+-------------+--------------------------+
| Colombia    |                        6 |
| España      |                        8 |
+-------------+--------------------------+
```
##### 3. ¿Cuál fue el pago medio en 2009?
```
SELECT AVG(p.total)
FROM pago p
WHERE YEAR(p.fecha_pago) = '2009';
+--------------+
| AVG(p.total) |
+--------------+
|  1916.666667 |
+--------------+
```
##### 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
```
SELECT e.descripcion_estado, COUNT(p.codigo_estado)
FROM estado_pedido e
LEFT JOIN pedido p ON p.codigo_estado = e.codigo_estado
GROUP BY e.descripcion_estado;
+--------------------+------------------------+
| descripcion_estado | COUNT(p.codigo_estado) |
+--------------------+------------------------+
| entregado          |                     10 |
| pendiente          |                      3 |
| devuelto           |                      0 |
| rechazado          |                      1 |
+--------------------+------------------------+

```
##### 5 Calcula el precio de venta del producto más caro y más barato en unamisma consulta 

```
SELECT MAX(p.precio_venta) as "Producto mas caro", MIN(p.precio_venta) as "Producto mas barato"
FROM producto p;
+-------------------+---------------------+
| Producto mas caro | Producto mas barato |
+-------------------+---------------------+
|             50.00 |                3.50 |
+-------------------+---------------------+

```
##### 6 Calcula el número de clientes que tiene la empresa 
```
SELECT COUNT(c.codigo_cliente)
FROM cliente c;
+-------------------------+
| COUNT(c.codigo_cliente) |
+-------------------------+
|                      14 |
+-------------------------+

```
##### 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid? 
```
SELECT COUNT(c.codigo_cliente)
FROM cliente c
JOIN codigo_postal cp ON cp.cod_postal = c.codigo_postal
JOIN ciudad ci ON ci.codigo_ciudad = cp.codigo_ciudad
WHERE ci.nombre_ciudad = "Madrid";
+-------------------------+
| COUNT(c.codigo_cliente) |
+-------------------------+
|                       3 |
+-------------------------+
```

##### 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezanpor M? 
```
SELECT  ci.nombre_ciudad, COUNT(c.codigo_cliente)
FROM ciudad ci
JOIN codigo_postal cp ON ci.codigo_ciudad = cp.codigo_ciudad
LEFT JOIN cliente c ON cp.cod_postal = c.codigo_postal
WHERE ci.nombre_ciudad LIKE 'M%'
GROUP BY ci.nombre_ciudad;

+---------------+-------------------------+
| nombre_ciudad | COUNT(c.codigo_cliente) |
+---------------+-------------------------+
| Medellín      |                       2 |
| Monterrey     |                       0 |
| Madrid        |                       3 |
| Miami         |                       0 |
+---------------+-------------------------+

```
##### 9. Devuelve el nombre de los representantes de ventas y el número de clientesal que atiende cada uno.
```
SELECT e.nombre, COUNT(c.codigo_cliente)
FROM empleado e
JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
GROUP BY e.nombre;
+--------+-------------------------+
| nombre | COUNT(c.codigo_cliente) |
+--------+-------------------------+
| Juan   |                       3 |
| Ana    |                       4 |
| Luis   |                       2 |
| Elena  |                       2 |
| Pedro  |                       3 |
+--------+-------------------------+

```
##### 10.  Calcula el número de clientes que no tiene asignado representante de ventas.
```
SELECT COUNT(c.codigo_cliente)
FROM cliente c
WHERE c.codigo_empleado_rep_ventas IS NULL;
+-------------------------+
| COUNT(c.codigo_cliente) |
+-------------------------+
|                       0 |
+-------------------------+

```
##### 11  Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
```
SELECT CONCAT(c.nombre_cliente, c.apellido_contacto) as nombre, MAX(p.fecha_pago), MIN(p.fecha_pago)
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
GROUP BY nombre;
+-------------------------------+-------------------+-------------------+
| nombre                        | MAX(p.fecha_pago) | MIN(p.fecha_pago) |
+-------------------------------+-------------------+-------------------+
| Cliente ARojas                | 2008-01-15        | 2008-01-15        |
| Cliente BLópez                | 2023-03-22        | 2023-03-22        |
| Cliente CGarcía               | 2023-05-18        | 2023-05-18        |
| Cliente DPérez                | 2008-07-30        | 2008-07-30        |
| Cliente EMartínez             | 2023-09-14        | 2023-09-14        |
| Cliente FGómez                | 2023-11-05        | 2023-11-05        |
| Cliente GHernández            | 2008-04-25        | 2008-04-25        |
| Cliente HRamírez              | 2023-12-01        | 2023-12-01        |
| Cliente IFernández            | 2008-06-10        | 2008-06-10        |
| Cliente JSánchez              | 2023-02-20        | 2023-02-20        |
| Cliente MOROSOSánchez         | 2009-01-15        | 2009-01-15        |
| Cliente de FUENLABRADALABRADA | 2009-03-22        | 2009-03-22        |
| Cliente quenopide             | 2024-05-30        | 2009-05-18        |
+-------------------------------+-------------------+-------------------+
```
##### 12 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
```
SELECT dp.codigo_pedido, COUNT(DISTINCT dp.codigo_producto) AS productos_diferentes
FROM detalle_pedido dp
GROUP BY dp.codigo_pedido;
+---------------+----------------------+
| codigo_pedido | productos_diferentes |
+---------------+----------------------+
|             1 |                    1 |
|             2 |                    1 |
|             3 |                    1 |
|             4 |                    1 |
|             5 |                    1 |
|             6 |                    1 |
|             7 |                    1 |
|             8 |                    1 |
|             9 |                    1 |
|            10 |                    1 |
|            11 |                    1 |
|            12 |                    1 |
|            14 |                    1 |
+---------------+----------------------+

```
##### 13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
```
SELECT p.nombre, SUM(d.cantidad)
FROM producto p
JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
JOIN pedido pe ON pe.codigo_pedido = d.codigo_pedido
GROUP BY p.nombre;
+------------------------+-----------------+
| nombre                 | SUM(d.cantidad) |
+------------------------+-----------------+
| Rosa Roja              |              10 |
| Manzano                |               5 |
| Menta                  |              15 |
| Aloe Vera              |               8 |
| Cactus Esférico        |              12 |
| Suculenta Echeveria    |              20 |
| Dionea Muscipula       |               7 |
| Nenúfar                |               9 |
| Enredadera             |              10 |
| Tulipán                |              14 |
| Orquídea Phalaenopsis  |               5 |
| Bonsái Ficus           |               3 |
| Geranio                |              12 |
+------------------------+-----------------+

```

##### 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenadopor el número total de unidades vendidas.
```
SELECT p.nombre, SUM(dp.cantidad) AS unidades_vendidas
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY  p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 20;
+------------------------+-------------------+
| nombre                 | unidades_vendidas |
+------------------------+-------------------+
| Suculenta Echeveria    |                20 |
| Menta                  |                15 |
| Tulipán                |                14 |
| Cactus Esférico        |                12 |
| Geranio                |                12 |
| Rosa Roja              |                10 |
| Enredadera             |                10 |
| Nenúfar                |                 9 |
| Aloe Vera              |                 8 |
| Dionea Muscipula       |                 7 |
| Manzano                |                 5 |
| Orquídea Phalaenopsis  |                 5 |
| Bonsái Ficus           |                 3 |
+------------------------+-------------------+

```
##### 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
```
SELECT 
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS IVA,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp;

+----------------+----------+-----------------+
| base_imponible | IVA      | total_facturado |
+----------------+----------+-----------------+
|        1521.50 | 319.5150 |       1841.0150 |
+----------------+----------+-----------------+
```
##### 16. La misma información que en la pregunta anterior, pero agrupada por código de producto 
```
SELECT dp.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS IVA,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
GROUP BY dp.codigo_producto;

+-----------------+----------------+---------+-----------------+
| codigo_producto | base_imponible | IVA     | total_facturado |
+-----------------+----------------+---------+-----------------+
| P001            |          50.00 | 10.5000 |         60.5000 |
| P002            |         125.00 | 26.2500 |        151.2500 |
| P003            |          52.50 | 11.0250 |         63.5250 |
| P004            |          80.00 | 16.8000 |         96.8000 |
| P005            |         144.00 | 30.2400 |        174.2400 |
| P006            |         160.00 | 33.6000 |        193.6000 |
| P007            |         105.00 | 22.0500 |        127.0500 |
| P008            |         180.00 | 37.8000 |        217.8000 |
| P009            |         180.00 | 37.8000 |        217.8000 |
| P010            |          98.00 | 20.5800 |        118.5800 |
| P011            |         125.00 | 26.2500 |        151.2500 |
| P012            |         150.00 | 31.5000 |        181.5000 |
| P013            |          72.00 | 15.1200 |         87.1200 |
+-----------------+----------------+---------+-----------------+

```
##### 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR 
```
SELECT dp.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS IVA,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
WHERE dp.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;
```
##### 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
```
SELECT p.nombre, SUM(dp.cantidad),
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM producto p
JOIN detalle_pedido  dp ON dp.codigo_producto = p.codigo_producto
GROUP BY p.nombre
HAVING total_facturado > 3000;
```
##### 19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos. 
```
SELECT YEAR(p.fecha_pago), SUM(p.total)
FROM pago p
GROUP BY YEAR(p.fecha_pago);
```
-- /////// SUBCONSULTAS \\\\\\\\\\\\

-- 1. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT c.nombre_cliente
FROM cliente c
WHERE c.limite_credito = (
  SELECT MAX(c.limite_credito)
  FROM cliente c
  );
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT p.nombre
FROM producto p
WHERE p.precio_venta = (
  SELECT MAX(p.precio_venta)
  FROM producto p
  );

/* Devuelve el nombre del producto del que se han vendido más unidades.
(Tenga en cuenta que tendrá que calcular cuál es el número total de
unidades que se han vendido de cada producto a partir de los datos de la
tabla detalle_pedido */
SELECT p.nombre
FROM producto p
WHERE p.codigo_producto = (
  SELECT dp.codigo_producto 
  FROM detalle_pedido dp
  GROUP BY dp.codigo_producto
  ORDER BY  SUM(dp.cantidad)  DESC
  LIMIT 1
);

/* 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
realizado. (Sin utilizar INNER JOIN). */

SELECT c.nombre_cliente
FROM cliente c
WHERE c.limite_credito > (
  SELECT SUM(p.total)
    FROM pago p
    WHERE c.codigo_cliente = p.codigo_cliente
); -- se puede usar COALESCE para manejar casos donde el pago se NULL
   -- y manejarlo como un cero;
SELECT c.nombre_cliente
FROM cliente c
WHERE c.limite_credito > (
    SELECT COALESCE(SUM(p.total), 0)
    FROM pago p
    WHERE c.codigo_cliente = p.codigo_cliente
);

/* 5. . Devuelve el producto que más unidades tiene en stock. */
SELECT p.nombre
FROM producto p
WHERE p.cantidad_en_stock = (
  SELECT MAX(dp.cantidad_en_stock)
  FROM producto dp
  
);

/* 6.6. Devuelve el producto que menos unidades tiene en stock.
*/
SELECT p.nombre
FROM producto p
WHERE p.cantidad_en_stock = (
  SELECT MIN(dp.cantidad_en_stock)
  FROM producto dp
);

/* 7. Devuelve el nombre, los apellidos y el email de los empleados que están a
cargo de Alberto Soria
*/
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Carlos' AND apellido1 = 'Gómez'
);

/*8 Devuelve el nombre del cliente con mayor límite de crédito. */ 
SELECT c.nombre_cliente
FROM cliente c
WHERE limite_credito >= ALL (
    SELECT c.limite_credito
    FROM cliente c
);
--9. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT p.nombre
FROM producto p
WHERE p.precio_venta >= ALL (
    SELECT precio_venta
    FROM producto
);

--10.  Devuelve el producto que menos unidades tiene en stock.
SELECT p.nombre
FROM producto p
WHERE p.cantidad_en_stock <= ALL (
    SELECT p.cantidad_en_stock
    FROM producto p
);

-- 11.. Devuelve el nombre, apellido1 y cargo de los empleados que no
representen a ningún cliente.
SELECT nombre, apellido1, (SELECT nombre_cargo FROM cargo_empleado WHERE codigo_cargo = empleado.codigo_cargo) AS cargo
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NOT NULL);

/* 12. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago */
SELECT *
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);


/* 13 Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago */
SELECT *
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);


/*14. Devuelve un listado de los productos que nunca han aparecido en un
pedido.*/

SELECT *
FROM producto
WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);

/*15  Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.*/
SELECT e.nombre, e.apellido1, (SELECT nombre_cargo FROM cargo_empleado WHERE codigo_cargo = e.codigo_cargo) AS cargo, tel_oficina.fijo
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN tel_oficina ON e.codigo_oficina = tel_oficina.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NOT NULL);


/*16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales*/

SELECT *
FROM oficina
WHERE codigo_oficina NOT IN (SELECT DISTINCT codigo_oficina FROM empleado WHERE codigo_empleado IN 
                                (SELECT DISTINCT codigo_jefe FROM empleado WHERE codigo_empleado IN 
                                    (SELECT DISTINCT codigo_empleado_rep_ventas FROM cliente WHERE codigo_cliente IN 
                                        (SELECT DISTINCT codigo_cliente FROM pedido WHERE codigo_pedido IN 
                                            (SELECT DISTINCT codigo_pedido FROM detalle_pedido WHERE codigo_producto IN 
                                                (SELECT codigo_producto FROM producto WHERE gama = 'Frutales'))))));


/*17.Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.*/

SELECT *
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pedido) AND codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*18.Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago */
SELECT *
FROM cliente c
WHERE NOT EXISTS (SELECT * FROM pago WHERE codigo_cliente = c.codigo_cliente);
/*19 Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago*/
SELECT *
FROM cliente c
WHERE EXISTS (SELECT * FROM pago WHERE codigo_cliente = c.codigo_cliente);

/* 20 Devuelve un listado de los productos que nunca han aparecido en un */

SELECT *
FROM producto p
WHERE NOT EXISTS (SELECT * FROM detalle_pedido WHERE codigo_producto = p.codigo_producto);

-- 21 Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

SELECT DISTINCT codigo_producto
FROM detalle_pedido;

-- /////////////  Subconsultas correlacionadas \\\\\\\\\\\\\\\
-- 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS pedidos_realizados
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.codigo_cliente;
-- 2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.

SELECT c.nombre_cliente, COALESCE(SUM(pa.total), 0) AS total_pagado
FROM cliente c
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
GROUP BY c.codigo_cliente;

--3.Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente ASC;

/* 4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la 
oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.*/
SELECT c.nombre_cliente, e.nombre, e.apellido1, tof.fijo AS telefono_oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN tel_oficina tof ON e.codigo_oficina = tof.codigo_oficina
WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
--5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

SELECT c.nombre_cliente, e.nombre, e.apellido1, ci.nombre_ciudad AS ciudad_oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
JOIN ciudad ci ON o.codigo_postal = ci.codigo_ciudad;

--6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representantes de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, ce.nombre_cargo AS puesto, tof.fijo AS telefono_oficina
FROM empleado e
JOIN cargo_empleado ce ON e.codigo_cargo = ce.codigo_cargo
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
JOIN tel_oficina tof ON e.codigo_oficina = tof.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NOT NULL);

-- 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT ci.nombre_ciudad AS ciudad_oficina, COUNT(e.codigo_empleado) AS numero_empleados
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
JOIN ciudad ci ON o.codigo_postal = ci.codigo_ciudad
GROUP BY ci.nombre_ciudad;
