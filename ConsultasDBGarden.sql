-- Active: 1717105247149@@127.0.0.1@3306@dbGarden
use dbgarden;

--1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select o.codigo_oficina, c.nombre_ciudad
from oficina o
join codigo_postal cp on cp.cod_postal = o.codigo_postal
join ciudad c on c.codigo_ciudad = cp.codigo_ciudad;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT c.nombre_ciudad, t.fijo as "Numero fijo"
FROM tel_oficina t
JOIN oficina o ON o.codigo_oficina = t.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad c ON c.codigo_ciudad = cp.codigo_ciudad
JOIN region r ON r.codigo_region = c.codigo_region
JOIN pais p ON p.codigo_pais = r.codigo_pais
WHERE P.nombre_pais = "España";


/* 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
jefe tiene un código de jefe igual a 7. */ 

SELECT e.nombre, CONCAT(e.apellido1 , " " , e.apellido2) as apellidos, e.email
FROM empleado e
WHERE e.codigo_jefe = 7;

/*4 Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa. */ 

SELECT ce.nombre_cargo as "nombre del puesto", e.nombre, CONCAT(e.apellido1 , " " , e.apellido2) as apellidos, e.email
FROM empleado e
JOIN cargo_empleado ce ON ce.codigo_cargo = e.codigo_cargo
WHERE e.codigo_jefe IS NULL;

/*5 Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas. */

SELECT e.nombre, CONCAT(e.apellido1 , " " , e.apellido2) as apellidos, ce.nombre_cargo
FROM empleado e
JOIN cargo_empleado ce ON ce.codigo_cargo = e.codigo_cargo
WHERE ce.nombre_cargo <> "Representante de ventas";


/* 6. Devuelve un listado con el nombre de los todos los clientes españoles. */

SELECT c.nombre_cliente
FROM cliente c
JOIN codigo_postal cp on cp.cod_postal = c.codigo_postal
JOIN ciudad ci on ci.codigo_ciudad = cp.codigo_ciudad
JOIN region r on r.codigo_region = ci.codigo_region
JOIN pais p on p.codigo_pais = r.codigo_pais
WHERE p.nombre_pais = "España";

/* 7.Devuelve un listado con los distintos estados por los que puede pasar un
pedido */

SELECT *
FROM estado_pedido;

/* 8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
• Utilizando la función YEAR de MySQL.
• Utilizando la función DATE_FORMAT de MySQL.
• Sin utilizar ninguna de las funciones anteriores */
--• Utilizando la función YEAR de MySQL.
SELECT c.codigo_cliente
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE YEAR(p.fecha_pago) = "2008";
-- • Utilizando la función DATE_FORMAT de MySQL.
SELECT c.codigo_cliente
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE DATE_FORMAT(p.fecha_pago,"%Y") = "2008";

-- • Sin utilizar ninguna de las funciones anteriores */

SELECT c.codigo_cliente
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_pago BETWEEN "2008-01-01" AND "2008-12-31";

/* 9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo. */ 

SELECT p.codigo_pedido, c.codigo_cliente, p.fecha_esperada, p.fecha_entrega
FROM cliente c
JOIN pedido p ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

/* 10 Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
• Utilizando la función ADDDATE de MySQL.
• Utilizando la función DATEDIFF de MySQL.
• ¿Sería posible resolver esta consulta utilizando el operador de suma + o
resta -? */

-- Utilizando la función ADDDATE de MySQL.
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where P.fecha_entrega <= ADDDATE(P.fecha_esperada,  -2 );
 -- la logica seria. donde fecha de entrega sea menor o igual a la fecha esperada restandole 2 dias
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where datediff(P.fecha_esperada , P.fecha_entrega) >= 2 ; -- La opcion DATEDIFF ME DEVUELVE UN NUMERO ENTERO, le resta la diferencia del primer parametro al segundo

-- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -? -- 
-- si es posible -- 
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where (P.fecha_esperada - P.fecha_entrega) >= 2 ;



--11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT *
from pedido as p
JOIN estado_pedido as ep ON ep.codigo_estado = p.codigo_estado 
where DATE_FORMAT(p.fecha_pedido, '%Y') = 2009 AND ep.descripcion_estado = "rechazado" ;

/* 12. Devuelve un listado de todos los pedidos que han sido entregados en el
mes de enero de cualquier año. */ 
SELECT * 
from pedido as P
where DATE_FORMAT(P.fecha_pedido, '%m') = 01;

-- 13  Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select p.codigo_cliente, p.id_transaccion, p.fecha_pago, p.total
from forma_pago as fp
JOIN pago p ON p.codigo_forma_pago = fp.codigo_forma_pago
JOIN cliente c ON c.codigo_cliente = p.codigo_cliente
where DATE_FORMAT(p.fecha_pago, '%Y') = 2008 AND fp.descripcion = "Paypal"
ORDER BY p.total DESC;

/* 14. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas. */

SELECT fp.descripcion
FROM forma_pago fp;

/*15 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock.
 El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
 */ 
 
 select *
 from producto as P
 where P.gama = "Ornamentales" and P.cantidad_en_stock > 100
 order by P.precio_venta desc;
 
 -- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga 
 -- el código de empleado 11 o 30.

select * 
from cliente as C
where C.ciudad = "Madrid" and C.codigo_empleado_rep_ventas = 11 or C.codigo_empleado_rep_ventas = 30 ;


  --  //////////// Consultas multitabla (Composición interna)  \\\\\\\\\\\\\\\\

  /* 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
representante de ventas. */

SELECT c.nombre_cliente, CONCAT(e.nombre," ", e.apellido1)
FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

/* 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
nombre de sus representantes de ventas. */

SELECT c.nombre_cliente, CONCAT(e.nombre," ", e.apellido1) 
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

/* 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
el nombre de sus representantes de ventas */ 

SELECT c.nombre_cliente, CONCAT(e.nombre," ", e.apellido1) 
FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente NOT IN (
    SELECT p.codigo_cliente
    FROM pago p
);

/* 4.Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el
representante */

SELECT c.nombre_cliente, e.nombre, ci.nombre_ciudad
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad ci ON cp.codigo_ciudad = ci.codigo_ciudad;

/* 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
de sus representantes junto con la ciudad de la oficina a la que pertenece el
representante */ 

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

/* . 6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada */ 

SELECT o.linea_direccion1
FROM oficina o
JOIN empleado e ON e.codigo_oficina = o.codigo_oficina
JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN codigo_postal cp ON cp.cod_postal = c.codigo_postal
JOIN ciudad ci ON ci.codigo_ciudad = cp.codigo_ciudad
WHERE ci.nombre_ciudad = "Fuenlabrada"; 

/* 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante */

SELECT c.nombre_cliente, CONCAT(e.nombre, " ", e.apellido1) , ci.nombre_ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o  ON o.codigo_oficina = e.codigo_oficina
JOIN codigo_postal cp ON cp.cod_postal = o.codigo_postal
JOIN ciudad ci ON ci.codigo_ciudad = cp.codigo_ciudad;

/* 8. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes. */

SELECT  CONCAT(j.nombre, " ", j.apellido1, " ", j.apellido2) as " nombre empleado" , CONCAT(e.nombre, " ", e.apellido1," ", e.apellido2) as " nombre jefe"
FROM empleado e
JOIN empleado j ON  j.codigo_jefe = e.codigo_empleado ;

/* 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe */ 

SELECT e1.nombre AS empleado, e2.nombre AS jefe, e3.nombre AS jefe_del_jefe
FROM empleado as e1
JOIN empleado as e2 ON e1.codigo_jefe = e2.codigo_empleado 
LEFT JOIN empleado as e3 ON e2.codigo_jefe = e3.codigo_empleado;

/* 10. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido. */ 

SELECT DISTINCT c.nombre_cliente
FROM cliente as c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada OR p.fecha_entrega IS NULL;

SELECT COUNT(*) FROM pedido p
WHERE p.fecha_entrega > p.fecha_esperada OR p.fecha_entrega IS NULL; -- CONFIRMAR INFORMACION

/*  11. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente */ 

SELECT DISTINCT c.nombre_cliente, gp.gama
FROM cliente as c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido as dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto as pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto  as gp ON pr.gama = gp.gama
ORDER BY c.nombre_cliente, gp.gama;

-- /////////  Consultas multitabla (Composición externa) \\\\\\\\\\\\\\\\
/* 1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago. */

SELECT *
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.id_transaccion IS NULL;

/* 2. . Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido. */

SELECT *
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_pedido IS NULL;

/* 3.  Devuelve un listado que muestre los clientes que no han realizado ningún
pago y los que no han realizado ningún pedido */ 

SELECT *
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente
WHERE p.codigo_pedido IS NULL and pa.id_transaccion IS NULL; 

/* 4. Devuelve un listado que muestre solamente los empleados que no tienen
una oficina asociada. */ 

SELECT *
FROM empleado e
WHERE e.codigo_oficina IS NULL;

/* 5.  Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado. */

SELECT * 
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;

/* 6. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado junto con los datos de la oficina donde trabajan. */

SELECT e.nombre, e.apellido1, o.codigo_oficina
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NULL;

/* 7. Devuelve un listado que muestre los empleados que no tienen una oficina
asociada y los que no tienen un cliente asociado. */

SELECT * 
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL AND e.codigo_oficina is NULL;

/* 8.  Devuelve un listado de los productos que nunca han aparecido en un
pedido. */ 

SELECT p.codigo_producto, p.nombre
FROM producto p
LEFT JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
WHERE d.codigo_pedido is null;

/* 9. . Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto. */
SELECT p.codigo_producto, p.nombre, p.descripcion ,g.imagen
FROM producto p
LEFT JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
JOIN gama_producto g ON g.gama = p.gama
WHERE d.codigo_pedido is null;

/* 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales */ 
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

/* 11. . Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago */

SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
WHERE p.id_transaccion is NULL;

/* 12. Devuelve un listado con los datos de los empleados que no tienen clientes
asociados y el nombre de su jefe asociado. */

SELECT CONCAT(e.nombre," ", e.apellido1), j.nombre
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = codigo_empleado
JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- ////////// CONSULTA RESUMEN \\\\\\\\\\\\\ 

-- 1. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(*)
FROM empleado;

-- 2. ¿Cuántos clientes tiene cada país?

SELECT p.nombre_pais, COUNT(cl.codigo_cliente)
FROM pais p
JOIN region r ON r.codigo_pais = p.codigo_pais
JOIN ciudad c ON c.codigo_region = r.codigo_region
JOIN codigo_postal cp ON cp.codigo_ciudad = c.codigo_ciudad
JOIN cliente cl ON cl.codigo_postal = cp.cod_postal
GROUP BY p.nombre_pais;

-- 3. ¿Cuál fue el pago medio en 2009?

SELECT AVG(p.total)
FROM pago p
WHERE YEAR(p.fecha_pago) = '2009';

/* 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos. */

SELECT e.descripcion_estado, COUNT(p.codigo_estado)
FROM estado_pedido e
LEFT JOIN pedido p ON p.codigo_estado = e.codigo_estado
GROUP BY e.descripcion_estado;

/* 5 Calcula el precio de venta del producto más caro y más barato en una
misma consulta */

SELECT MAX(p.precio_venta) as "Producto mas caro", MIN(p.precio_venta) as "Producto mas barato"
FROM producto p;

/* 6 Calcula el número de clientes que tiene la empresa */

SELECT COUNT(c.codigo_cliente)
FROM cliente c;

/* 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid? */

SELECT COUNT(c.codigo_cliente)
FROM cliente c
JOIN codigo_postal cp ON cp.cod_postal = c.codigo_postal
JOIN ciudad ci ON ci.codigo_ciudad = cp.codigo_ciudad
WHERE ci.nombre_ciudad = "Madrid";

/* 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M? */

SELECT  ci.nombre_ciudad, COUNT(c.codigo_cliente)
FROM ciudad ci
JOIN codigo_postal cp ON ci.codigo_ciudad = cp.codigo_ciudad
LEFT JOIN cliente c ON cp.cod_postal = c.codigo_postal
WHERE ci.nombre_ciudad LIKE 'M%'
GROUP BY ci.nombre_ciudad;

/* 9. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno. */ 

SELECT e.nombre, COUNT(c.codigo_cliente)
FROM empleado e
JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
GROUP BY e.nombre;

/*10.  Calcula el número de clientes que no tiene asignado representante de
ventas. */

SELECT COUNT(c.codigo_cliente)
FROM cliente c
WHERE c.codigo_empleado_rep_ventas IS NULL;

/*11  Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente. */

SELECT CONCAT(c.nombre_cliente, c.apellido_contacto) as nombre, MAX(p.fecha_pago), MIN(p.fecha_pago)
FROM cliente c
JOIN pago p ON p.codigo_cliente = c.codigo_cliente
GROUP BY nombre;

/* 12 Calcula el número de productos diferentes que hay en cada uno de los
pedidos. */

SELECT pe.codigo_pedido, COUNT(d.codigo_pedido)
FROM producto p
JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
JOIN pedido pe ON pe.codigo_pedido = d.codigo_pedido
GROUP BY pe.codigo_pedido;

/* 13 Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.
*/
SELECT p.nombre, SUM(d.cantidad)
FROM producto p
JOIN detalle_pedido d ON d.codigo_producto = p.codigo_producto
JOIN pedido pe ON pe.codigo_pedido = d.codigo_pedido
GROUP BY p.nombre;

/* 14. Devuelve un listado de los 20 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas. */