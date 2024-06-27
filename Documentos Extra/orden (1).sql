-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 09:43:21
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
(842, '0000-00-00', 1, 0);

--
-- Disparadores `orden`
--
DELIMITER $$
CREATE TRIGGER `auditoria_orden` AFTER INSERT ON `orden` FOR EACH ROW INSERT INTO auditoria_orden(accion) VALUES(concat('Se ha insertado un nueva orden: ',' ', new.id_orden,'En la fecha: ',' ',new.fecha))
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`id_orden`),
  ADD KEY `INDEX_ORDENES` (`id_orden`,`cliente_f_cliente_f_id`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `orden`
--
ALTER TABLE `orden`
  MODIFY `id_orden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=845;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_f_cliente_f_fk` FOREIGN KEY (`cliente_f_cliente_f_id`) REFERENCES `cliente` (`cliente_f_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
