-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 15:07:20
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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalle_ord`
--
ALTER TABLE `detalle_ord`
  ADD PRIMARY KEY (`id_orden`,`cod_tarjeta`),
  ADD KEY `cod_tarjeta` (`cod_tarjeta`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ord`
--
ALTER TABLE `detalle_ord`
  ADD CONSTRAINT `detalle_ord_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `orden` (`id_orden`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_ord_ibfk_2` FOREIGN KEY (`cod_tarjeta`) REFERENCES `tarjeta` (`cod_tarjeta`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
