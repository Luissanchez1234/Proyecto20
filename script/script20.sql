--1 Crear la base de datos
--DROP DATABASE IF EXISTS proyecto20;
CREATE DATABASE proyecto20;

--2 Crear las tablas
CREATE TABLE IF NOT EXISTS usuario(
    idUsuario NUMERIC(5,0) NOT NULL,
    nombre    VARCHAR(50)  NOT NULL,
    telefono  CHAR(10)     NOT NULL,
    password  VARCHAR(20)  NOT NULL,
    nivel     CHAR(1)      NOT NULL
)
;
CREATE TABLE IF NOT EXISTS codigo(
    idCodigo    NUMERIC(5,0) NOT NULL,
    numCodigo   CHAR(20)     NOT NULL,
    fechaCambio DATE         NOT NULL,
    idCliente   NUMERIC(5,0) NOT NULL
)
;
CREATE TABLE IF NOT EXISTS cliente(
    idCliente   NUMERIC(5,0)  NOT NULL,
    nombre      VARCHAR(50)   NOT NULL,
    apellidoPat VARCHAR(50)   NOT NULL,
    apellidoMat VARCHAR(50)   NOT NULL,
    telefono    CHAR(10)      NOT NULL,
    correo      VARCHAR(50)   NULL,
    idUsuario   NUMERIC(5,0)  NOT NULL
)
;
CREATE TABLE IF NOT EXISTS parcela(
    idParcela NUMERIC(3,0) NOT NULL,
    nombre    VARCHAR(20)  NOT NULL,
    letania   VARCHAR(500) NOT NULL
)
;
CREATE TABLE IF NOT EXISTS manzana(
    idManzana NUMERIC(5,0) NOT NULL,
    nombre    VARCHAR(20)  NOT NULL,
    numero    NUMERIC(2,0) NOT NULL,
    idParcela NUMERIC(3,0) NOT NULL
)
;
CREATE TABLE IF NOT EXISTS lote(
    idLote    NUMERIC(5,0) NOT NULL,
    ladoA     NUMERIC(5,2) NULL,
    ladoB     NUMERIC(5,2) NULL,
    ladoC     NUMERIC(5,2) NULL,
    ladoD     NUMERIC(5,2) NULL,
    metros2   NUMERIC(5,2) NULL,
    estado    CHAR(1)      NOT NULL,
    idManzana NUMERIC(5,0) NOT NULL
)
;
CREATE TABLE IF NOT EXISTS compra(
    idCompra   NUMERIC(5,0) NOT NULL,
    enganche   NUMERIC(10,2) NOT NULL,
    costoTotal NUMERIC(10,2) NOT NULL,
    idCliente  NUMERIC(5,0) NOT NULL,
    idLote     NUMERIC(5,0) NOT NULL
)
;
CREATE TABLE IF NOT EXISTS registro(
    idRegistro NUMERIC(10,0) NOT NULL,
    pago       NUMERIC(8,2) NOT NULL,
    fechaPago  DATE NOT NULL,
    idCompra   NUMERIC(5,0) NOT NULL
)
;
--3 Creacion de llaves y relaciones de las tablas
ALTER TABLE usuario ADD PRIMARY KEY(idUsuario);
ALTER TABLE parcela ADD PRIMARY KEY(idParcela);

ALTER TABLE cliente ADD PRIMARY KEY(idCliente),
ADD CONSTRAINT fkClieteUsuario FOREIGN KEY(idUsuario) REFERENCES usuario(idUsuario) ON UPDATE CASCADE ON DELETE RESTRICT
;

ALTER TABLE codigo ADD PRIMARY KEY(idCodigo),
ADD CONSTRAINT fkCodigoCliete FOREIGN KEY(idCliente) REFERENCES cliente(idCliente) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE manzana ADD PRIMARY KEY(idManzana),
ADD CONSTRAINT fkManzanaParcela FOREIGN KEY(idParcela) REFERENCES parcela(idParcela) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE lote ADD PRIMARY KEY(idLote),
ADD CONSTRAINT fkLoteManzana FOREIGN KEY(idManzana) REFERENCES manzana(idManzana) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE compra ADD PRIMARY KEY(idCompra),
ADD CONSTRAINT fkCompraCliente FOREIGN KEY(idCliente) REFERENCES cliente(idCliente) ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fkCompraLote FOREIGN KEY(idLote) REFERENCES lote(idLote) ON UPDATE CASCADE ON DELETE RESTRICT
;

ALTER TABLE registro ADD PRIMARY KEY(idRegistro),
ADD CONSTRAINT fkRegistroCompra FOREIGN KEY(idCompra) REFERENCES compra(idCompra) ON UPDATE CASCADE ON DELETE CASCADE
;










