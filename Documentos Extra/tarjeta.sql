-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 09:49:14
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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD PRIMARY KEY (`cod_tarjeta`),
  ADD KEY `INDEX_TARJETAS` (`valor_tarjeta`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  MODIFY `cod_tarjeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1018;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
