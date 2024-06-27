-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2024 at 11:26 AM
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
-- Database: `carlos`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_detalle_pedido` (IN `p_pedido_id` INT, IN `p_empresa_prov_original` VARCHAR(40), IN `p_empresa_prov` VARCHAR(40), IN `p_corte_tarjeta` INT, IN `p_porcentaje_descuento` INT)   BEGIN
    UPDATE carlos_detalle_p
    SET empresa_prov = p_empresa_prov, 
        corte_tarjeta = p_corte_tarjeta, 
        porcentaje_descuento = p_porcentaje_descuento
    WHERE pedido_f_num_pedido = p_pedido_id AND empresa_prov = p_empresa_prov_original;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_pedido` (IN `p_propietario_id` INT, IN `p_cant_tarjetas` INT, IN `p_cost_tarjeta` INT, IN `p_empresa_prov` VARCHAR(40), IN `p_corte_tarjeta` INT, IN `p_porcentaje_descuento` INT)   BEGIN
    DECLARE last_insert_id INT;

    -- Insertar nuevo pedido
    INSERT INTO carlos_pedido (propietario_f_id_propietario, cant_tarjetas, cost_tarjeta, fecha_pedido)
    VALUES (p_propietario_id, p_cant_tarjetas, p_cost_tarjeta, NOW());

    -- Obtener el ID del último pedido insertado
    SET last_insert_id = LAST_INSERT_ID();

    -- Insertar detalles del pedido
    INSERT INTO carlos_detalle_p (pedido_f_num_pedido, empresa_prov, corte_tarjeta, porcentaje_descuento)
    VALUES (last_insert_id, p_empresa_prov, p_corte_tarjeta, p_porcentaje_descuento);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aumentar_pedidos` ()   BEGIN
    UPDATE carlos_pedido SET activo = 0 WHERE activo = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_pedido` (IN `p_pedido_id` INT)   BEGIN
    -- Eliminar los detalles del pedido
    DELETE FROM carlos_detalle_p WHERE pedido_f_num_pedido = p_pedido_id;
    -- Eliminar el pedido
    DELETE FROM carlos_pedido WHERE num_pedido = p_pedido_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_pedido` (IN `p_num_pedido` INT, IN `p_propietario_id` INT, IN `p_cant_tarjetas` INT, IN `p_cost_tarjeta` DECIMAL(10,2), IN `p_empresa_prov` VARCHAR(50), IN `p_corte_tarjeta` INT, IN `p_porcentaje_descuento` INT)   BEGIN
    -- Actualizar los datos en la tabla pedido
    UPDATE carlos_pedido 
    SET 
        propietario_f_id_propietario = p_propietario_id,
        cant_tarjetas = p_cant_tarjetas,
        cost_tarjeta = p_cost_tarjeta,
        empresa_prov = p_empresa_prov,
        corte_tarjeta = p_corte_tarjeta,
        porcentaje_descuento = p_porcentaje_descuento
    WHERE 
        num_pedido = p_num_pedido;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_detalle_pedido` (IN `p_pedido_id` INT, IN `p_empresa_prov` VARCHAR(40))   BEGIN
    SELECT * FROM carlos_detalle_p
    WHERE pedido_f_num_pedido = p_pedido_id AND empresa_prov = p_empresa_prov;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_pedidos_activos` ()   BEGIN
    SELECT p.num_pedido, p.fecha_pedido, p.propietario_f_id_propietario, p.cant_tarjetas, p.cost_tarjeta, 
           d.empresa_prov, d.corte_tarjeta, d.porcentaje_descuento
    FROM carlos_pedido p
    INNER JOIN carlos_detalle_p d ON p.num_pedido = d.pedido_f_num_pedido
    WHERE p.activo = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_datos_propietario` ()   BEGIN
    SELECT p.nombre, p.apellido, p.fecha_nacimiento, p.correo, p.numero_telefono, p.direccion
    FROM carlos_propietario AS pr
    JOIN persona AS p ON pr.persona_f_ci_persona = p.ci_persona;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_descuento` ()   select * from vista_pedidoscon_descuento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_detalles_pedido` (IN `pedido_id` INT)   BEGIN
    SELECT empresa_prov, corte_tarjeta, porcentaje_descuento
    FROM carlos_detalle_p
    WHERE pedido_f_num_pedido = pedido_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_entel` ()   BEGIN
    SELECT *
    FROM vista_entel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_pedidos` ()   BEGIN
    SELECT *
    FROM carlos_pedido
    WHERE activo = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_pedidos_costo_mayor_100` ()   BEGIN
    SELECT *
    FROM vista_pedidos_costo_mayor_100;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_proveedores` ()   BEGIN
    SELECT * FROM carlos_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_tigo` ()   BEGIN
    SELECT *
    FROM vista_tigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_viva` ()   BEGIN
    SELECT *
    FROM 
    vista_viva;
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
-- Table structure for table `carlos_detalle_p`
--

CREATE TABLE `carlos_detalle_p` (
  `empresa_prov` varchar(40) NOT NULL,
  `corte_tarjeta` int(11) NOT NULL,
  `porcentaje_descuento` int(11) NOT NULL,
  `pedido_f_num_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carlos_detalle_p`
--

INSERT INTO `carlos_detalle_p` (`empresa_prov`, `corte_tarjeta`, `porcentaje_descuento`, `pedido_f_num_pedido`) VALUES
('Viva', 50, 0, 3),
('Entel', 30, 50, 4),
('Viva', 30, 10, 8),
('Entel', 10, 0, 10),
('Entel', 40, 100, 11),
('Tigo', 20, 0, 12),
('Entel', 10, 0, 13),
('Viva', 20, 30, 14),
('Tigo', 30, 20, 15),
('Entel', 40, 0, 16),
('Viva', 100, 0, 17),
('Entel', 20, 0, 19),
('Entel', 1, 0, 20),
('Entel', 20, 0, 22),
('Viva', 10, 50, 23),
('Viva', 10, 0, 24),
('Tigo', 40, 0, 25),
('Tigo', 200, 10, 27),
('Tigo', 50, 0, 28);

--
-- Triggers `carlos_detalle_p`
--
DELIMITER $$
CREATE TRIGGER `delete_detalle_p_trigger` AFTER DELETE ON `carlos_detalle_p` FOR EACH ROW BEGIN
    INSERT INTO historial (evento, tabla_afectada, id_registro_afectado, fecha)
    VALUES ('Eliminación', 'detalle_p', OLD.pedido_f_num_pedido, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `edit_detalle_p_trigger` AFTER UPDATE ON `carlos_detalle_p` FOR EACH ROW BEGIN
    INSERT INTO historial (evento, tabla_afectada, id_registro_afectado, fecha)
    VALUES ('Edición', 'detalle_p', OLD.pedido_f_num_pedido, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `carlos_pedido`
--

CREATE TABLE `carlos_pedido` (
  `num_pedido` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL DEFAULT current_timestamp(),
  `propietario_f_id_propietario` int(11) NOT NULL,
  `cant_tarjetas` int(11) NOT NULL,
  `cost_tarjeta` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carlos_pedido`
--

INSERT INTO `carlos_pedido` (`num_pedido`, `fecha_pedido`, `propietario_f_id_propietario`, `cant_tarjetas`, `cost_tarjeta`, `activo`) VALUES
(3, '2024-05-20', 11, 55, 100, 0),
(4, '2024-05-20', 11, 200, 2000, 0),
(8, '2024-05-20', 11, 20, 50, 0),
(10, '2024-05-23', 11, 10, 20, 0),
(11, '2024-05-23', 11, 20, 0, 0),
(12, '2024-05-23', 11, 20, 30, 0),
(13, '2024-05-23', 11, 20, 30, 0),
(14, '2024-05-23', 11, 20, 0, 0),
(15, '2024-05-23', 11, 20, 30, 0),
(16, '2024-05-23', 11, 20, 30, 0),
(17, '2024-05-23', 11, 40, 90, 0),
(19, '2024-05-23', 11, 50, 40, 0),
(20, '2024-05-23', 11, 30, 24, 0),
(22, '2024-06-05', 11, 50, 44, 0),
(23, '2024-06-15', 11, 80, 40, 0),
(24, '2024-06-16', 11, 80, 100, 0),
(25, '2024-06-16', 11, 30, 100, 0),
(27, '2024-06-17', 11, 100, 12, 0),
(28, '2024-06-17', 11, 4000, 30, 0);

--
-- Triggers `carlos_pedido`
--
DELIMITER $$
CREATE TRIGGER `tr_pedido_delete` AFTER DELETE ON `carlos_pedido` FOR EACH ROW BEGIN
    INSERT INTO historial (evento, tabla_afectada, id_registro_afectado)
    VALUES ('Eliminación', 'pedido', OLD.num_pedido);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_pedido_insert` AFTER INSERT ON `carlos_pedido` FOR EACH ROW BEGIN
    INSERT INTO historial (evento, tabla_afectada, id_registro_afectado)
    VALUES ('Inserción', 'pedido', NEW.num_pedido);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `carlos_propietario`
--

CREATE TABLE `carlos_propietario` (
  `persona_f_ci_persona` int(11) NOT NULL,
  `id_propietario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carlos_propietario`
--

INSERT INTO `carlos_propietario` (`persona_f_ci_persona`, `id_propietario`) VALUES
(8383883, 11);

-- --------------------------------------------------------

--
-- Table structure for table `carlos_proveedor`
--

CREATE TABLE `carlos_proveedor` (
  `id_proovedor` int(11) NOT NULL,
  `nombre_empresa` varchar(30) DEFAULT NULL,
  `correo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carlos_proveedor`
--

INSERT INTO `carlos_proveedor` (`id_proovedor`, `nombre_empresa`, `correo`) VALUES
(1, 'Entel', 'entel@gmail.com'),
(2, 'Viva', 'viva@gmail.com'),
(3, 'Tigo', 'tigo@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `carlos_tarjeta`
--

CREATE TABLE `carlos_tarjeta` (
  `cod_tarjeta` int(11) NOT NULL,
  `fecha_expiracion` date NOT NULL,
  `valor_tarjeta` int(11) NOT NULL,
  `fecha_activacion` date NOT NULL,
  `empresa_tarjeta` varchar(30) NOT NULL
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
-- Table structure for table `historial`
--

CREATE TABLE `historial` (
  `id_registro` int(11) NOT NULL,
  `evento` varchar(50) DEFAULT NULL,
  `tabla_afectada` varchar(50) DEFAULT NULL,
  `id_registro_afectado` int(11) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `historial`
--

INSERT INTO `historial` (`id_registro`, `evento`, `tabla_afectada`, `id_registro_afectado`, `fecha`) VALUES
(1, 'Inserción', 'pedido', 6, '2024-05-20 12:35:42'),
(2, 'Eliminación', 'detalle_p', 6, '2024-05-20 12:35:52'),
(3, 'Eliminación', 'pedido', 6, '2024-05-20 12:35:52'),
(4, 'Inserción', 'pedido', 8, '2024-05-20 14:46:48'),
(5, 'Edición', 'detalle_p', 8, '2024-05-20 14:47:24'),
(6, 'Eliminación', 'detalle_p', 1, '2024-05-24 00:58:04'),
(7, 'Eliminación', 'pedido', 1, '2024-05-24 00:58:04'),
(8, 'Inserción', 'pedido', 9, '2024-05-24 01:09:42'),
(9, 'Inserción', 'pedido', 10, '2024-05-24 01:14:55'),
(10, 'Inserción', 'pedido', 11, '2024-05-24 01:15:56'),
(11, 'Inserción', 'pedido', 12, '2024-05-24 01:26:03'),
(12, 'Inserción', 'pedido', 13, '2024-05-24 01:32:38'),
(13, 'Inserción', 'pedido', 14, '2024-05-24 01:32:58'),
(14, 'Inserción', 'pedido', 15, '2024-05-24 01:43:59'),
(15, 'Inserción', 'pedido', 16, '2024-05-24 01:58:08'),
(16, 'Inserción', 'pedido', 17, '2024-05-24 01:58:29'),
(17, 'Eliminación', 'detalle_p', 9, '2024-05-24 02:24:00'),
(18, 'Eliminación', 'pedido', 9, '2024-05-24 02:24:00'),
(19, 'Inserción', 'pedido', 18, '2024-05-24 02:26:02'),
(20, 'Eliminación', 'detalle_p', 18, '2024-05-24 02:26:27'),
(21, 'Eliminación', 'pedido', 18, '2024-05-24 02:26:27'),
(22, 'Inserción', 'pedido', 19, '2024-05-24 02:30:14'),
(23, 'Inserción', 'pedido', 20, '2024-05-24 02:56:57'),
(24, 'Inserción', 'pedido', 22, '2024-06-05 21:54:29'),
(25, 'Inserción', 'pedido', 23, '2024-06-15 22:29:44'),
(26, 'Inserción', 'pedido', 24, '2024-06-17 00:38:25'),
(27, 'Inserción', 'pedido', 25, '2024-06-17 03:58:21'),
(28, 'Edición', 'detalle_p', 3, '2024-06-17 08:17:26'),
(29, 'Inserción', 'pedido', 26, '2024-06-17 08:17:53'),
(30, 'Eliminación', 'detalle_p', 26, '2024-06-17 08:18:04'),
(31, 'Eliminación', 'pedido', 26, '2024-06-17 08:18:04'),
(32, 'Inserción', 'pedido', 27, '2024-06-17 08:19:01'),
(33, 'Inserción', 'pedido', 28, '2024-06-17 08:32:20');

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
('carmonlau', '12345678', 1);

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
(8383883, 'Carlos Walter', 'Montaño laura', '2004-08-03', 'carmonlau@gmail.com', 8474838, 'Miraflores', 'Propietario', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_entel`
-- (See below for the actual view)
--
CREATE TABLE `vista_entel` (
`empresa_prov` varchar(40)
,`corte_tarjeta` int(11)
,`porcentaje_descuento` int(11)
,`pedido_f_num_pedido` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_pedidoscon_descuento`
-- (See below for the actual view)
--
CREATE TABLE `vista_pedidoscon_descuento` (
`empresa_prov` varchar(40)
,`corte_tarjeta` int(11)
,`porcentaje_descuento` int(11)
,`pedido_f_num_pedido` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_pedidos_mayor_100`
-- (See below for the actual view)
--
CREATE TABLE `vista_pedidos_mayor_100` (
`num_pedido` int(11)
,`fecha_pedido` date
,`propietario_f_id_propietario` int(11)
,`cant_tarjetas` int(11)
,`cost_tarjeta` int(11)
,`activo` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_tigo`
-- (See below for the actual view)
--
CREATE TABLE `vista_tigo` (
`empresa_prov` varchar(40)
,`corte_tarjeta` int(11)
,`porcentaje_descuento` int(11)
,`pedido_f_num_pedido` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_viva`
-- (See below for the actual view)
--
CREATE TABLE `vista_viva` (
`empresa_prov` varchar(40)
,`corte_tarjeta` int(11)
,`porcentaje_descuento` int(11)
,`pedido_f_num_pedido` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `vista_entel`
--
DROP TABLE IF EXISTS `vista_entel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_entel`  AS SELECT `carlos_detalle_p`.`empresa_prov` AS `empresa_prov`, `carlos_detalle_p`.`corte_tarjeta` AS `corte_tarjeta`, `carlos_detalle_p`.`porcentaje_descuento` AS `porcentaje_descuento`, `carlos_detalle_p`.`pedido_f_num_pedido` AS `pedido_f_num_pedido` FROM `carlos_detalle_p` WHERE `carlos_detalle_p`.`empresa_prov` = 'Entel' ;

-- --------------------------------------------------------

--
-- Structure for view `vista_pedidoscon_descuento`
--
DROP TABLE IF EXISTS `vista_pedidoscon_descuento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pedidoscon_descuento`  AS SELECT `carlos_detalle_p`.`empresa_prov` AS `empresa_prov`, `carlos_detalle_p`.`corte_tarjeta` AS `corte_tarjeta`, `carlos_detalle_p`.`porcentaje_descuento` AS `porcentaje_descuento`, `carlos_detalle_p`.`pedido_f_num_pedido` AS `pedido_f_num_pedido` FROM `carlos_detalle_p` WHERE `carlos_detalle_p`.`porcentaje_descuento` > 0 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_pedidos_mayor_100`
--
DROP TABLE IF EXISTS `vista_pedidos_mayor_100`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pedidos_mayor_100`  AS SELECT `carlos_pedido`.`num_pedido` AS `num_pedido`, `carlos_pedido`.`fecha_pedido` AS `fecha_pedido`, `carlos_pedido`.`propietario_f_id_propietario` AS `propietario_f_id_propietario`, `carlos_pedido`.`cant_tarjetas` AS `cant_tarjetas`, `carlos_pedido`.`cost_tarjeta` AS `cost_tarjeta`, `carlos_pedido`.`activo` AS `activo` FROM `carlos_pedido` WHERE `carlos_pedido`.`cost_tarjeta` > 100 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_tigo`
--
DROP TABLE IF EXISTS `vista_tigo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_tigo`  AS SELECT `carlos_detalle_p`.`empresa_prov` AS `empresa_prov`, `carlos_detalle_p`.`corte_tarjeta` AS `corte_tarjeta`, `carlos_detalle_p`.`porcentaje_descuento` AS `porcentaje_descuento`, `carlos_detalle_p`.`pedido_f_num_pedido` AS `pedido_f_num_pedido` FROM `carlos_detalle_p` WHERE `carlos_detalle_p`.`empresa_prov` = 'Tigo' ;

-- --------------------------------------------------------

--
-- Structure for view `vista_viva`
--
DROP TABLE IF EXISTS `vista_viva`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_viva`  AS SELECT `carlos_detalle_p`.`empresa_prov` AS `empresa_prov`, `carlos_detalle_p`.`corte_tarjeta` AS `corte_tarjeta`, `carlos_detalle_p`.`porcentaje_descuento` AS `porcentaje_descuento`, `carlos_detalle_p`.`pedido_f_num_pedido` AS `pedido_f_num_pedido` FROM `carlos_detalle_p` WHERE `carlos_detalle_p`.`empresa_prov` = 'Viva' ;

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
-- Indexes for table `carlos_detalle_p`
--
ALTER TABLE `carlos_detalle_p`
  ADD PRIMARY KEY (`pedido_f_num_pedido`);

--
-- Indexes for table `carlos_pedido`
--
ALTER TABLE `carlos_pedido`
  ADD PRIMARY KEY (`num_pedido`),
  ADD UNIQUE KEY `num_pedido` (`num_pedido`),
  ADD KEY `pedido_f_propietario_f_fk` (`propietario_f_id_propietario`);

--
-- Indexes for table `carlos_propietario`
--
ALTER TABLE `carlos_propietario`
  ADD PRIMARY KEY (`persona_f_ci_persona`),
  ADD UNIQUE KEY `id_propietario` (`id_propietario`);

--
-- Indexes for table `carlos_proveedor`
--
ALTER TABLE `carlos_proveedor`
  ADD PRIMARY KEY (`id_proovedor`);

--
-- Indexes for table `carlos_tarjeta`
--
ALTER TABLE `carlos_tarjeta`
  ADD PRIMARY KEY (`cod_tarjeta`);

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
-- Indexes for table `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id_registro`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`);

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
-- AUTO_INCREMENT for table `carlos_pedido`
--
ALTER TABLE `carlos_pedido`
  MODIFY `num_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `historial`
--
ALTER TABLE `historial`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bd_tk`
--
ALTER TABLE `bd_tk`
  ADD CONSTRAINT `bd_f_tk_detallep_f_fk` FOREIGN KEY (`detallep_f_pedido_f_num_pedido`) REFERENCES `carlos_detalle_p` (`pedido_f_num_pedido`),
  ADD CONSTRAINT `bd_f_tk_tarjeta_f_fk` FOREIGN KEY (`tarjeta_f_cod_tarjeta`) REFERENCES `carlos_tarjeta` (`cod_tarjeta`);

--
-- Constraints for table `carlos_detalle_p`
--
ALTER TABLE `carlos_detalle_p`
  ADD CONSTRAINT `detallep_f_pedido_f_fk` FOREIGN KEY (`pedido_f_num_pedido`) REFERENCES `carlos_pedido` (`num_pedido`);

--
-- Constraints for table `carlos_pedido`
--
ALTER TABLE `carlos_pedido`
  ADD CONSTRAINT `pedido_f_propietario_f_fk` FOREIGN KEY (`propietario_f_id_propietario`) REFERENCES `carlos_propietario` (`id_propietario`);

--
-- Constraints for table `carlos_propietario`
--
ALTER TABLE `carlos_propietario`
  ADD CONSTRAINT `propietario_f_persona` FOREIGN KEY (`persona_f_ci_persona`) REFERENCES `persona` (`ci_persona`);

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
  ADD CONSTRAINT `dt_f_fk_tarjeta_f_fk` FOREIGN KEY (`tarjeta_f_cod_tarjeta`) REFERENCES `carlos_tarjeta` (`cod_tarjeta`);

--
-- Constraints for table `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_f_orden_f_fk` FOREIGN KEY (`orden_f_id_orden`) REFERENCES `orden` (`id_orden`),
  ADD CONSTRAINT `empleado_f_persona` FOREIGN KEY (`persona_f_ci_persona`) REFERENCES `persona` (`ci_persona`);

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
  ADD CONSTRAINT `pd_f_fk_pedido_f_fk` FOREIGN KEY (`pedido_f_num_pedido`) REFERENCES `carlos_pedido` (`num_pedido`),
  ADD CONSTRAINT `pd_f_fk_proveedor_f_fk` FOREIGN KEY (`proveedor_f_id_proovedor`) REFERENCES `carlos_proveedor` (`id_proovedor`);

--
-- Constraints for table `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_f_login_fk` FOREIGN KEY (`login_login_id`) REFERENCES `login` (`login_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
