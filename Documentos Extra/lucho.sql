-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2024 at 08:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lucho`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_pedido` (IN `p_propietario_id` INT, IN `p_cant_tarjetas` INT, IN `p_cost_pedido` INT, IN `p_empresa_prov` VARCHAR(40), IN `p_corte_tarjeta` INT, IN `p_porcentaje_descuento` INT)   BEGIN
    DECLARE last_insert_id INT;

    -- Insertar nuevo pedido
    INSERT INTO pedido (propietario_f_id_propietario, cant_tarjetas, cost_pedido, fecha_pedido)
    VALUES (p_propietario_id, p_cant_tarjetas, p_cost_pedido, NOW());

    -- Obtener el ID del último pedido insertado
    SET last_insert_id = LAST_INSERT_ID();

    -- Insertar detalles del pedido
    INSERT INTO detalle_p (pedido_f_num_pedido, empresa_prov, corte_tarjeta, porcentaje_descuento)
    VALUES (last_insert_id, p_empresa_prov, p_corte_tarjeta, p_porcentaje_descuento);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_DATOS_PERSONA` (IN `ci_persona` INT, IN `nombre` VARCHAR(30), IN `apellido` VARCHAR(40), IN `fecha_nacimiento` DATE, IN `correo` VARCHAR(50), IN `numero_telefono` INT, IN `direccion` VARCHAR(40))   BEGIN
    UPDATE persona SET nombre = nombre, apellido = apellido, fecha_nacimiento = fecha_nacimiento, correo = correo, numero_telefono = numero_telefono, direccion = direccion WHERE ci_persona = ci_persona;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_PROVEEDOR` (IN `id_proveedor` INT, IN `nombre_empresa` VARCHAR(30), IN `correo` VARCHAR(30))   BEGIN
    UPDATE lucho_proveedor SET nombre_empresa = nombre_empresa, correo = correo WHERE id_proovedor = id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_PROVEEDOR` (IN `id_proveedor` INT)   BEGIN
    DELETE FROM lucho_proveedor WHERE id_proovedor = id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insertar_Detalle_Pedido` (IN `empresa_prov` VARCHAR(40), IN `corte_tarjeta` INT, IN `porcentaje_descuento` INT, IN `pedido_f_num_pedido` INT)   BEGIN
    -- Insertar el detalle del pedido
    INSERT INTO lucho_detalle_p (empresa_prov, corte_tarjeta, porcentaje_descuento, pedido_f_num_pedido)
    VALUES (empresa_prov, corte_tarjeta, porcentaje_descuento, pedido_f_num_pedido);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insertar_Pedido` (IN `num_pedido` INT, IN `fecha_pedido` DATE, IN `id_propietario` INT, IN `cant_tarjetas` INT, IN `cost_pedido` INT)   BEGIN
    DECLARE propietario_exist INT;
    
    -- Verificar si el propietario existe
    SELECT COUNT(*) INTO propietario_exist
    FROM lucho_propietario
    WHERE id_propietario = id_propietario;
    
    IF propietario_exist > 0 THEN
        -- Insertar el pedido
        INSERT INTO pedido (num_pedido, fecha_pedido, propietario_f_id_propietario, cant_tarjetas, cost_pedido)
        VALUES (num_pedido, fecha_pedido, id_propietario, cant_tarjetas, cost_pedido);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ID del propietario no existe';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_PEDIDO_Y_DETALLE` (IN `p_propietario_id` INT, IN `p_cant_tarjetas` INT, IN `p_cost_pedido` INT, IN `p_empresa_prov` VARCHAR(40), IN `p_corte_tarjeta` INT, IN `p_porcentaje_descuento` INT)   BEGIN
    DECLARE last_insert_id INT;

    -- Insertar nuevo pedido
    INSERT INTO lucho_pedido (propietario_f_id_propietario, cant_tarjetas, cost_pedido, fecha_pedido)
    VALUES (p_propietario_id, p_cant_tarjetas, p_cost_pedido, NOW());

    -- Obtener el ID del último pedido insertado
    SET last_insert_id = LAST_INSERT_ID();

    -- Insertar detalles del pedido
    INSERT INTO lucho_detalle_p (pedido_f_num_pedido, empresa_prov, corte_tarjeta, porcentaje_descuento)
    VALUES (last_insert_id, p_empresa_prov, p_corte_tarjeta, p_porcentaje_descuento);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_datos_persona` (IN `persona_id` INT)   BEGIN
    SELECT * FROM persona WHERE ci_persona = persona_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VERIFICAR_ID_PROPIETARIO` (IN `p_propietario_id` INT)   BEGIN
    SELECT COUNT(*) AS count 
    FROM lucho_propietario 
    WHERE id_propietario = p_propietario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_DATOS_EMPLEADO` ()   BEGIN
    SELECT p.ci_persona, p.nombre, p.apellido, p.fecha_nacimiento, p.correo, p.numero_telefono, p.direccion, e.id_empleado, e.puesto, e.salario, e.orden_f_id_orden
    FROM persona p
    INNER JOIN empleado e ON p.ci_persona = e.persona_f_ci_persona;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_DATOS_PEDIDO` ()   BEGIN
    SELECT * FROM pedido;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_DATOS_PERSONA` ()   BEGIN
    SELECT * FROM persona;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_DATOS_PROVEEDOR` ()   select * from proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_DETALLES_PEDIDO` (IN `numPedido` INT)   BEGIN
    SELECT * FROM detalle_p WHERE pedido_f_num_pedido = numPedido;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_pedidos_costo_mayor_100` ()   BEGIN
    SELECT *
    FROM vista_pedidos_costo_mayor_100;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bd_tk`
--

CREATE TABLE `bd_tk` (
  `tarjeta_f_cod_tarjeta` int(11) NOT NULL,
  `detallep_f_pedido_f_num_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `nombre` varchar(30) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `fecha_registro` date NOT NULL,
  `discr` varchar(30) DEFAULT NULL,
  `apellido_cliente` varchar(30) NOT NULL,
  `cliente_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ord`
--

CREATE TABLE `detalle_ord` (
  `cantidad_tarje` int(11) NOT NULL,
  `empresa` varchar(30) NOT NULL,
  `costo_tarjeta` int(11) NOT NULL,
  `corte_tarjeta` int(11) NOT NULL,
  `orden_f_id_orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dt_fk`
--

CREATE TABLE `dt_fk` (
  `detalle_ord_f_empresa` varchar(30) NOT NULL,
  `tarjeta_f_cod_tarjeta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `empleado`
--

CREATE TABLE `empleado` (
  `persona_f_ci_persona` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `puesto` varchar(30) NOT NULL,
  `salario` int(11) NOT NULL,
  `orden_f_id_orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `usuario` varchar(30) NOT NULL,
  `contrasena` varchar(30) NOT NULL,
  `login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`usuario`, `contrasena`, `login_id`) VALUES
('luchoaranda', '12345678', 2),
('carmon', '12345678', 2024);

-- --------------------------------------------------------

--
-- Table structure for table `lucho_detalle_p`
--

CREATE TABLE `lucho_detalle_p` (
  `empresa_prov` varchar(40) NOT NULL,
  `corte_tarjeta` int(11) NOT NULL,
  `porcentaje_descuento` int(11) NOT NULL,
  `pedido_f_num_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lucho_detalle_p`
--

INSERT INTO `lucho_detalle_p` (`empresa_prov`, `corte_tarjeta`, `porcentaje_descuento`, `pedido_f_num_pedido`) VALUES
('Tigo', 30, 0, 4),
('Viva', 10, 0, 8),
('Viva', 123, 0, 9),
('Entel', 123, 123, 11),
('Entel', 11, 11, 12),
('Entel', 10, 0, 13),
('Viva', 50, 0, 14),
('Entel', 100, 0, 15),
('Tigo', 50, 10, 21),
('Entel', 10, 0, 23);

-- --------------------------------------------------------

--
-- Table structure for table `lucho_pedido`
--

CREATE TABLE `lucho_pedido` (
  `num_pedido` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL DEFAULT current_timestamp(),
  `propietario_f_id_propietario` int(11) NOT NULL,
  `cant_tarjetas` int(11) NOT NULL,
  `cost_pedido` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lucho_pedido`
--

INSERT INTO `lucho_pedido` (`num_pedido`, `fecha_pedido`, `propietario_f_id_propietario`, `cant_tarjetas`, `cost_pedido`) VALUES
(4, '2024-05-21', 23, 10, 200),
(8, '2024-05-22', 23, 100, 10),
(9, '2024-05-22', 23, 999, 12),
(11, '2024-05-22', 23, 123, 123),
(12, '2024-05-22', 23, 11, 11),
(13, '2024-05-24', 23, 10, 10000),
(14, '2024-05-27', 23, 1000, 50000),
(15, '2024-05-27', 23, 100, 10000),
(21, '2024-05-27', 23, 100, 5000),
(23, '2024-06-17', 23, 80, 800);

-- --------------------------------------------------------

--
-- Table structure for table `lucho_propietario`
--

CREATE TABLE `lucho_propietario` (
  `persona_f_ci_persona` int(11) NOT NULL,
  `id_propietario` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lucho_propietario`
--

INSERT INTO `lucho_propietario` (`persona_f_ci_persona`, `id_propietario`, `activo`) VALUES
(323232, 23, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lucho_proveedor`
--

CREATE TABLE `lucho_proveedor` (
  `id_proovedor` int(11) NOT NULL,
  `nombre_empresa` varchar(30) DEFAULT NULL,
  `correo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lucho_proveedor`
--

INSERT INTO `lucho_proveedor` (`id_proovedor`, `nombre_empresa`, `correo`) VALUES
(234234, 'Viva', 'viva111@gmail.com'),
(312312, 'Tigo', 'tigo2121@gmail.com'),
(1234324, 'Entel', 'entel12112@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `lucho_tarjeta`
--

CREATE TABLE `lucho_tarjeta` (
  `cod_tarjeta` int(11) NOT NULL,
  `fecha_expiracion` date NOT NULL,
  `valor_tarjeta` int(11) NOT NULL,
  `fecha_activacion` date NOT NULL,
  `empresa_tarjeta` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mayorista`
--

CREATE TABLE `mayorista` (
  `id_cliente` int(11) NOT NULL,
  `id_mayorista` int(11) NOT NULL,
  `telefono_contacto` int(11) NOT NULL,
  `descuento` int(11) NOT NULL,
  `cliente_f_cliente_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `minorista`
--

CREATE TABLE `minorista` (
  `id_cliente` int(11) NOT NULL,
  `id_minorista` int(11) NOT NULL,
  `telefono_contacto` int(11) NOT NULL,
  `cliente_f_cliente_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orden`
--

CREATE TABLE `orden` (
  `id_orden` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `cliente_f_cliente_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pd_fk`
--

CREATE TABLE `pd_fk` (
  `pedido_f_num_pedido` int(11) NOT NULL,
  `proveedor_f_id_proovedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--

CREATE TABLE `persona` (
  `ci_persona` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `numero_telefono` int(11) NOT NULL,
  `direccion` varchar(40) DEFAULT NULL,
  `disc` varchar(30) DEFAULT NULL,
  `login_login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`ci_persona`, `nombre`, `apellido`, `fecha_nacimiento`, `correo`, `numero_telefono`, `direccion`, `disc`, `login_login_id`) VALUES
(123122, 'Jose Luis', 'Aranda Quino', '2014-05-22', 'luisaranda@gmail.com', 8474838, 'Miraflores', 'Empleado', 2),
(323232, 'Carlos', 'Montaño', '2024-05-01', 'carlos@gmail.com', 73730202, 'Tembladerani', 'Propietario', 2024);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_costo_mayor_1000`
-- (See below for the actual view)
--
CREATE TABLE `vista_costo_mayor_1000` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_pedidos_costo_mayor_100`
-- (See below for the actual view)
--
CREATE TABLE `vista_pedidos_costo_mayor_100` (
);

-- --------------------------------------------------------

--
-- Structure for view `vista_costo_mayor_1000`
--
DROP TABLE IF EXISTS `vista_costo_mayor_1000`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_costo_mayor_1000`  AS SELECT `pedido`.`num_pedido` AS `num_pedido`, `pedido`.`fecha_pedido` AS `fecha_pedido`, `pedido`.`propietario_f_id_propietario` AS `propietario_f_id_propietario`, `pedido`.`cant_tarjetas` AS `cant_tarjetas`, `pedido`.`cost_pedido` AS `cost_pedido` FROM `pedido` WHERE `pedido`.`cost_pedido` > 1000 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_pedidos_costo_mayor_100`
--
DROP TABLE IF EXISTS `vista_pedidos_costo_mayor_100`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pedidos_costo_mayor_100`  AS SELECT `pedido`.`num_pedido` AS `num_pedido`, `pedido`.`fecha_pedido` AS `fecha_pedido`, `pedido`.`propietario_f_id_propietario` AS `propietario_f_id_propietario`, `pedido`.`cant_tarjetas` AS `cant_tarjetas`, `pedido`.`cost_pedido` AS `cost_pedido` FROM `pedido` WHERE `pedido`.`cost_pedido` > 100 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bd_tk`
--
ALTER TABLE `bd_tk`
  ADD PRIMARY KEY (`tarjeta_f_cod_tarjeta`,`detallep_f_pedido_f_num_pedido`),
  ADD KEY `bd_f_tk_detallep_f_fk` (`detallep_f_pedido_f_num_pedido`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_f_id`),
  ADD UNIQUE KEY `cliente_f_id` (`cliente_f_id`);

--
-- Indexes for table `detalle_ord`
--
ALTER TABLE `detalle_ord`
  ADD PRIMARY KEY (`empresa`),
  ADD KEY `detalle_ord_f_orden_f_fk` (`orden_f_id_orden`);

--
-- Indexes for table `dt_fk`
--
ALTER TABLE `dt_fk`
  ADD PRIMARY KEY (`detalle_ord_f_empresa`,`tarjeta_f_cod_tarjeta`),
  ADD KEY `dt_f_fk_tarjeta_f_fk` (`tarjeta_f_cod_tarjeta`);

--
-- Indexes for table `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`persona_f_ci_persona`),
  ADD UNIQUE KEY `id_empleado` (`id_empleado`),
  ADD KEY `empleado_f_orden_f_fk` (`orden_f_id_orden`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `lucho_detalle_p`
--
ALTER TABLE `lucho_detalle_p`
  ADD PRIMARY KEY (`pedido_f_num_pedido`);

--
-- Indexes for table `lucho_pedido`
--
ALTER TABLE `lucho_pedido`
  ADD PRIMARY KEY (`num_pedido`),
  ADD KEY `pedido_f_propietario_f_fk` (`propietario_f_id_propietario`),
  ADD KEY `idx_propietario_id` (`propietario_f_id_propietario`);

--
-- Indexes for table `lucho_propietario`
--
ALTER TABLE `lucho_propietario`
  ADD PRIMARY KEY (`persona_f_ci_persona`),
  ADD UNIQUE KEY `id_propietario` (`id_propietario`);

--
-- Indexes for table `lucho_proveedor`
--
ALTER TABLE `lucho_proveedor`
  ADD PRIMARY KEY (`id_proovedor`);

--
-- Indexes for table `lucho_tarjeta`
--
ALTER TABLE `lucho_tarjeta`
  ADD PRIMARY KEY (`cod_tarjeta`);

--
-- Indexes for table `mayorista`
--
ALTER TABLE `mayorista`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `id_mayorista` (`id_mayorista`),
  ADD KEY `mayorista_f_cliente` (`cliente_f_cliente_f_id`);

--
-- Indexes for table `minorista`
--
ALTER TABLE `minorista`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `id_minorista` (`id_minorista`),
  ADD KEY `minorista_f_cliente` (`cliente_f_cliente_f_id`);

--
-- Indexes for table `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`id_orden`),
  ADD KEY `orden_f_cliente_f_fk` (`cliente_f_cliente_f_id`);

--
-- Indexes for table `pd_fk`
--
ALTER TABLE `pd_fk`
  ADD PRIMARY KEY (`pedido_f_num_pedido`,`proveedor_f_id_proovedor`),
  ADD KEY `pd_f_fk_proveedor_f_fk` (`proveedor_f_id_proovedor`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ci_persona`),
  ADD UNIQUE KEY `persona_idx` (`login_login_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lucho_pedido`
--
ALTER TABLE `lucho_pedido`
  MODIFY `num_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `lucho_propietario`
--
ALTER TABLE `lucho_propietario`
  MODIFY `persona_f_ci_persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=323233;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bd_tk`
--
ALTER TABLE `bd_tk`
  ADD CONSTRAINT `bd_f_tk_detallep_f_fk` FOREIGN KEY (`detallep_f_pedido_f_num_pedido`) REFERENCES `lucho_detalle_p` (`pedido_f_num_pedido`),
  ADD CONSTRAINT `bd_f_tk_tarjeta_f_fk` FOREIGN KEY (`tarjeta_f_cod_tarjeta`) REFERENCES `lucho_tarjeta` (`cod_tarjeta`);

--
-- Constraints for table `detalle_ord`
--
ALTER TABLE `detalle_ord`
  ADD CONSTRAINT `detalle_ord_f_orden_f_fk` FOREIGN KEY (`orden_f_id_orden`) REFERENCES `orden` (`id_orden`);

--
-- Constraints for table `dt_fk`
--
ALTER TABLE `dt_fk`
  ADD CONSTRAINT `dt_f_fk_detalle_ord_f_fk` FOREIGN KEY (`detalle_ord_f_empresa`) REFERENCES `detalle_ord` (`empresa`),
  ADD CONSTRAINT `dt_f_fk_tarjeta_f_fk` FOREIGN KEY (`tarjeta_f_cod_tarjeta`) REFERENCES `lucho_tarjeta` (`cod_tarjeta`);

--
-- Constraints for table `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_f_orden_f_fk` FOREIGN KEY (`orden_f_id_orden`) REFERENCES `orden` (`id_orden`),
  ADD CONSTRAINT `empleado_f_persona` FOREIGN KEY (`persona_f_ci_persona`) REFERENCES `persona` (`ci_persona`);

--
-- Constraints for table `lucho_detalle_p`
--
ALTER TABLE `lucho_detalle_p`
  ADD CONSTRAINT `detallep_f_pedido_f_fk` FOREIGN KEY (`pedido_f_num_pedido`) REFERENCES `lucho_pedido` (`num_pedido`);

--
-- Constraints for table `lucho_pedido`
--
ALTER TABLE `lucho_pedido`
  ADD CONSTRAINT `pedido_f_propietario_f_fk` FOREIGN KEY (`propietario_f_id_propietario`) REFERENCES `lucho_propietario` (`id_propietario`);

--
-- Constraints for table `lucho_propietario`
--
ALTER TABLE `lucho_propietario`
  ADD CONSTRAINT `propietario_f_persona` FOREIGN KEY (`persona_f_ci_persona`) REFERENCES `persona` (`ci_persona`);

--
-- Constraints for table `mayorista`
--
ALTER TABLE `mayorista`
  ADD CONSTRAINT `mayorista_f_cliente` FOREIGN KEY (`cliente_f_cliente_f_id`) REFERENCES `cliente` (`cliente_f_id`);

--
-- Constraints for table `minorista`
--
ALTER TABLE `minorista`
  ADD CONSTRAINT `minorista_f_cliente` FOREIGN KEY (`cliente_f_cliente_f_id`) REFERENCES `cliente` (`cliente_f_id`);

--
-- Constraints for table `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_f_cliente_f_fk` FOREIGN KEY (`cliente_f_cliente_f_id`) REFERENCES `cliente` (`cliente_f_id`);

--
-- Constraints for table `pd_fk`
--
ALTER TABLE `pd_fk`
  ADD CONSTRAINT `pd_f_fk_pedido_f_fk` FOREIGN KEY (`pedido_f_num_pedido`) REFERENCES `lucho_pedido` (`num_pedido`),
  ADD CONSTRAINT `pd_f_fk_proveedor_f_fk` FOREIGN KEY (`proveedor_f_id_proovedor`) REFERENCES `lucho_proveedor` (`id_proovedor`);

--
-- Constraints for table `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_f_login_fk` FOREIGN KEY (`login_login_id`) REFERENCES `login` (`login_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
