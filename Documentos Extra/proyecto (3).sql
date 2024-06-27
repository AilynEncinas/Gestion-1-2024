-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 10:34:11
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTUALIZAR_CLIENTE` (IN `idCli` INT, IN `name` VARCHAR(50), IN `apell` VARCHAR(50), IN `dir` VARCHAR(100), IN `fechaReg` DATE, IN `tipo` VARCHAR(20))   BEGIN
    UPDATE cliente 
    SET nombre = name, 
        direccion = dir,
        fecha_registro = fechaReg,
        discr = tipo,
        apellido_cliente = apell
    WHERE cliente_f_id = idCli;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BORRAR_ORDEN` (IN `idBorrar` INT)   DELETE FROM orden WHERE id_orden=idBorrar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BUSCAR_CLIENTE` (IN `idB` INT)   SELECT * FROM cliente WHERE cliente_f_id=idB$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BUSCAR_ORDEN` (IN `idOrd` INT)   SELECT * FROM orden WHERE id_orden=idOrd$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CALCULAR_TOTAL_ORDEN` (IN `id_orden` INT)   BEGIN
    SELECT 
        SUM(total) AS total_final
    FROM (
        SELECT 
            (tarjeta.costo_tarjeta * detalle_ord.cantidad) AS total
        FROM 
            detalle_ord
        JOIN 
            tarjeta ON detalle_ord.cod_tarjeta = tarjeta.cod_tarjeta
        WHERE 
            detalle_ord.id_orden = id_orden
    ) AS subquery;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ENVIAR` (IN `idOr` INT)   UPDATE orden SET activa=false
WHERE id_orden=idOr$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ENVIOS` ()   SELECT orden.id_orden, orden.fecha, cliente.nombre, cliente.apellido_cliente
FROM orden
JOIN cliente ON orden.cliente_f_cliente_f_id = cliente.cliente_f_id
WHERE orden.activa = false$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_CLIENTE` (IN `p_nombre` VARCHAR(100), IN `p_apellido_cliente` VARCHAR(100), IN `p_direccion` VARCHAR(255), IN `p_fecha_registro` DATE, IN `p_discr` VARCHAR(30))   BEGIN
    INSERT INTO cliente (nombre, apellido_cliente, direccion, fecha_registro, discr)
    VALUES (p_nombre, p_apellido_cliente, p_direccion, p_fecha_registro, p_discr);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_MAYORISTA` (IN `p_cliente_id` INT, IN `p_telefono_contacto` VARCHAR(20), IN `p_descuento` DECIMAL(5,2))   BEGIN
    INSERT INTO mayoristas (cliente_id, telefono_contacto, descuento)
    VALUES (p_cliente_id, p_telefono_contacto, p_descuento);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_MINORISTA` (IN `p_cliente_id` INT, IN `p_telefono_contacto` VARCHAR(20))   INSERT INTO minorista (cliente_id, telefono_contacto)
    VALUES (p_cliente_id, p_telefono_contacto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_ORDDETALLE` (IN `p_id_orden` INT, IN `p_cod_tarjeta` VARCHAR(50), IN `p_cantidad` INT)   BEGIN
    -- Inserta el nuevo registro
    INSERT INTO detalle_ord (id_orden, cod_tarjeta, cantidad)
    VALUES (p_id_orden, p_cod_tarjeta, p_cantidad)
    ON DUPLICATE KEY UPDATE cantidad = VALUES(cantidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_ORDEN` (IN `p_fecha` DATE, IN `p_cliente_f_id` INT)   BEGIN
    INSERT INTO orden (fecha, activa, cliente_f_cliente_f_id ) 
    VALUES (p_fecha, TRUE, p_cliente_f_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTAR_TARJETAS` (IN `codt` INT, IN `exp` DATE, IN `valor` INT, IN `activacion` DATE, IN `empresa` VARCHAR(30))   INSERT INTO tarjeta VALUES(codt, exp, valor, activacion,empresa)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ORDENES_CANCELADA` (IN `idCancelada` INT)   UPDATE orden SET activa=true
WHERE id_orden=idCancelada$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_CLIENTE` ()   SELECT * from cliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_CLIENTE_POR_ID` (IN `idO` INT)   SELECT orden.id_orden, 
cliente.nombre, 
cliente.apellido_cliente,
cliente.discr,
cliente.direccion
FROM orden JOIN cliente ON orden.cliente_f_cliente_f_id = cliente.cliente_f_id
WHERE orden.id_orden=idO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_DETALLE` (IN `idO` INT)   SELECT 
    detalle_ord.id_orden, 
    tarjeta.empresa_tarjeta,
    tarjeta.valor_tarjeta, 
    tarjeta.costo_tarjeta,
    detalle_ord.cantidad,
    (tarjeta.costo_tarjeta * detalle_ord.cantidad) AS total
FROM 
    detalle_ord
JOIN 
    tarjeta ON detalle_ord.cod_tarjeta = tarjeta.cod_tarjeta
WHERE 
    detalle_ord.id_orden = idO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_MAYORISTA` ()   BEGIN
    SELECT c.cliente_f_id AS ID, 
           m.id_mayorista AS id_mayorista, 
           m.telefono_contacto AS Telefono, 
           m.descuento AS Descuento, 
           c.nombre AS Nombre, 
           c.apellido_cliente AS Apellido, 
           c.direccion AS Direccion, 
           c.fecha_registro AS Fecha_de_Registro, 
           c.discr AS Tipo
    FROM cliente c
    JOIN mayoristas m ON c.cliente_f_id = m.cliente_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_MINORISTA` ()   SELECT  
           m.id_minorista, 
           m.cliente_id,
           m.telefono_contacto, 
           c.nombre, 
           c.apellido_cliente, 
           c.direccion, 
           c.discr 
    FROM cliente c
    JOIN minorista m ON c.cliente_f_id = m.cliente_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_ORDEN` ()   SELECT orden.id_orden,orden.fecha,orden.cliente_f_cliente_f_id, cliente.nombre,cliente.apellido_cliente
FROM orden
JOIN cliente ON orden.cliente_f_cliente_f_id = cliente.cliente_f_id
WHERE orden.activa=true$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_TARJETA` ()   SELECT * FROM tarjeta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_VISTA_ORDEN` ()   SELECT * FROM vista_orden$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VER_VISTA_ORDEN_REG` ()   SELECT * FROM vista_orden_registro$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_orden`
--

CREATE TABLE `auditoria_orden` (
  `id_auditoria` int(11) NOT NULL,
  `accion` varchar(50) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria_orden`
--

INSERT INTO `auditoria_orden` (`id_auditoria`, `accion`, `fecha`) VALUES
(1, 'se ha comprado n tarjetas en la fecha x', '2024-05-20 08:46:35'),
(31, 'se ha comprado 10 tarjetas en la fecha 2024-05-24', '2024-05-24 06:14:03'),
(97, 'Se ha insertado un nueva orden: 838En la fecha: 20', '2024-05-27 14:17:23'),
(98, 'Se ha insertado un nueva orden: 839En la fecha: 20', '2024-05-27 14:22:46'),
(99, 'Se ha insertado un nueva orden:  840En la fecha:  ', '2024-05-27 14:24:46'),
(100, 'Se ha insertado un nueva orden:  841En la fecha:  ', '2024-05-27 14:55:43'),
(101, 'Se ha insertado un nueva orden:  842En la fecha:  ', '2024-06-07 23:18:09'),
(102, 'Se ha insertado un nueva orden:  843En la fecha:  ', '2024-06-07 23:18:33'),
(103, 'Se ha insertado un nueva orden:  844En la fecha:  ', '2024-06-12 06:44:28'),
(104, 'Se ha insertado un nueva orden:  0En la fecha:  20', '2024-06-17 08:00:13'),
(105, 'Se ha insertado un nueva orden:  0En la fecha:  20', '2024-06-17 08:00:38'),
(106, 'Se ha insertado un nueva orden:  845En la fecha:  ', '2024-06-17 08:08:06'),
(107, 'Se ha insertado un nueva orden:  846En la fecha:  ', '2024-06-17 08:08:20'),
(108, 'Se ha insertado un nueva orden:  847En la fecha:  ', '2024-06-17 08:08:26'),
(109, 'Se ha insertado un nueva orden:  848En la fecha:  ', '2024-06-17 08:19:18'),
(110, 'Se ha insertado un nueva orden:  849En la fecha:  ', '2024-06-17 08:19:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `nombre` varchar(30) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `fecha_registro` date NOT NULL,
  `discr` varchar(30) DEFAULT NULL,
  `apellido_cliente` varchar(30) NOT NULL,
  `cliente_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`nombre`, `direccion`, `fecha_registro`, `discr`, `apellido_cliente`, `cliente_f_id`) VALUES
('Jose', 'Achumani', '2019-01-20', 'minorista', 'Gutierrez', 0),
('Fernando', 'Flores', '2016-06-01', '2024-05-17', 'Ballivian', 30),
('Maria', 'Calle La costa', '2024-05-18', 'mayorista', 'Conde', 32),
('Juan', 'San Francisco', '2024-03-20', 'minorista', 'Perez', 33),
('Jose', 'Plaza Murillo', '2024-06-19', 'minorista', 'Mamani', 34),
('Pablito', 'Obrajes', '2022-08-09', 'minorista', 'Ramos', 36),
('Scarlet', 'San Pedro', '0000-00-00', 'mayorista', 'Overhile', 38),
('Hans', 'Villa Copacabana', '2024-05-31', 'mayorista', 'Fernandez', 39),
('Maria', 'Av. Siempre Viva 123', '2024-06-01', 'minorista', 'Gomez', 40),
('Carlos', 'Calle Falsa 456', '2024-06-02', 'mayorista', 'Perez', 41),
('Ana', 'Calle Real 789', '2024-06-03', 'mayorista', 'Lopez', 42),
('Luis', 'Callle Murillo ', '2015-06-23', 'minorista', 'Rodriguez', 43),
('Elena', 'Plaza Mayor 222', '2024-06-05', 'minorista', 'Sanchez', 44),
('Jorge', 'mayorista', '2024-06-06', 'la luna', 'Ramirez', 45),
('Laura', 'minorista', '2024-06-07', '', 'Torrez', 46),
('Pedro', 'Calle Estrella 555', '2024-06-08', 'mayorista', 'Hernandez', 47),
('Laura', 'Av. Central 666', '2024-06-09', '', 'Diaz', 48),
('Roberto', 'Calle Norte 777', '2024-06-10', 'mayorista', 'Morales', 49),
('Silvia', 'mayorista', '2024-05-27', 'UNIVALLE', 'Choque', 51),
('Rosaliinda', 'Calacoto', '2020-08-20', 'minorista', 'Gutierrez', 88),
('Ramiro', 'La gruta', '2015-05-06', 'minorista', 'Espejo', 89),
('Shunny', 'calle Dorada', '2024-05-28', 'minorista', 'Kidou', 90),
('Victor', 'calle Real #233', '2024-05-28', 'mayorista', 'Blaze', 91);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cliente_ranking`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cliente_ranking` (
`cliente_f_cliente_f_id` int(11)
,`total_ordenes` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ord`
--

CREATE TABLE `detalle_ord` (
  `id_orden` int(11) NOT NULL,
  `cod_tarjeta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_ord`
--

INSERT INTO `detalle_ord` (`id_orden`, `cod_tarjeta`, `cantidad`) VALUES
(780, 1001, 20),
(780, 1002, 34),
(780, 1012, 2),
(781, 1005, 4),
(781, 1013, 8),
(797, 1006, 1),
(835, 1008, 13),
(836, 1006, 15),
(836, 1008, 5),
(837, 1001, 2),
(837, 1002, 2),
(837, 1003, 2),
(838, 1001, 5),
(838, 1003, 2),
(841, 1005, 5),
(841, 1008, 5),
(841, 1013, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_p`
--

CREATE TABLE `detalle_p` (
  `empresa_prov` varchar(40) NOT NULL,
  `cantidad_tarjetas` int(11) NOT NULL,
  `corte_tarjeta` int(11) NOT NULL,
  `porcentaje_descuento` int(11) NOT NULL,
  `costo_pedido` int(11) NOT NULL,
  `pedido_f_num_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
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
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `usuario` varchar(30) NOT NULL,
  `contrasena` varchar(30) NOT NULL,
  `login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mayoristas`
--

CREATE TABLE `mayoristas` (
  `id_mayorista` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `telefono_contacto` varchar(20) DEFAULT NULL,
  `descuento` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mayoristas`
--

INSERT INTO `mayoristas` (`id_mayorista`, `cliente_id`, `telefono_contacto`, `descuento`) VALUES
(5, 32, '7576756', 0.50),
(7, 33, '7576756', 0.70);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `minorista`
--

CREATE TABLE `minorista` (
  `id_minorista` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `telefono_contacto` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `minorista`
--

INSERT INTO `minorista` (`id_minorista`, `cliente_id`, `telefono_contacto`) VALUES
(101, 30, '7576756'),
(104, 34, '780989'),
(106, 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE `orden` (
  `id_orden` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `cliente_f_cliente_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`id_orden`, `fecha`, `activa`, `cliente_f_cliente_f_id`) VALUES
(780, '2024-05-20', 0, 32),
(781, '2024-05-24', 1, 30),
(797, '2024-05-08', 0, 39),
(799, '2024-05-22', 0, 44),
(801, '2024-05-26', 0, 46),
(834, '2024-05-21', 1, 36),
(835, '2024-05-27', 0, 47),
(836, '2024-05-27', 0, 43),
(837, '2024-05-27', 0, 42),
(838, '2024-05-27', 0, 45),
(840, '2024-05-27', 0, 48),
(841, '2024-05-27', 0, 51),
(842, '0000-00-00', 1, 0),
(845, '2019-02-21', 1, 0),
(846, '2024-06-17', 1, 39),
(848, '2024-06-17', 1, 39),
(849, '2024-06-17', 1, 39);

--
-- Disparadores `orden`
--
DELIMITER $$
CREATE TRIGGER `auditoria_orden` AFTER INSERT ON `orden` FOR EACH ROW INSERT INTO auditoria_orden(accion) VALUES(concat('Se ha insertado un nueva orden: ',' ', new.id_orden,'En la fecha: ',' ',new.fecha))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pd_fk`
--

CREATE TABLE `pd_fk` (
  `pedido_f_num_pedido` int(11) NOT NULL,
  `proveedor_f_id_proovedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `num_pedido` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `propietario_f_id_propietario` int(11) NOT NULL,
  `cant_tarjetas` int(11) NOT NULL,
  `cost_tarjeta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propietario`
--

CREATE TABLE `propietario` (
  `persona_f_ci_persona` int(11) NOT NULL,
  `id_propietario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proovedor` int(11) NOT NULL,
  `nombre_empresa` varchar(30) DEFAULT NULL,
  `correo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjeta`
--

CREATE TABLE `tarjeta` (
  `cod_tarjeta` int(11) NOT NULL,
  `valor_tarjeta` int(11) NOT NULL,
  `empresa_tarjeta` varchar(30) NOT NULL,
  `costo_tarjeta` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarjeta`
--

INSERT INTO `tarjeta` (`cod_tarjeta`, `valor_tarjeta`, `empresa_tarjeta`, `costo_tarjeta`) VALUES
(1001, 10, 'ENTEL', 9.30),
(1002, 15, 'ENTEL', 14.00),
(1003, 20, 'ENTEL', 19.40),
(1004, 30, 'ENTEL', 27.40),
(1005, 50, 'ENTEL', 46.00),
(1006, 100, 'ENTEL', 92.51),
(1007, 10, 'VIVA', 9.30),
(1008, 20, 'VIVA', 18.00),
(1009, 30, 'VIVA', 27.60),
(1010, 50, 'VIVA', 46.00),
(1012, 80, 'VIVA', 73.50),
(1013, 10, 'TIGO', 9.40),
(1014, 20, 'TIGO', 19.00),
(1015, 30, 'TIGO', 28.50),
(1016, 50, 'TIGO', 47.30),
(1017, 100, 'TIGO', 94.40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `total_general`
--

CREATE TABLE `total_general` (
  `id_orden` int(11) NOT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_orden`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_orden` (
`ORDEN_ID` int(11)
,`FEHCA` date
,`CLIENTE_ID` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_orden_registro`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_orden_registro` (
`FECHA` date
,`ConteoRegistros` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_tipo_cliente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_tipo_cliente` (
`discr` varchar(30)
,`ConteoClientes` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `cliente_ranking`
--
DROP TABLE IF EXISTS `cliente_ranking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cliente_ranking`  AS SELECT `orden`.`cliente_f_cliente_f_id` AS `cliente_f_cliente_f_id`, count(`orden`.`id_orden`) AS `total_ordenes` FROM `orden` GROUP BY `orden`.`cliente_f_cliente_f_id` ORDER BY count(`orden`.`id_orden`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_orden`
--
DROP TABLE IF EXISTS `vista_orden`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_orden`  AS SELECT `orden`.`id_orden` AS `ORDEN_ID`, `orden`.`fecha` AS `FEHCA`, `orden`.`cliente_f_cliente_f_id` AS `CLIENTE_ID` FROM `orden` WHERE `orden`.`fecha` > '2024-05-20' ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_orden_registro`
--
DROP TABLE IF EXISTS `vista_orden_registro`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_orden_registro`  AS SELECT `orden`.`fecha` AS `FECHA`, count(0) AS `ConteoRegistros` FROM `orden` GROUP BY `orden`.`fecha` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_tipo_cliente`
--
DROP TABLE IF EXISTS `vista_tipo_cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_tipo_cliente`  AS SELECT `cliente`.`discr` AS `discr`, count(0) AS `ConteoClientes` FROM `cliente` GROUP BY `cliente`.`discr` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria_orden`
--
ALTER TABLE `auditoria_orden`
  ADD PRIMARY KEY (`id_auditoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_f_id`),
  ADD KEY `INDEX_NOMBRE` (`nombre`);

--
-- Indices de la tabla `detalle_ord`
--
ALTER TABLE `detalle_ord`
  ADD PRIMARY KEY (`id_orden`,`cod_tarjeta`),
  ADD KEY `cod_tarjeta` (`cod_tarjeta`);

--
-- Indices de la tabla `detalle_p`
--
ALTER TABLE `detalle_p`
  ADD PRIMARY KEY (`pedido_f_num_pedido`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`persona_f_ci_persona`),
  ADD UNIQUE KEY `id_empleado` (`id_empleado`),
  ADD KEY `empleado_f_orden_f_fk` (`orden_f_id_orden`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indices de la tabla `mayoristas`
--
ALTER TABLE `mayoristas`
  ADD PRIMARY KEY (`id_mayorista`),
  ADD KEY `fk_cliente_mayorista` (`cliente_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `minorista`
--
ALTER TABLE `minorista`
  ADD PRIMARY KEY (`id_minorista`),
  ADD KEY `fk_cliente` (`cliente_id`);

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`id_orden`),
  ADD KEY `INDEX_ORDENES` (`id_orden`,`cliente_f_cliente_f_id`) USING BTREE;

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `pd_fk`
--
ALTER TABLE `pd_fk`
  ADD PRIMARY KEY (`pedido_f_num_pedido`,`proveedor_f_id_proovedor`),
  ADD KEY `pd_f_fk_proveedor_f_fk` (`proveedor_f_id_proovedor`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`num_pedido`),
  ADD KEY `pedido_f_propietario_f_fk` (`propietario_f_id_propietario`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ci_persona`),
  ADD UNIQUE KEY `persona_idx` (`login_login_id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `propietario`
--
ALTER TABLE `propietario`
  ADD PRIMARY KEY (`persona_f_ci_persona`),
  ADD UNIQUE KEY `id_propietario` (`id_propietario`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proovedor`);

--
-- Indices de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD PRIMARY KEY (`cod_tarjeta`),
  ADD KEY `INDEX_TARJETAS` (`valor_tarjeta`) USING BTREE;

--
-- Indices de la tabla `total_general`
--
ALTER TABLE `total_general`
  ADD PRIMARY KEY (`id_orden`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria_orden`
--
ALTER TABLE `auditoria_orden`
  MODIFY `id_auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mayoristas`
--
ALTER TABLE `mayoristas`
  MODIFY `id_mayorista` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `minorista`
--
ALTER TABLE `minorista`
  MODIFY `id_minorista` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT de la tabla `orden`
--
ALTER TABLE `orden`
  MODIFY `id_orden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=850;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  MODIFY `cod_tarjeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1018;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ord`
--
ALTER TABLE `detalle_ord`
  ADD CONSTRAINT `detalle_ord_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `orden` (`id_orden`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_ord_ibfk_2` FOREIGN KEY (`cod_tarjeta`) REFERENCES `tarjeta` (`cod_tarjeta`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_p`
--
ALTER TABLE `detalle_p`
  ADD CONSTRAINT `detallep_f_pedido_f_fk` FOREIGN KEY (`pedido_f_num_pedido`) REFERENCES `pedido` (`num_pedido`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_f_orden_f_fk` FOREIGN KEY (`orden_f_id_orden`) REFERENCES `orden` (`id_orden`),
  ADD CONSTRAINT `empleado_f_persona` FOREIGN KEY (`persona_f_ci_persona`) REFERENCES `persona` (`ci_persona`);

--
-- Filtros para la tabla `mayoristas`
--
ALTER TABLE `mayoristas`
  ADD CONSTRAINT `fk_cliente_mayorista` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_f_id`);

--
-- Filtros para la tabla `minorista`
--
ALTER TABLE `minorista`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_f_id`);

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_f_cliente_f_fk` FOREIGN KEY (`cliente_f_cliente_f_id`) REFERENCES `cliente` (`cliente_f_id`);

--
-- Filtros para la tabla `pd_fk`
--
ALTER TABLE `pd_fk`
  ADD CONSTRAINT `pd_f_fk_pedido_f_fk` FOREIGN KEY (`pedido_f_num_pedido`) REFERENCES `pedido` (`num_pedido`),
  ADD CONSTRAINT `pd_f_fk_proveedor_f_fk` FOREIGN KEY (`proveedor_f_id_proovedor`) REFERENCES `proveedor` (`id_proovedor`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_f_propietario_f_fk` FOREIGN KEY (`propietario_f_id_propietario`) REFERENCES `propietario` (`id_propietario`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_f_login_fk` FOREIGN KEY (`login_login_id`) REFERENCES `login` (`login_id`);

--
-- Filtros para la tabla `propietario`
--
ALTER TABLE `propietario`
  ADD CONSTRAINT `propietario_f_persona` FOREIGN KEY (`persona_f_ci_persona`) REFERENCES `persona` (`ci_persona`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
