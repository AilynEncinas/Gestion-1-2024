-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 15:02:08
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
('Fernando', 'Flores', '2016-06-01', 'mayorista', 'Ballivian', 30),
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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_f_id`),
  ADD KEY `INDEX_NOMBRE` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
