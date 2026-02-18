CREATE DATABASE TechSupply;
USE TechSupply;

-- Sucursal
CREATE TABLE sucursal (
    codigo_sucursal INT PRIMARY KEY,
    ubicacion VARCHAR(100) NOT NULL
);

-- Empleado
CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(100),
    codigo_sucursal INT,
    FOREIGN KEY (codigo_sucursal) REFERENCES sucursal(codigo_sucursal)
);

-- Cliente
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    tipo_cliente VARCHAR(20)
);

-- Proveedor
CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    contacto_principal VARCHAR(100)
);

-- Producto
CREATE TABLE producto (
    codigo_producto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio_unitario DECIMAL(10,2),
    cantidad_stock INT
);

-- Proveedor_Producto
CREATE TABLE proveedor_producto (
    id_proveedor INT,
    codigo_producto INT,
    PRIMARY KEY (id_proveedor, codigo_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto)
);

-- Pedido
CREATE TABLE pedido (
    numero_pedido INT PRIMARY KEY,
    fecha_compra DATE,
    id_cliente INT,
    id_empleado INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Detalle Pedido
CREATE TABLE detalle_pedido (
    numero_pedido INT,
    codigo_producto INT,
    cantidad INT,
    PRIMARY KEY (numero_pedido, codigo_producto),
    FOREIGN KEY (numero_pedido) REFERENCES pedido(numero_pedido),
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto)
);

-- Factura
CREATE TABLE factura (
    numero_factura INT PRIMARY KEY,
    fecha_emision DATE,
    monto_total DECIMAL(10,2),
    estado_pago VARCHAR(20),
    numero_pedido INT UNIQUE,
    FOREIGN KEY (numero_pedido) REFERENCES pedido(numero_pedido)
);

-- INSERTS

INSERT INTO sucursal VALUES
(1,'Central'),
(2,'Zona 10');

INSERT INTO empleado VALUES
(1,'Carlos Ramirez','Vendedor',1),
(2,'Ana Perez','Cajero',2);

INSERT INTO cliente VALUES
(1,'Cristian Champet','Ciudad','Individual'),
(2,'Empresa Tech','Zona 4','Corporativo');

INSERT INTO proveedor VALUES
(1,'Importadora GT','Zona 12','Mario Ruiz'),
(2,'Intelaf','Zona 1','Luis Soto');

INSERT INTO producto VALUES
(101,'MAC','8GB RAM',5000.00,15),
(102,'Teclado ','Mecanico',250.00,40);

INSERT INTO proveedor_producto VALUES
(1,101),
(2,102);

INSERT INTO pedido VALUES
(1001,'2026-02-18',1,1);

INSERT INTO detalle_pedido VALUES
(1001,101,1),
(1001,102,2);

INSERT INTO factura VALUES
(5001,'2026-02-18',5500.00,'Pagado',1001);


-- CONSULTAS

SELECT * FROM cliente;

SELECT cliente.nombre, pedido.numero_pedido
FROM pedido
JOIN cliente ON pedido.id_cliente = cliente.id_cliente;

SELECT factura.numero_factura, producto.nombre, detalle_pedido.cantidad
FROM factura
JOIN pedido ON factura.numero_pedido = pedido.numero_pedido
JOIN detalle_pedido ON pedido.numero_pedido = detalle_pedido.numero_pedido
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto;

--HOASDLADASDA