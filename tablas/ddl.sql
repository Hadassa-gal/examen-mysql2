CREATE TABLE actor (
    id_actor SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE pais (
    id_pais SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE ciudad (
    id_ciudad SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    id_pais SMALLINT,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE direccion (
    id_direccion SMALLINT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    id_ciudad SMALLINT,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE idioma (
    id_idioma TINYINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE categoria (
    id_categoria TINYINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

ALTER TABLE categoria ADD COLUMN ultima_actualizacion TIMESTAMP;
CREATE TABLE pelicula (
    id_pelicula SMALLINT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma TINYINT,
    id_idioma_original TINYINT,
    duracion_alquiler TINYINT,
    rental_rate DECIMAL(4,2),
    duracion SMALLINT,
    replacement_cost DECIMAL(5,2),
    clasificacion ENUM('G','PG','PG-13','R','NC-17'),
    caracteristicas_especiales SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
    FOREIGN KEY (id_idioma_original) REFERENCES idioma(id_idioma)
);

CREATE TABLE pelicula_actor (
    id_actor SMALLINT,
    id_pelicula SMALLINT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_actor, id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);

CREATE TABLE pelicula_categoria (
    id_pelicula SMALLINT,
    id_categoria TINYINT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_pelicula),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);

CREATE TABLE empleado (
    id_empleado TINYINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    id_direccion SMALLINT,
    imagen BLOB,
    email VARCHAR(50),
    activo TINYINT(1),
    username VARCHAR(16),
    password VARCHAR(40),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE almacen (
    id_almacen TINYINT PRIMARY KEY AUTO_INCREMENT,
    id_direccion SMALLINT,
    id_empleado_jefe TINYINT,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_empleado_jefe) REFERENCES empleado(id_empleado)
);

CREATE TABLE almacen_empleado (
    id_empleado TINYINT,
    id_almacen TINYINT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_almacen, id_empleado),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

ALTER TABLE almacen_empleado DROP COLUMN ultima_actualizacion;

CREATE TABLE cliente (
    id_cliente SMALLINT PRIMARY KEY AUTO_INCREMENT,
    id_almacen TINYINT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    id_direccion SMALLINT,
    activo TINYINT(1),
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_almacen) REFERENCES almacen_empleado(id_almacen)
);

ALTER TABLE cliente DROP COLUMN fecha_creacion;
ALTER TABLE cliente ADD COLUMN fecha_creacion TIMESTAMP;
ALTER TABLE cliente DROP FOREIGN KEY cliente_ibfk_2;
ALTER TABLE cliente ADD CONSTRAINT cliente_ibfk4 FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion);

CREATE TABLE inventario (
    id_inventario MEDIUMINT,
    id_pelicula SMALLINT,
    id_almacen TINYINT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_inventario),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE alquiler (
    id_alquiler INT PRIMARY KEY,
    id_inventario MEDIUMINT,
    id_cliente SMALLINT,
    fecha_devolucion DATETIME,
    id_empleado TINYINT,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);
ALTER TABLE alquiler MODIFY COLUMN id_alquiler INT(7);
ALTER TABLE alquiler ADD COLUMN fecha_alquiler TIMESTAMP AFTER id_alquiler;
ALTER TABLE alquiler MODIFY COLUMN fecha_devolucion TIMESTAMP;

CREATE TABLE pago (
    id_pago INT PRIMARY KEY,
    id_cliente SMALLINT,
    id_empleado TINYINT,
    id_alquiler INT,
    total DECIMAL(5,2),
    fecha_pago DATETIME,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);