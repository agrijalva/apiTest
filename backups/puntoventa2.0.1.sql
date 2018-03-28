-- MySQL Script generated by MySQL Workbench
-- Wed Dec 13 09:52:35 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema forrajera
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `forrajera` ;

-- -----------------------------------------------------
-- Schema forrajera
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `forrajera` DEFAULT CHARACTER SET latin1 ;
USE `forrajera` ;

-- -----------------------------------------------------
-- Table `forrajera`.`empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`empresa` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`empresa` (
  `idEmpresa` INT(11) NOT NULL AUTO_INCREMENT,
  `emp_rason_social` VARCHAR(255) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `emp_rfc` VARCHAR(15) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `emp_contacto_nombre` VARCHAR(150) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `emp_contacto_email` VARCHAR(150) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `emp_contacto_telefono` VARCHAR(50) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `emp_contacto_direccion` VARCHAR(255) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `emp_estatus` INT(11) NULL DEFAULT '1',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_spanish_ci;


-- -----------------------------------------------------
-- Table `forrajera`.`sucursal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`sucursal` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`sucursal` (
  `idSucursal` INT(11) NOT NULL AUTO_INCREMENT,
  `suc_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `suc_descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `suc_estatus` INT(11) NULL DEFAULT '1',
  `idEmpresa` INT(11) NOT NULL,
  `suc_matriz` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_sucursal_empresa1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_sucursal_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`catalogousuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`catalogousuario` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`catalogousuario` (
  `idCatalogoUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `cu_rol` VARCHAR(45) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`idCatalogoUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_spanish_ci
COMMENT = 'Tipos de usuario de momento encontramos\nSuperAdministrador\nAdministrador\nAgente\nCliente';


-- -----------------------------------------------------
-- Table `forrajera`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`usuario` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `usu_nombre` VARCHAR(500) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `usu_usuario` VARCHAR(150) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `usu_password` VARCHAR(50) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `usu_estatus` INT(11) NULL DEFAULT '1',
  `idCatalogoUsuario` INT(11) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idEmpresa` INT(11) NULL DEFAULT NULL,
  `idSucursal` VARCHAR(45) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_usuario_catalogousuario_idx` (`idCatalogoUsuario` ASC),
  CONSTRAINT `fk_usuario_catalogousuario`
    FOREIGN KEY (`idCatalogoUsuario`)
    REFERENCES `forrajera`.`catalogousuario` (`idCatalogoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_spanish_ci;


-- -----------------------------------------------------
-- Table `forrajera`.`caja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`caja` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`caja` (
  `idCaja` INT(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` INT(11) NOT NULL,
  `idSucursal` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  `caja_fechaApertura` DATETIME NOT NULL,
  `caja_fechaCierre` VARCHAR(45) NULL DEFAULT NULL,
  `caja_monto` FLOAT NOT NULL,
  PRIMARY KEY (`idCaja`),
  INDEX `fk_caja_empresa1_idx` (`idEmpresa` ASC),
  INDEX `fk_caja_sucursal1_idx` (`idSucursal` ASC),
  INDEX `fk_caja_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_caja_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caja_sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caja_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `forrajera`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`tipocheckin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`tipocheckin` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`tipocheckin` (
  `idTipoCheckIn` INT(11) NOT NULL AUTO_INCREMENT,
  `tchi_tipo` VARCHAR(100) NULL DEFAULT NULL,
  `tchi_estatus` INT(11) NULL DEFAULT '1',
  PRIMARY KEY (`idTipoCheckIn`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`checkin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`checkin` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`checkin` (
  `idCheckIn` INT(11) NOT NULL AUTO_INCREMENT,
  `chi_descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `chi_estatus` INT(11) NULL DEFAULT '1',
  `idTipoCheckIn` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  `idEmpresa` INT(11) NOT NULL,
  `idSucursal` INT(11) NOT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCheckIn`),
  INDEX `fk_checkin_tipocheckin1_idx` (`idTipoCheckIn` ASC),
  INDEX `fk_checkin_empresa1_idx` (`idEmpresa` ASC),
  INDEX `fk_checkin_sucursal1_idx` (`idSucursal` ASC),
  INDEX `fk_checkin_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_checkin_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkin_sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkin_tipocheckin1`
    FOREIGN KEY (`idTipoCheckIn`)
    REFERENCES `forrajera`.`tipocheckin` (`idTipoCheckIn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkin_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `forrajera`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`producto` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`producto` (
  `idProducto` INT(11) NOT NULL AUTO_INCREMENT,
  `pro_sku` VARCHAR(20) NULL DEFAULT NULL,
  `pro_nombre` VARCHAR(250) NULL DEFAULT NULL,
  `pro_descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `pro_unidad` VARCHAR(45) NULL DEFAULT NULL,
  `pro_estatus` INT(11) NULL DEFAULT '1',
  `idEmpresa` INT(11) NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_producto_empresa1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_producto_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`checkindetalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`checkindetalle` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`checkindetalle` (
  `idCheckInDetalle` INT(11) NOT NULL AUTO_INCREMENT,
  `idCheckIn` INT(11) NOT NULL,
  `idProducto` INT(11) NOT NULL,
  `cod_cantidad` FLOAT NOT NULL,
  `cod_observaciones` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idCheckInDetalle`),
  INDEX `fk_checkindetalle_producto1_idx` (`idProducto` ASC),
  INDEX `fk_checkindetalle_checkin1_idx` (`idCheckIn` ASC),
  CONSTRAINT `fk_checkindetalle_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `forrajera`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkindetalle_checkin1`
    FOREIGN KEY (`idCheckIn`)
    REFERENCES `forrajera`.`checkin` (`idCheckIn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`tipocheckout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`tipocheckout` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`tipocheckout` (
  `idTipoCheckOut` INT(11) NOT NULL AUTO_INCREMENT,
  `tcho_tipo` VARCHAR(100) NULL DEFAULT NULL,
  `tcho_estatus` INT(11) NULL DEFAULT '1',
  PRIMARY KEY (`idTipoCheckOut`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`checkout` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`checkout` (
  `idCheckOut` INT(11) NOT NULL AUTO_INCREMENT,
  `cho_descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `cho_estatus` INT(11) NULL DEFAULT '1',
  `idTipoCheckOut` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  `idEmpresa` INT(11) NOT NULL,
  `idSucursal` INT(11) NOT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCheckOut`),
  INDEX `fk_checkout_tipocheckout1_idx` (`idTipoCheckOut` ASC),
  INDEX `fk_checkout_empresa1_idx` (`idEmpresa` ASC),
  INDEX `fk_checkout_sucursal1_idx` (`idSucursal` ASC),
  INDEX `fk_checkout_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_checkout_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkout_sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkout_tipocheckout1`
    FOREIGN KEY (`idTipoCheckOut`)
    REFERENCES `forrajera`.`tipocheckout` (`idTipoCheckOut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkout_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `forrajera`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`checkoutdetalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`checkoutdetalle` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`checkoutdetalle` (
  `idCheckOutDetalle` INT(11) NOT NULL AUTO_INCREMENT,
  `idCheckOut` INT(11) NOT NULL,
  `idProducto` INT(11) NOT NULL,
  `cod_cantidad` FLOAT NOT NULL DEFAULT '0',
  `cod_precio` FLOAT NULL DEFAULT 0,
  `cod_observaciones` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idCheckOutDetalle`),
  INDEX `fk_checkoutdetalle_producto1_idx` (`idProducto` ASC),
  INDEX `fk_checkoutdetalle_checkout1_idx` (`idCheckOut` ASC),
  CONSTRAINT `fk_checkoutdetalle_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `forrajera`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkoutdetalle_checkout1`
    FOREIGN KEY (`idCheckOut`)
    REFERENCES `forrajera`.`checkout` (`idCheckOut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`cliente` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`cliente` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `cli_rfc` VARCHAR(18) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `cli_rason_social` VARCHAR(255) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `cli_estatus` INT(11) NULL DEFAULT '1',
  `key` VARCHAR(60) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idEmpresa` INT(11) NOT NULL,
  `cli_observaciones` VARCHAR(500) CHARACTER SET 'latin1' COLLATE 'latin1_spanish_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_cliente_empresa1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_cliente_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_spanish_ci;


-- -----------------------------------------------------
-- Table `forrajera`.`configuracionempresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`configuracionempresa` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`configuracionempresa` (
  `idConfiguracionEmpresa` INT(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` INT(11) NOT NULL,
  `conf_integracion` INT(11) NULL DEFAULT '1',
  `conf_caduca` INT(11) NULL DEFAULT '1',
  `conf_fecha_caduca` DATE NULL DEFAULT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConfiguracionEmpresa`),
  INDEX `fk_configuracionempresa_empresa1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_configuracionempresa_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_spanish_ci;


-- -----------------------------------------------------
-- Table `forrajera`.`gastotipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`gastotipo` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`gastotipo` (
  `idGastoTipo` INT(11) NOT NULL AUTO_INCREMENT,
  `gati_descripcion` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`idGastoTipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`gastos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`gastos` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`gastos` (
  `idGastos` INT(11) NOT NULL AUTO_INCREMENT,
  `gas_monto` FLOAT NULL DEFAULT NULL,
  `caja_idCaja` INT(11) NOT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `gas_descripcion` VARCHAR(1000) NULL DEFAULT NULL,
  `idGastoTipo` INT(11) NOT NULL,
  PRIMARY KEY (`idGastos`),
  INDEX `fk_cajadetalle_caja1_idx` (`caja_idCaja` ASC),
  INDEX `fk_gastos_gastostipo1_idx` (`idGastoTipo` ASC),
  CONSTRAINT `fk_cajadetalle_caja1`
    FOREIGN KEY (`caja_idCaja`)
    REFERENCES `forrajera`.`caja` (`idCaja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gastos_gastostipo1`
    FOREIGN KEY (`idGastoTipo`)
    REFERENCES `forrajera`.`gastotipo` (`idGastoTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`listaprecio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`listaprecio` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`listaprecio` (
  `idListaPrecio` INT(11) NOT NULL AUTO_INCREMENT,
  `lpr_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `lpr_descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `lpr_estatus` INT(11) NULL DEFAULT '1',
  `idEmpresa` INT(11) NOT NULL,
  `idSucursal` INT(11) NULL DEFAULT '0',
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idListaPrecio`),
  INDEX `fk_listaprecio_empresa1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_listaprecio_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`precio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`precio` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`precio` (
  `idPrecio` INT(11) NOT NULL AUTO_INCREMENT,
  `idListaPrecio` INT(11) NOT NULL,
  `idProducto` INT(11) NOT NULL,
  `precio_compra` FLOAT NULL DEFAULT NULL,
  `precio_venta` FLOAT NULL DEFAULT NULL,
  `pre_estatus` VARCHAR(45) NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPrecio`),
  INDEX `fk_precio_listaprecio1_idx` (`idListaPrecio` ASC),
  INDEX `fk_precio_producto1_idx` (`idProducto` ASC),
  CONSTRAINT `fk_precio_listaprecio1`
    FOREIGN KEY (`idListaPrecio`)
    REFERENCES `forrajera`.`listaprecio` (`idListaPrecio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_precio_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `forrajera`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`stock` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`stock` (
  `idStock` INT(11) NOT NULL AUTO_INCREMENT,
  `idProducto` INT(11) NOT NULL,
  `idEmpresa` INT(11) NOT NULL,
  `idSucursal` INT(11) NOT NULL,
  `sto_cantidad` FLOAT NULL DEFAULT '0',
  PRIMARY KEY (`idStock`),
  INDEX `fk_stock_producto1_idx` (`idProducto` ASC),
  INDEX `fk_stock_empresa1_idx` (`idEmpresa` ASC),
  INDEX `fk_stock_sucursal1_idx` (`idSucursal` ASC),
  CONSTRAINT `fk_stock_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stock_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `forrajera`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stock_sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`inventario` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`inventario` (
  `idInventario` INT NOT NULL AUTO_INCREMENT,
  `inv_nombre` VARCHAR(45) NULL,
  `inv_descripcion` VARCHAR(45) NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `idSucursal` INT(11) NOT NULL,
  `idEmpresa` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  PRIMARY KEY (`idInventario`),
  INDEX `fk_inventario_sucursal1_idx` (`idSucursal` ASC),
  INDEX `fk_inventario_empresa1_idx` (`idEmpresa` ASC),
  INDEX `fk_inventario_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_inventario_sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventario_empresa1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `forrajera`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventario_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `forrajera`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forrajera`.`stockhistorial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`stockhistorial` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`stockhistorial` (
  `idStockHistorial` INT(11) NOT NULL AUTO_INCREMENT,
  `sto_cantidad` VARCHAR(45) NULL DEFAULT NULL,
  `sto_observaciones` VARCHAR(1000) NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `idStock` INT(11) NOT NULL,
  `idInventario` INT NOT NULL,
  PRIMARY KEY (`idStockHistorial`),
  INDEX `fk_stokhistorial_stock1_idx` (`idStock` ASC),
  INDEX `fk_stockhistorial_inventario1_idx` (`idInventario` ASC),
  CONSTRAINT `fk_stokhistorial_stock1`
    FOREIGN KEY (`idStock`)
    REFERENCES `forrajera`.`stock` (`idStock`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stockhistorial_inventario1`
    FOREIGN KEY (`idInventario`)
    REFERENCES `forrajera`.`inventario` (`idInventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`traspaso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`traspaso` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`traspaso` (
  `idTraspaso` INT(11) NOT NULL AUTO_INCREMENT,
  `idSucursalOrigen` INT(11) NOT NULL,
  `idSucursalDestino` INT(11) NOT NULL,
  `idUsuario` INT(11) NOT NULL,
  `tra_observaciones` VARCHAR(45) NULL DEFAULT NULL,
  `timestamp` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idTraspaso`),
  INDEX `fk_traspaso_sucursal1_idx` (`idSucursalOrigen` ASC),
  INDEX `fk_traspaso_sucursal2_idx` (`idSucursalDestino` ASC),
  INDEX `fk_traspaso_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_traspaso_sucursal1`
    FOREIGN KEY (`idSucursalOrigen`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_traspaso_sucursal2`
    FOREIGN KEY (`idSucursalDestino`)
    REFERENCES `forrajera`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_traspaso_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `forrajera`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`traspasocheckin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`traspasocheckin` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`traspasocheckin` (
  `idTraspasoCheckIn` INT(11) NOT NULL AUTO_INCREMENT,
  `idTraspaso` INT(11) NOT NULL,
  `idCheckIn` INT(11) NOT NULL,
  PRIMARY KEY (`idTraspasoCheckIn`),
  INDEX `fk_traspasocheckin_traspaso1_idx` (`idTraspaso` ASC),
  INDEX `fk_traspasocheckin_checkin1_idx` (`idCheckIn` ASC),
  CONSTRAINT `fk_traspasocheckin_checkin1`
    FOREIGN KEY (`idCheckIn`)
    REFERENCES `forrajera`.`checkin` (`idCheckIn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_traspasocheckin_traspaso1`
    FOREIGN KEY (`idTraspaso`)
    REFERENCES `forrajera`.`traspaso` (`idTraspaso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`traspasocheckout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`traspasocheckout` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`traspasocheckout` (
  `idTraspasoCheckOut` INT(11) NOT NULL AUTO_INCREMENT,
  `idTraspaso` INT(11) NOT NULL,
  `idCheckOut` INT(11) NOT NULL,
  PRIMARY KEY (`idTraspasoCheckOut`),
  INDEX `fk_traspasocheckout_traspaso1_idx` (`idTraspaso` ASC),
  INDEX `fk_traspasocheckout_checkout1_idx` (`idCheckOut` ASC),
  CONSTRAINT `fk_traspasocheckout_checkout1`
    FOREIGN KEY (`idCheckOut`)
    REFERENCES `forrajera`.`checkout` (`idCheckOut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_traspasocheckout_traspaso1`
    FOREIGN KEY (`idTraspaso`)
    REFERENCES `forrajera`.`traspaso` (`idTraspaso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`traspasodetalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`traspasodetalle` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`traspasodetalle` (
  `idTraspasoDetalle` INT(11) NOT NULL AUTO_INCREMENT,
  `idStock` INT(11) NOT NULL,
  `trde_cantidad` FLOAT NOT NULL,
  `trde_observaciones` VARCHAR(500) NULL DEFAULT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idTraspaso` INT(11) NOT NULL,
  PRIMARY KEY (`idTraspasoDetalle`),
  INDEX `fk_traspaso_stock1_idx` (`idStock` ASC),
  INDEX `fk_traspaso_traspaso1_idx` (`idTraspaso` ASC),
  CONSTRAINT `fk_traspaso_stock1`
    FOREIGN KEY (`idStock`)
    REFERENCES `forrajera`.`stock` (`idStock`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_traspaso_traspaso1`
    FOREIGN KEY (`idTraspaso`)
    REFERENCES `forrajera`.`traspaso` (`idTraspaso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forrajera`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`venta` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`venta` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `idCaja` INT(11) NOT NULL,
  `idCheckOut` INT(11) NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_venta_caja1_idx` (`idCaja` ASC),
  INDEX `fk_venta_checkout1_idx` (`idCheckOut` ASC),
  CONSTRAINT `fk_venta_caja1`
    FOREIGN KEY (`idCaja`)
    REFERENCES `forrajera`.`caja` (`idCaja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_checkout1`
    FOREIGN KEY (`idCheckOut`)
    REFERENCES `forrajera`.`checkout` (`idCheckOut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forrajera`.`mezcla`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forrajera`.`mezcla` ;

CREATE TABLE IF NOT EXISTS `forrajera`.`mezcla` (
  `idMezcla` INT NOT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `idCheckOut` INT(11) NOT NULL,
  `checkin_idCheckIn` INT(11) NOT NULL,
  PRIMARY KEY (`idMezcla`),
  INDEX `fk_mezcla_checkout1_idx` (`idCheckOut` ASC),
  INDEX `fk_mezcla_checkin1_idx` (`checkin_idCheckIn` ASC),
  CONSTRAINT `fk_mezcla_checkout1`
    FOREIGN KEY (`idCheckOut`)
    REFERENCES `forrajera`.`checkout` (`idCheckOut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mezcla_checkin1`
    FOREIGN KEY (`checkin_idCheckIn`)
    REFERENCES `forrajera`.`checkin` (`idCheckIn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `forrajera` ;

-- -----------------------------------------------------
-- procedure LOGIN_SP
-- -----------------------------------------------------

USE `forrajera`;
DROP procedure IF EXISTS `forrajera`.`LOGIN_SP`;

DELIMITER $$
USE `forrajera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGIN_SP`(
	IN usuario VARCHAR(200) CHARSET utf8,
    IN contrasenia VARCHAR(200) CHARSET utf8
)
BEGIN
	SELECT * 
	FROM usuario
	WHERE usu_usuario = usuario AND usu_password = contrasenia;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PRODUCTOEDITAR_SP
-- -----------------------------------------------------

USE `forrajera`;
DROP procedure IF EXISTS `forrajera`.`PRODUCTOEDITAR_SP`;

DELIMITER $$
USE `forrajera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PRODUCTOEDITAR_SP`(
	IN sku VARCHAR(100) CHARSET utf8,
    IN nombre VARCHAR(500) CHARSET utf8,
    IN descripcion VARCHAR(1000) CHARSET utf8,
    IN unidad VARCHAR(300) CHARSET utf8,
    IN productoID INT
)
BEGIN
	UPDATE producto 
    SET pro_sku 		= sku,
		pro_nombre 		= nombre,
        pro_descripcion	= descripcion,
        pro_unidad		= unidad
	WHERE idProducto = productoID;	
    
    SELECT 1 AS 'success', 'Se ha actualizado correctamente el producto.' AS 'msg';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PRODUCTOELIMINAR_SP
-- -----------------------------------------------------

USE `forrajera`;
DROP procedure IF EXISTS `forrajera`.`PRODUCTOELIMINAR_SP`;

DELIMITER $$
USE `forrajera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PRODUCTOELIMINAR_SP`(
	IN productoID INT
)
BEGIN
	UPDATE producto SET pro_estatus = 0	WHERE idProducto = productoID;    
    SELECT 1 AS 'success', 'El producto se ha eliminado correctamente.' AS 'msg';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PRODUCTOMUESTRA_SP
-- -----------------------------------------------------

USE `forrajera`;
DROP procedure IF EXISTS `forrajera`.`PRODUCTOMUESTRA_SP`;

DELIMITER $$
USE `forrajera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PRODUCTOMUESTRA_SP`(
	IN empresaID INT
)
BEGIN
	SELECT * FROM producto WHERE idEmpresa = empresaID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PRODUCTONUEVO_SP
-- -----------------------------------------------------

USE `forrajera`;
DROP procedure IF EXISTS `forrajera`.`PRODUCTONUEVO_SP`;

DELIMITER $$
USE `forrajera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PRODUCTONUEVO_SP`(
	IN sku VARCHAR(100) CHARSET utf8,
    IN nombre VARCHAR(500) CHARSET utf8,
    IN descripcion VARCHAR(1000) CHARSET utf8,
    IN unidad VARCHAR(300) CHARSET utf8,
    IN empresa INT
)
BEGIN
	INSERT INTO producto( pro_sku, pro_nombre, pro_descripcion, pro_unidad, idEmpresa ) 
    VALUES( sku, nombre, descripcion, unidad, empresa );
    
    SELECT 1 AS 'success', 'Se ha registrado correctamente un producto nuevo.' AS 'msg', LAST_INSERT_ID() as 'LastId';
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
