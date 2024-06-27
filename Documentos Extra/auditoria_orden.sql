-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 10:45:55
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
-- Base de datos: `nueva_prueba_cli`
--

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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria_orden`
--
ALTER TABLE `auditoria_orden`
  ADD PRIMARY KEY (`id_auditoria`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria_orden`
--
ALTER TABLE `auditoria_orden`
  MODIFY `id_auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
