-- Active: 1717105247149@@127.0.0.1@3306@dbGarden
/* CREACION Y USO BASE DE DATOS */

DROP DATABASE IF EXISTS dbGarden;

create database dbGarden;
use dbGarden;

/* INICIO DE CREACION DE TABLAS */


-- creacion tabla gama_producto --
create table gama_producto(
	gama VARCHAR(50) PRIMARY KEY,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
);

-- creacion tabla proovedor y telefonos proovedor
CREATE Table proovedor(
    codigo_proovedor INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE tel_proovedor(
	codigo_telefono INT,
    fijo varchar(10),
    celular1 varchar(15),
    celular2 varchar(15),
    codigo_proovedor INT,
    primary key (codigo_telefono, codigo_proovedor),
    foreign key (codigo_proovedor) references proovedor(codigo_proovedor)
);

-- creacion tabla producto --
create table producto(
	codigo_producto VARCHAR(15) primary KEY,
    nombre VARCHAR(70) NOT NULL,
    gama VARCHAR(50) NOT NULL,
    dimiensiones VARCHAR(25),
    descripcion TEXT,
    cantidad_en_stock SMALLINT(6) NOT NULL,
    precio_venta DECIMAL(15,2) NOT NULL,
    precio_proveedor DECIMAL(15,2),
    codigo_proovedor INT NOT  NULL,
    foreign key (gama) references gama_producto(gama),
    foreign key (codigo_proovedor) references proovedor(codigo_proovedor)
);
-- CREACION TABLAS PAIS/REGION/CIUDAD
CREATE TABLE pais(
    codigo_pais INT PRIMARY KEY,
    nombre_pais VARCHAR(70)  NOT NULL
);
Create table region(
    codigo_region int PRIMARY KEY,
    nombre_region VARCHAR(70) NOT NULL,
    codigo_pais int,
    Foreign Key (codigo_pais) REFERENCES pais (codigo_pais)
);

Create table ciudad(
    codigo_ciudad int PRIMARY KEY,
    nombre_ciudad VARCHAR(70) NOT NULL,
    codigo_region int,
    Foreign Key (codigo_region) REFERENCES region (codigo_region)
);

CREATE table codigo_postal(
    cod_postal VARCHAR(10) PRIMARY KEY,
    codigo_ciudad INT NOT NULL,
    Foreign Key (codigo_ciudad) REFERENCES ciudad(codigo_ciudad)
);
-- Creacion tabla oficina  y telefono oficinas
CREATE TABLE oficina(
    codigo_oficina VARCHAR(10) primary key,
    codigo_postal VARCHAR(10) NOT NULL,
    linea_direccion1 VARCHAR (50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    Foreign Key (codigo_postal) REFERENCES codigo_postal (cod_postal)
    );
    
CREATE TABLE tel_oficina(
	codigo_telefono INT ,
    fijo varchar(10),
    celular1 varchar(15),
    celular2 varchar(15),
    codigo_oficina VARCHAR(10),
    primary key (codigo_telefono, codigo_oficina),
    foreign key (codigo_oficina) references oficina(codigo_oficina)
);

-- Creacion tabla cargo empleados
CREATE table cargo_empleado(
    codigo_cargo int PRIMARY KEY,
    nombre_cargo VARCHAR(50)
);
-- Creacion tabla empleado y telefonos empleado
CREATE TABLE empleado(
    codigo_empleado int(11) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    codigo_oficina VARCHAR(10) NOT NULL,
    codigo_jefe INT(11),
    codigo_cargo INT NOT NULL,
    Foreign Key (codigo_oficina) REFERENCES oficina(codigo_oficina),
    Foreign Key (codigo_jefe) REFERENCES empleado(codigo_empleado),
    Foreign Key (codigo_cargo) REFERENCES cargo_empleado(codigo_cargo)
);

CREATE TABLE tel_empleado(
	codigo_telefono INT ,
    fijo varchar(10),
    celular1 varchar(15),
    celular2 varchar(15),
    codigo_empleado int(11),
    primary key (codigo_telefono, codigo_empleado),
    foreign key (codigo_empleado) references empleado(codigo_empleado)
);

-- CREACION TABLA CLIENTE Y TELEFONOS CLIENTE
CREATE TABLE cliente(
    codigo_cliente INT(11) primary key,
    nombre_cliente VARCHAR(50),
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    fax VARCHAR(15) NOT NULL,
    linea_direccion1 VARCHAR(50),
    linea_direccion2 VARCHAR(50),
    codigo_postal VARCHAR(10),
    codigo_empleado_rep_ventas INT(11),
    limite_credito DECIMAL (15,2),
    Foreign Key (codigo_postal) REFERENCES codigo_postal(cod_postal),
    Foreign Key (codigo_empleado_rep_ventas) REFERENCES empleado(codigo_empleado)
);

CREATE TABLE tel_cliente(
	codigo_telefono INT ,
    fijo varchar(10),
    celular1 varchar(15),
    celular2 varchar(15),
    codigo_cliente int(11),
    primary key (codigo_telefono, codigo_cliente),
    foreign key (codigo_cliente) references cliente(codigo_cliente)
);
-- CREACION TABLA PAGO y forma de pago

CREATE table forma_pago(
    codigo_forma_pago INT PRIMARY KEY,
    descripcion VARCHAR(15) NOT NULL
);
CREATE TABLE pago(
    codigo_cliente  INT(11),
    id_transaccion VARCHAR(50),
    fecha_pago DATE NOT NULL,
    total DECIMAL(15,2),
    codigo_forma_pago INT,
    PRIMARY KEY(codigo_cliente, id_transaccion ),
    Foreign Key (codigo_cliente) REFERENCES cliente(codigo_cliente),
    Foreign Key (codigo_forma_pago) REFERENCES forma_pago(codigo_forma_pago)
);
 
-- creacion tabla estado pedido --
CREATE Table estado_pedido(
    codigo_estado int PRIMARY KEY,
    descripcion_estado VARCHAR(50) NOT NULL
);

-- creacion tabla pedido --

create table pedido(
	codigo_pedido int(11) primary key,
    fecha_pedido DATE not null,
    fecha_esperada DATE,
    fecha_entrega DATE,
    comentarios TEXT,
    codigo_cliente int(11) NOT NULL,
    codigo_estado int NOT Null,
    Foreign Key (codigo_cliente) REFERENCES cliente(codigo_cliente),
    Foreign Key (codigo_estado) REFERENCES estado_pedido(codigo_estado)
);

-- creacion tabla detalle pedido --

create table detalle_pedido(
	codigo_pedido int(11),
    codigo_producto VARCHAR(15),
    cantidad INT(11) NOT NULL,
    precio_unidad DECIMAL(15,2) NOT NULL,
    numero_linea SMALLINT(6),
    PRIMARY KEY (codigo_pedido,codigo_producto),
    Foreign Key (codigo_pedido) REFERENCES pedido(codigo_pedido),
    Foreign Key (codigo_producto) REFERENCES producto(codigo_producto)
);


-- ////////////////////// INICIO INSERTSS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

INSERT INTO pais VALUES
(1,"Colombia"),
(2,"Mexico"),
(3,"España"),
(4,"Estados Unidos");

INSERT INTO region VALUES
(1, 'Cundinamarca', 1),
(2, 'Antioquia', 1),
(3, 'Valle del Cauca', 1),
(4, 'Ciudad de México', 2),
(5, 'Jalisco', 2),
(6, 'Nuevo León', 2),
(7, 'Madrid', 3),
(8, 'Cataluña', 3),
(9, 'Andalucía', 3),
(10, 'California', 4),
(11, 'Texas', 4),
(12, 'Florida', 4);

INSERT INTO ciudad VALUES
(1, 'Bogotá', 1),
(2, 'Medellín', 2),
(3, 'Cali', 3),
(4, 'Ciudad de México', 4),
(5, 'Guadalajara', 5),
(6, 'Monterrey', 6),
(7, 'Madrid', 7),
(8, 'Barcelona', 8),
(9, 'Sevilla', 9),
(10, 'Los Ángeles', 10),
(11, 'Houston', 11),
(12, 'Miami', 12);

INSERT INTO codigo_postal VALUES
('110001', 1),
('050001', 2),
('760001', 3),
('01000', 4),
('44100', 5),
('64000', 6),
('28001', 7),
('08001', 8),
('41001', 9),
('90001', 10),
('77001', 11),
('33001', 12);

INSERT INTO oficina VALUES
('OF001', '110001', 'Carrera 7 # 12-34', 'Edificio ABC'),
('OF002', '050001', 'Calle 10 # 20-30', 'Oficina 201'),
('OF003', '760001', 'Avenida 3 # 45-67', 'Centro Comercial XYZ'),
('OF004', '01000', 'Paseo de la Reforma 123', 'Piso 10'),
('OF005', '44100', 'Calle Independencia 456', 'Edificio DEF'),
('OF006', '64000', 'Avenida Constitución 789', 'Suite 100'),
('OF007', '28001', 'Calle Mayor 1', 'Oficina 5'),
('OF008', '08001', 'Passeig de Gràcia 2', 'Piso 3'),
('OF009', '41001', 'Avenida de la Constitución 3', 'Local B'),
('OF010', '90001', 'Main Street 100', 'Building 50'),
('OF011', '77001', 'Broadway 200', 'Suite 300'),
('OF012', '33001', 'Ocean Drive 300', 'Apartment 400');

INSERT INTO tel_oficina VALUES
(1, '1234567', '3001234567', '3101234567', 'OF001'), 
(2, '2345678', '3012345678', '3112345678', 'OF002'), 
(3, '3456789', '3023456789', '3123456789', 'OF003'), 
(4, '4567890', '6004567890', '6104567890', 'OF007'), 
(5, '5678901', '6015678901', '6115678901', 'OF008'), 
(6, '6789012', '6026789012', '6126789012', 'OF009'); 

INSERT INTO cargo_empleado VALUES
(1, 'Gerente'),
(2, 'Asistente'),
(3, 'Desarrollador'),
(4, 'Diseñador'),
(5, 'Representante de ventas');

INSERT INTO empleado VALUES
(7, 'Carlos', 'Gómez', 'Pérez', '1001', 'carlos.gomez@empresa.com', 'OF001', NULL, 1);
INSERT INTO empleado VALUES
(1, 'Juan', 'Pérez', 'López', '1002', 'juan.perez@empresa.com', 'OF001', 7, 5),
(2, 'Ana', 'Gómez', 'Martínez', '1003', 'ana.gomez@empresa.com', 'OF002', 7,5),
(3, 'Luis', 'Ruiz', 'Sánchez', '1004', 'luis.ruiz@empresa.com', 'OF003', 7, 5),
(4, 'Elena', 'Martínez', 'García', '1005', 'elena.martinez@empresa.com', 'OF007', 7, 5),
(5, 'María', 'López', 'Fernández', '1006', 'maria.lopez@empresa.com', 'OF008', 7, 2),
(6, 'José', 'Sánchez', 'Rodríguez', '1007', 'jose.sanchez@empresa.com', 'OF009', 7, 3),
(8, 'Lucía', 'Hernández', 'Jiménez', '1008', 'lucia.hernandez@empresa.com', 'OF002', 7, 4),
(9, 'Pedro', 'García', 'Vega', '1009', 'pedro.garcia@empresa.com', 'OF003', 7, 5),
(10, 'Laura', 'Díaz', 'Cruz', '1010', 'laura.diaz@empresa.com', 'OF007', 7, 2),
(11, 'Miguel', 'Torres', 'Navarro', '1011', 'miguel.torres@empresa.com', 'OF008', 7, 3);


INSERT INTO cliente VALUES
(1, 'Cliente A', 'Carlos', 'Rojas', '123-4567', 'Calle 1 # 1-1', 'Oficina 101', '110001', 1, 50000.00),
(2, 'Cliente B', 'Marta', 'López', '234-5678', 'Calle 2 # 2-2', 'Oficina 102', '050001', 2, 75000.00),
(3, 'Cliente C', 'Luis', 'García', '345-6789', 'Calle 3 # 3-3', 'Oficina 103', '760001', 3, 60000.00),
(4, 'Cliente D', 'Ana', 'Pérez', '456-7890', 'Calle 4 # 4-4', 'Oficina 104', '28001', 4, 80000.00),
(5, 'Cliente E', 'Pedro', 'Martínez', '567-8901', 'Calle 5 # 5-5', 'Oficina 105', '08001', 1, 45000.00),
(6, 'Cliente F', 'Elena', 'Gómez', '678-9012', 'Calle 6 # 6-6', 'Oficina 106', '41001', 2, 90000.00),
(7, 'Cliente G', 'Mario', 'Hernández', '789-0123', 'Calle 7 # 7-7', 'Oficina 107', '110001', 3, 55000.00),
(8, 'Cliente H', 'Lucía', 'Ramírez', '890-1234', 'Calle 8 # 8-8', 'Oficina 108', '050001', 4, 70000.00),
(9, 'Cliente I', 'Jorge', 'Fernández', '901-2345', 'Calle 9 # 9-9', 'Oficina 109', '760001', 1, 65000.00),
(10, 'Cliente J', 'Sara', 'Sánchez', '012-3456', 'Calle 10 # 10-10', 'Oficina 110', '28001', 2, 75000.00);

INSERT INTO estado_pedido VALUES
(1,'entregado'),
(2,'pendiente'),
(3,'devuelto'),
(4,'rechazado');

INSERT INTO forma_pago VALUES
(1, 'Efectivo'),
(2, 'Tarjeta'),
(3, 'Transferencia'),
(4, 'PayPal'),
(5, 'Cheque');


INSERT INTO pago VALUES
(1, 'TXN0001', '2008-01-15', 1500.00, 1),
(2, 'TXN0002', '2023-03-22', 2500.00, 2),
(3, 'TXN0003', '2023-05-18', 1750.00, 3),
(4, 'TXN0004', '2008-07-30', 1250.00, 4),
(5, 'TXN0005', '2023-09-14', 3000.00, 5),
(6, 'TXN0006', '2023-11-05', 2200.00, 1),
(7, 'TXN0007', '2008-04-25', 1850.00, 2),
(8, 'TXN0008', '2023-12-01', 2750.00, 3),
(9, 'TXN0009', '2008-06-10', 3200.00, 4),
(10, 'TXN0010', '2023-02-20', 4100.00, 5);

-- INSERTS PEDIDOS 
INSERT INTO pedido VALUES
(1, '2023-05-01', '2023-05-10', '2023-05-09', 'Entrega puntual', 1, 1),
(2, '2023-06-01', '2023-06-10', '2023-06-12', 'Entrega con retraso', 2, 1),
(3, '2023-07-01', '2023-07-15', '2023-07-15', 'Entrega puntual', 3, 1),
(4, '2023-08-01', '2023-08-10', '2023-08-14', 'Entrega con retraso', 4, 1),
(5, '2023-09-01', '2023-09-10', NULL, 'Pedido aún pendiente', 5, 2),
(6, '2023-10-01', '2023-10-10', '2023-10-09', 'Entrega puntual', 6, 1),
(7, '2023-11-01', '2023-11-10', '2023-11-13', 'Entrega con retraso', 7, 1),
(8, '2023-12-01', '2023-12-10', NULL, 'Pedido aún pendiente', 8, 2),
(9, '2024-01-01', '2024-01-10', NULL, 'Pedido aún pendiente', 9, 2),
(10, '2024-02-01', '2024-02-10', '2024-02-12', 'Entrega con retraso', 10, 1),
 (11, '2024-02-01', '2024-02-10', '2024-02-06', 'Entregada muy rapido jaja', 10, 1),
(12, '2009-02-01', '2009-02-25', '2024-02-06', 'Entregado despues de 13 años jaja', 1, 1),
(14, '2009-02-01', '2009-02-25', NULL, 'rechazado por impago', 5, 4);

-- INSERT CLIENTE SIN PAGO
INSERT INTO cliente VALUES (11, 'Cliente MOROSO', 'Sara', 'Sánchez', '012-3456', 'Calle 10 # 10-10', 'Oficina 110', '28001', 2, 75000.00);

-- INSERT CLIENTE EN LA CIUDAD FUENLABRADA
INSERT INTO ciudad VALUES (13,'Fuenlabrada',7);
INSERT INTO codigo_postal VALUES('28936',13);
INSERT INTO cliente VALUES (12, 'Cliente de FUENLABRADA', 'FUEN', 'LABRADA', '666-3456', 'Calle yselas # 10-10', NULL, '28936', 9, 75000.00);
SELECT * FROM  region;

-- INSERT GAMAS PRODUCTOS 

INSERT INTO gama_producto VALUES
('Ornamentales', 'Plantas y flores ornamentales para decoración.', '<p>Plantas y flores <strong>ornamentales</strong> para decoración.</p>', 'imagenes/ornamentales.jpg'),
('Frutales', 'Árboles frutales de diversas especies.', '<p>Árboles <strong>frutales</strong> de diversas especies.</p>', 'imagenes/frutales.jpg'),
('Aromaticas', 'Plantas aromáticas utilizadas para condimentos y remedios.', '<p>Plantas <strong>aromáticas</strong> utilizadas para condimentos y remedios.</p>', 'imagenes/aromaticas.jpg'),
('Medicinales', 'Plantas utilizadas en medicina tradicional y moderna.', '<p>Plantas <strong>medicinales</strong> utilizadas en medicina tradicional y moderna.</p>', 'imagenes/medicinales.jpg'),
('Cactus', 'Diversidad de cactus para coleccionistas y decoración.', '<p>Diversidad de <strong>cactus</strong> para coleccionistas y decoración.</p>', 'imagenes/cactus.jpg'),
('Suculentas', 'Plantas suculentas de fácil cuidado y variadas formas.', '<p>Plantas <strong>suculentas</strong> de fácil cuidado y variadas formas.</p>', 'imagenes/suculentas.jpg'),
('Carnivoras', 'Plantas carnívoras exóticas y fascinantes.', '<p>Plantas <strong>carnívoras</strong> exóticas y fascinantes.</p>', 'imagenes/carnivoras.jpg'),
('Acuaticas', 'Plantas acuáticas para estanques y acuarios.', '<p>Plantas <strong>acuáticas</strong> para estanques y acuarios.</p>', 'imagenes/acuaticas.jpg'),
('Trepadoras', 'Plantas trepadoras para muros y pérgolas.', '<p>Plantas <strong>trepadoras</strong> para muros y pérgolas.</p>', 'imagenes/trepadoras.jpg'),
('Bulbosas', 'Plantas bulbosas con flores espectaculares.', '<p>Plantas <strong>bulbosas</strong> con flores espectaculares.</p>', 'imagenes/bulbosas.jpg');

-- 
INSERT INTO proovedor VALUES
(1, 'Proveedores Internacionales S.A.'),
(2, 'Horticultura Global Ltd.'),
(3, 'Viveros y Jardines S.L.'),
(4, 'Flora Exótica Inc.'),
(5, 'Semillas del Mundo'),
(6, 'Verde Vivo Ltda.'),
(7, 'Naturaleza y Vida S.A.'),
(8, 'Plantas y Flores de Colombia'),
(9, 'Exportadores de Plantas S.L.'),
(10, 'Eco Verde Proveedores');

-- INSERT DE PRODUCTOS -- 
INSERT INTO producto VALUES
('P001', 'Rosa Roja', 'Ornamentales', '30 cm', 'Hermosa rosa roja para decoración', 100, 5.00, 3.00, 1),
('P002', 'Manzano', 'Frutales', '1.5 m', 'Árbol de manzano en maceta', 50, 25.00, 15.00, 2),
('P003', 'Menta', 'Aromaticas', '20 cm', 'Planta de menta fresca', 200, 3.50, 2.00, 3),
('P004', 'Aloe Vera', 'Medicinales', '50 cm', 'Planta de Aloe Vera para uso medicinal', 150, 10.00, 5.50, 4),
('P005', 'Cactus Esférico', 'Cactus', '15 cm', 'Cactus esférico pequeño', 80, 12.00, 6.00, 5),
('P006', 'Suculenta Echeveria', 'Suculentas', '10 cm', 'Suculenta Echeveria en maceta', 120, 8.00, 4.50, 6),
('P007', 'Dionea Muscipula', 'Carnivoras', '12 cm', 'Planta carnívora Dionea Muscipula', 70, 15.00, 8.00, 7),
('P008', 'Nenúfar', 'Acuaticas', '25 cm', 'Planta acuática Nenúfar', 90, 20.00, 12.00, 8),
('P009', 'Enredadera', 'Trepadoras', '2 m', 'Planta trepadora para jardines', 60, 18.00, 10.00, 9),
('P010', 'Tulipán', 'Bulbosas', '35 cm', 'Tulipán en flor para decoración', 110, 7.00, 4.00, 10),
('P011', 'Orquídea Phalaenopsis', 'Ornamentales', '40 cm', 'Elegante orquídea Phalaenopsis', 75, 25.00, 15.00, 1),
('P012', 'Bonsái Ficus', 'Ornamentales', '30 cm', 'Bonsái de Ficus para interiores', 40, 50.00, 30.00, 1),
('P013', 'Geranio', 'Ornamentales', '25 cm', 'Colorido geranio en maceta', 150, 6.00, 3.50, 1);

INSERT INTO detalle_pedido VALUES
(1, 'P001', 10, 5.00, 1),
(2, 'P002', 5, 25.00, 1),
(3, 'P003', 15, 3.50, 1),
(4, 'P004', 8, 10.00, 1),
(5, 'P005', 12, 12.00, 1),
(6, 'P006', 20, 8.00, 1),
(7, 'P007', 7, 15.00, 1),
(8, 'P008', 9, 20.00, 1),
(9, 'P009', 10, 18.00, 1),
(10, 'P010', 14, 7.00, 1),
(11, 'P011', 5, 25.00, 1),
(12, 'P012', 3, 50.00, 1),
(14, 'P013', 12, 6.00, 1);

-- AGREGAR CLIENTE QUE SI HA HECHO PAGO PERO NO HA HECHO PEDIDOS
INSERT INTO cliente VALUES (13, 'Cliente que', 'paga', 'nopide', '666-3456', 'in your mind # 10-10', NULL, '28936', 9, 885000.00);
INSERT INTO pago VALUES (13,'TXN0011','2024-05-30',NULL,1);

-- INSERTAR PRODUCTO QUE NO HAYA SALIDO EN UN PEDIDO:

INSERT INTO producto VALUES('P014', 'PRODUCTO FEO ', 'Ornamentales', '25 cm', 'color caca', 150, 6.00, 3.50, 1);

-- INSERTAR CLIENTE QUE HA HECHO UN PEDIDO PERO NO HA PAGADO

INSERT INTO cliente VALUES (14, 'Cliente PIDENOPAGA', 'pero', 'NOPAGA', '666-3456', 'Calle yselas # 10-10', NULL, '28936', 9, 75000.00);

INSERT INTO pedido VALUES(99, '2023-05-01', '2023-05-10', '2023-05-09', 'Entrega puntual', 14, 1);

-- INSERTAR DATOS PARA CALCULAR EL PROMEDIO DE PAGOS EN 2009

INSERT INTO pago VALUES
(11, 'TXN0001', '2009-01-15', 1500.00, 1),
(12, 'TXN0002', '2009-03-22', 2500.00, 1),
(13, 'TXN0003', '2009-05-18', 1750.00, 3);