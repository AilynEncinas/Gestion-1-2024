-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 14:37:39
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_base_web`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_contra_cli_2` (IN `p_username` VARCHAR(255), IN `p_new_contraseña` VARCHAR(255))   BEGIN
    DECLARE v_exists INT;

    -- Comprobar si el usuario existe
    SELECT COUNT(*) INTO v_exists 
    FROM cliente 
    WHERE username = p_username;

    IF v_exists = 1 THEN
        -- Si el usuario existe, actualizar su contraseña
        UPDATE cliente 
        SET contrasena = p_new_contraseña 
        WHERE username = p_username;
    ELSE
        -- Si el usuario no existe, lanzar un error o manejarlo de otra forma
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El usuario no existe';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_cliente` (IN `ci` INT, IN `nom` VARCHAR(30), IN `ape` VARCHAR(30), IN `username` VARCHAR(30), IN `contra` VARCHAR(90), IN `direc` VARCHAR(30), IN `fecha_rec` DATE, IN `tipo_c` VARCHAR(30))   INSERT INTO cliente VALUES(ci,nom,ape,username,contra,direc,fecha_rec,tipo_c)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_persona` (IN `p_ci_persona` INT, IN `p_nombre` VARCHAR(30), IN `p_apellido` VARCHAR(40), IN `p_username` VARCHAR(30), IN `p_contrasena` VARCHAR(30), IN `p_fecha_nacimiento` DATE, IN `p_correo` VARCHAR(50), IN `p_numero_telefono` INT, IN `p_direccion` VARCHAR(40), IN `p_tipo_emp` ENUM('propietario','empleado'))   BEGIN
    INSERT INTO persona (ci_persona, nombre, apellido, ussername, contrasena, fecha_nacimiento, correo, numero_telefono, direccion, tipo_emp)
    VALUES (p_ci_persona, p_nombre, p_apellido, p_username, p_contrasena, p_fecha_nacimiento, p_correo, p_numero_telefono, p_direccion, p_tipo_emp);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_persona_y_empleado` (IN `p_ci_persona` INT, IN `p_nombre` VARCHAR(30), IN `p_apellido` VARCHAR(40), IN `p_username` VARCHAR(30), IN `p_contrasena` VARCHAR(30), IN `p_fecha_nacimiento` DATE, IN `p_correo` VARCHAR(50), IN `p_numero_telefono` INT, IN `p_direccion` VARCHAR(40), IN `p_tipo_emp` ENUM('propietario','empleado'), IN `p_id_empleado` INT, IN `p_salario` INT)   BEGIN
    -- Insertar datos en la tabla persona
    INSERT INTO persona (ci_persona, nombre, apellido, ussername, contrasena, fecha_nacimiento, correo, numero_telefono, direccion, tipo_emp)
    VALUES (p_ci_persona, p_nombre, p_apellido, p_username, p_contrasena, p_fecha_nacimiento, p_correo, p_numero_telefono, p_direccion, p_tipo_emp);
    
    -- Si el tipo_emp es 'empleado', insertar datos en la tabla empleado
    IF p_tipo_emp = 'empleado' THEN
        INSERT INTO empleado (persona_ci_empleado, id_empleado, salario)
        VALUES (p_ci_persona, p_id_empleado, p_salario);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_persona_y_propietario` (IN `p_ci_persona` INT, IN `p_nombre` VARCHAR(30), IN `p_apellido` VARCHAR(40), IN `p_username` VARCHAR(30), IN `p_contrasena` VARCHAR(30), IN `p_fecha_nacimiento` DATE, IN `p_correo` VARCHAR(50), IN `p_numero_telefono` INT, IN `p_direccion` VARCHAR(40), IN `p_tipo_emp` ENUM('propietario','empleado'), IN `p_id_propietario` INT)   BEGIN
    -- Insertar datos en la tabla persona
    INSERT INTO persona (ci_persona, nombre, apellido, ussername, contrasena, fecha_nacimiento, correo, numero_telefono, direccion, tipo_emp)
    VALUES (p_ci_persona, p_nombre, p_apellido, p_username, p_contrasena, p_fecha_nacimiento, p_correo, p_numero_telefono, p_direccion, p_tipo_emp);
    
    -- Si el tipo_emp es 'propietario', insertar datos en la tabla propietario
    IF p_tipo_emp = 'propietario' THEN
        INSERT INTO propietario (persona_ci_propietario, id_propietario)
        VALUES (p_ci_persona, p_id_propietario);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_tipo_cliente` ()   BEGIN
    DECLARE tipo_cli VARCHAR(255); -- Definir la variable para almacenar el resultado

    -- Consulta para obtener el tipo de cliente
    SELECT @tipo_cli AS tipo_cliente INTO tipo_cli;

    -- Devolver el resultado
    SELECT tipo_cli AS tipo_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_tipo_empleado` ()   BEGIN
    DECLARE tipo_emp VARCHAR(255); -- Definir la variable para almacenar el resultado

    -- Consulta para obtener el tipo de empleado
    SELECT @tipo_emp AS tipo_empleado INTO tipo_emp;

    -- Devolver el resultado
    SELECT tipo_emp AS tipo_empleado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reg_ingresos_clie` ()   BEGIN
	SELECT * FROM reg_ingresos_cli;
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verificar_credenciales` (IN `p_username` VARCHAR(255), IN `p_contrasena` VARCHAR(255), OUT `p_tipo_cli` ENUM('mayorista','minorista'))   BEGIN
    SELECT tipo_cli INTO p_tipo_cli
    FROM cliente
    WHERE username = p_username AND contrasena = p_contrasena;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verificar_credenciales2` (IN `p_username` VARCHAR(255), IN `p_contrasena` VARCHAR(255), OUT `p_tipo_emp` ENUM('propietario','empleado'))   BEGIN
    SELECT tipo_emp INTO p_tipo_emp
    FROM persona
    WHERE ussername = p_username AND contrasena = p_contrasena;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_reg_empleado` ()   BEGIN
	SELECT *
    FROM empleado_reg;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `ci_cli` int(11) NOT NULL,
  `nombre_cli` varchar(30) NOT NULL,
  `apellido_cli` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `direccion_cli` varchar(50) NOT NULL,
  `fecha_reg_cli` date NOT NULL,
  `tipo_cli` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`ci_cli`, `nombre_cli`, `apellido_cli`, `username`, `contrasena`, `direccion_cli`, `fecha_reg_cli`, `tipo_cli`) VALUES
(3847, 'Carlos Walter', 'Montaño Laura', 'carlos', '123456789', 'Illampu', '2024-05-20', 'minorista'),
(12345, 'Luis', 'Chino', 'luis', '123456789NuevaContra+', 'X', '2024-05-20', 'mayorista'),
(11111111, 'Preuba1', 'Preuba1', 'Preuba1', '160305Encinas*', 'Preuba1', '2024-05-23', 'mayorista'),
(12606949, 'Ailyn', 'Gutierrez', 'EncinasA', '123456789A+', 'Alto Obrajes, Sector A', '2024-06-16', 'mayorista'),
(16404909, 'Ailyn', 'Gutierrez', 'ailyn encinas', '160305Encinas', 'Alto Obrajes, Sector A', '2024-05-20', 'mayorista');

--
-- Disparadores `cliente`
--
DELIMITER $$
CREATE TRIGGER `after_cliente_insert` AFTER INSERT ON `cliente` FOR EACH ROW BEGIN
    INSERT INTO login (username, contrasena)
    VALUES (NEW.username, NEW.contrasena);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `log_clientes` BEFORE INSERT ON `cliente` FOR EACH ROW INSERT INTO reg_ingresos_cli (accion)
VALUES(concat('Se ingreso un nuevo cliente con la siguiente informacion: ',
	' CI: ',new.ci_cli,              
	' Nombre: ',new.nombre_cli,              
	' Apellido: ',new.apellido_cli,			  
        ' Direccion: ',new.direccion_cli,
        ' Usuario: ',new.username,
        ' Tipo de Cliente: ',new.tipo_cli))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `persona_ci_empleado` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `salario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`persona_ci_empleado`, `id_empleado`, `salario`) VALUES
(0, 46550, 0),
(12, 2, 50),
(4888608, 46551, 2500),
(4888609, 4, 2500),
(12606948, 46548, 2500),
(12606949, 46547, 11000000),
(15505842, 46549, 555),
(16030504, 3, 2500),
(123456789, 1, 50000),
(2147483647, 46546, 2500);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `empleado_reg`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `empleado_reg` (
`persona_ci_empleado` int(11)
,`id_empleado` int(11)
,`salario` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `username` varchar(30) NOT NULL,
  `contrasena` varchar(30) NOT NULL,
  `login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`username`, `contrasena`, `login_id`) VALUES
('usuarioEjemplo', 'contrasenaEjemplo', 1),
('prueba1', '123456789', 2),
('marioly', '123456789A+', 3),
('ailyn encinas', '160305Encinas', 4),
('carlos', '12', 5),
('luis', '123456789', 6),
('root_Encinas', '160305Encinas*', 7),
('root_Encinas', 'a', 8),
('root_Encinas', 'z', 9),
('root_Encinas', 'a', 10),
('root_Encinas', 'a', 11),
('a', 'a', 12),
('a', 'a', 13),
('a', 'a', 14),
('a', 'a', 15),
('a', 'a', 16),
('root_Encinas', '2', 17),
('root_Encinas', 'a', 18),
('root_Encinas', '160305Encinas*', 19),
('Preuba1', '160305Encinas*', 20),
('EncinasA', '123456789A+', 21);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `mayoristas_reg`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `mayoristas_reg` (
`nombre_cli` varchar(30)
,`apellido_cli` varchar(30)
,`fecha_reg_cli` date
,`tipo_cli` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `minoristas_reg`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `minoristas_reg` (
`ci_cli` int(11)
,`nombre_cli` varchar(30)
,`apellido_cli` varchar(30)
,`username` varchar(30)
,`contrasena` varchar(255)
,`direccion_cli` varchar(50)
,`fecha_reg_cli` date
,`tipo_cli` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `ci_persona` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `ussername` varchar(30) NOT NULL,
  `contrasena` varchar(30) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo` varchar(50) NOT NULL,
  `numero_telefono` int(11) NOT NULL,
  `direccion` varchar(40) NOT NULL,
  `tipo_emp` enum('propietario','empleado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`ci_persona`, `nombre`, `apellido`, `ussername`, `contrasena`, `fecha_nacimiento`, `correo`, `numero_telefono`, `direccion`, `tipo_emp`) VALUES
(0, '', '', '', '', '0000-00-00', '', 0, '', 'empleado'),
(123456, 'Jhillmar Hugo', 'Encinas Herrera', 'jhillmar', '123456789A+', '2005-03-16', 'jhillmar@gmail.com', 73079452, 'Alto Obrajes', 'propietario'),
(4888608, 'Ailyn', 'Gutierrez', '', '123456789A+', '2005-11-29', 'aylinzomber@gmail.com', 67138351, 'Alto Obrajes, Sector A', 'empleado'),
(4888609, 'Marcos', 'Heredia Larrea', 'Marcos Heredia', '123456789A+', '2014-03-06', 'carlos@gmail.com', 69751258, 'Illampu y Santa Cruz', 'empleado'),
(12606948, 'Ailyn', 'Gutierrez', '', '160305Encinas*', '2005-12-02', 'aylinzomber@gmail.com', 67138351, 'Alto Obrajes, Sector A', 'empleado'),
(12606949, 'Ailyn', 'Gutierrez', '', '160305Encinas.', '2005-03-16', 'aylinzomber@gmail.com', 67138351, 'Alto Obrajes, Sector A', 'empleado'),
(15505842, 'Ailyn', 'Gutierrez', '', '160305Encinas*', '2005-12-01', 'aylinzomber@gmail.com', 67138351, 'Alto Obrajes, Sector A', 'empleado'),
(2147483647, 'A', 'A', '', 'a', '2024-05-01', 'aylinzomber@gmail.com', 67138351, 'Alto Obrajes, Sector A', 'empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propietario`
--

CREATE TABLE `propietario` (
  `persona_ci_propietario` int(11) NOT NULL,
  `id_propietario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `propietario`
--

INSERT INTO `propietario` (`persona_ci_propietario`, `id_propietario`) VALUES
(123456, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reg_ingresos_cli`
--

CREATE TABLE `reg_ingresos_cli` (
  `id` int(5) NOT NULL,
  `accion` varchar(250) NOT NULL,
  `fecha_hora` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reg_ingresos_cli`
--

INSERT INTO `reg_ingresos_cli` (`id`, `accion`, `fecha_hora`) VALUES
(1, 'Se ingreso un nuevo cliente con la siguiente informacion: 454545AilynGutierrezAlto Obrajes, Sector Aroot_Encinas160305Encinas*2024-05-19mayorista', '2024-05-19 20:29:14'),
(2, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 4444 Nombre: Ailyn Apellido: Gutierrez Direccion: Alto Obrajes, Sector A Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-19 20:33:33'),
(4, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 0 Nombre:  Apellido:  Direccion:  Usuario: usuarioEjemplo Tipo de Cliente: ', '2024-05-20 00:58:38'),
(5, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 125478 Nombre: prueba1 Apellido: prueba1 Direccion: prueba1 Usuario: prueba1 Tipo de Cliente: minorista', '2024-05-20 01:02:27'),
(6, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 4888609 Nombre: Marioly Apellido: Tintaya Direccion: El Alto Usuario: marioly Tipo de Cliente: mayorista', '2024-05-20 05:34:19'),
(7, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 16404909 Nombre: Ailyn Apellido: Gutierrez Direccion: Alto Obrajes, Sector A Usuario: ailyn encinas Tipo de Cliente: mayorista', '2024-05-20 09:49:04'),
(8, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 3847 Nombre: Carlos Walter Apellido: Montaño Laura Direccion: Illampu Usuario: carlos Tipo de Cliente: minorista', '2024-05-20 09:50:40'),
(9, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 12345 Nombre: Luis Apellido: Chino Direccion: X Usuario: luis Tipo de Cliente: mayorista', '2024-05-20 10:33:51'),
(10, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 0 Nombre: s Apellido: d Direccion: f Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 18:15:03'),
(13, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 12313 Nombre: asdasd Apellido: asdasdsd Direccion: aaaaaa Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 18:19:57'),
(14, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 1475 Nombre: a Apellido: a Direccion: a Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 18:30:37'),
(15, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 1111 Nombre: a Apellido: a Direccion: a Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 18:50:41'),
(16, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 111111 Nombre: a Apellido: a Direccion: a Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 18:53:46'),
(17, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 2222222 Nombre: a Apellido: a Direccion: a Usuario: a Tipo de Cliente: mayorista', '2024-05-23 18:54:17'),
(18, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 33333 Nombre: a Apellido: a Direccion: a Usuario: a Tipo de Cliente: mayorista', '2024-05-23 18:55:49'),
(19, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 11111 Nombre: a Apellido: a Direccion: a Usuario: a Tipo de Cliente: mayorista', '2024-05-23 18:56:36'),
(20, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 4444444 Nombre: a Apellido: a Direccion: a Usuario: a Tipo de Cliente: mayorista', '2024-05-23 18:57:35'),
(21, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 1111111111 Nombre: q Apellido: q Direccion: q Usuario: a Tipo de Cliente: mayorista', '2024-05-23 19:27:17'),
(22, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 2147483647 Nombre: Ailyn Apellido: Gutierrez Direccion: Alto Obrajes, Sector A Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 19:28:31'),
(24, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 33333342 Nombre: Ailyn Apellido: Gutierrez Direccion: Alto Obrajes, Sector A Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 19:31:17'),
(26, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 12606949 Nombre: Ailyn Apellido: Gutierrez Direccion: Alto Obrajes, Sector A Usuario: root_Encinas Tipo de Cliente: mayorista', '2024-05-23 22:13:47'),
(27, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 11111111 Nombre: Preuba1 Apellido: Preuba1 Direccion: Preuba1 Usuario: Preuba1 Tipo de Cliente: mayorista', '2024-05-23 22:14:38'),
(29, 'Se ingreso un nuevo cliente con la siguiente informacion:  CI: 12606949 Nombre: Ailyn Apellido: Gutierrez Direccion: Alto Obrajes, Sector A Usuario: EncinasA Tipo de Cliente: mayorista', '2024-06-16 20:58:55');

-- --------------------------------------------------------

--
-- Estructura para la vista `empleado_reg`
--
DROP TABLE IF EXISTS `empleado_reg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `empleado_reg`  AS SELECT `empleado`.`persona_ci_empleado` AS `persona_ci_empleado`, `empleado`.`id_empleado` AS `id_empleado`, `empleado`.`salario` AS `salario` FROM `empleado` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `mayoristas_reg`
--
DROP TABLE IF EXISTS `mayoristas_reg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mayoristas_reg`  AS SELECT `cliente`.`nombre_cli` AS `nombre_cli`, `cliente`.`apellido_cli` AS `apellido_cli`, `cliente`.`fecha_reg_cli` AS `fecha_reg_cli`, `cliente`.`tipo_cli` AS `tipo_cli` FROM `cliente` WHERE `cliente`.`tipo_cli` = 'mayorista' ;

-- --------------------------------------------------------

--
-- Estructura para la vista `minoristas_reg`
--
DROP TABLE IF EXISTS `minoristas_reg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `minoristas_reg`  AS SELECT `cliente`.`ci_cli` AS `ci_cli`, `cliente`.`nombre_cli` AS `nombre_cli`, `cliente`.`apellido_cli` AS `apellido_cli`, `cliente`.`username` AS `username`, `cliente`.`contrasena` AS `contrasena`, `cliente`.`direccion_cli` AS `direccion_cli`, `cliente`.`fecha_reg_cli` AS `fecha_reg_cli`, `cliente`.`tipo_cli` AS `tipo_cli` FROM `cliente` WHERE `cliente`.`tipo_cli` = 'minorista' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`ci_cli`),
  ADD KEY `ci_indice` (`ci_cli`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`persona_ci_empleado`),
  ADD UNIQUE KEY `id_empleado` (`id_empleado`),
  ADD KEY `ci_emp_indice` (`persona_ci_empleado`) USING BTREE;

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `id_login_indice` (`login_id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ci_persona`);

--
-- Indices de la tabla `propietario`
--
ALTER TABLE `propietario`
  ADD PRIMARY KEY (`persona_ci_propietario`),
  ADD UNIQUE KEY `id_propietario` (`id_propietario`);

--
-- Indices de la tabla `reg_ingresos_cli`
--
ALTER TABLE `reg_ingresos_cli`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46552;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `reg_ingresos_cli`
--
ALTER TABLE `reg_ingresos_cli`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
