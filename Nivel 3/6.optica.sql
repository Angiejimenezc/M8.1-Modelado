-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-06-2021 a las 08:44:43
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `optica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

CREATE TABLE `customer` (
  `email` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `customer_phone` int(11) DEFAULT NULL,
  `reg_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `customer`
--

INSERT INTO `customer` (`email`, `name`, `address`, `customer_phone`, `reg_Date`) VALUES
('antonia@gmail.com', 'Antonia SanJuan', 'Av. Los Héroes 58 1-2', 935666666, '2021-01-01'),
('ejemplo@gmail.com', 'Angelica Jiménez', 'Calle cualquiera 21', 996888882, '2020-10-05'),
('email@gmail.es', 'Andrea Blanco', 'Carrer Horta 161', 666666666, '2018-05-01'),
('rr@prontomail.com', 'Roco Bustos', 'Calle móvil sin datos', 689555745, '2020-10-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `glass`
--

CREATE TABLE `glass` (
  `id_glass` int(11) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `grad_left` float NOT NULL,
  `grad_right` float NOT NULL,
  `frame` enum('metálica','flotante','madera') NOT NULL,
  `color_left` varchar(45) NOT NULL,
  `color_right` varchar(45) NOT NULL,
  `price` float NOT NULL,
  `Supplier_NIF` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `glass`
--

INSERT INTO `glass` (`id_glass`, `brand`, `grad_left`, `grad_right`, `frame`, `color_left`, `color_right`, `price`, `Supplier_NIF`) VALUES
(50001, 'CK', 0.5, 0.5, 'flotante', 'negro', 'negro', 50, '48569998D'),
(50002, 'Nike', 0.1, 0.1, 'metálica', 'verde', 'verde', 39.99, 'B85985487'),
(50003, 'Munich', 0.7, 0.7, 'madera', 'marrón', 'marrón', 45.1, 'B80000087');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoice`
--

CREATE TABLE `invoice` (
  `id_invoice` int(11) NOT NULL,
  `employee` varchar(45) NOT NULL,
  `email_customer` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `invoice`
--

INSERT INTO `invoice` (`id_invoice`, `employee`, `email_customer`) VALUES
(11, 'Angie Jiménez', 'email@gmail.es'),
(12, 'Andrea Blanco', 'ejemplo@gmail.com'),
(13, 'Angie Jiménez', 'email@gmail.es');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoice_has_glass`
--

CREATE TABLE `invoice_has_glass` (
  `invoice_id_invoice` int(11) NOT NULL,
  `glass_id_glass` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `invoice_has_glass`
--

INSERT INTO `invoice_has_glass` (`invoice_id_invoice`, `glass_id_glass`) VALUES
(11, 50001),
(12, 50002);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recommendation`
--

CREATE TABLE `recommendation` (
  `guess` varchar(45) NOT NULL,
  `customer_email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `recommendation`
--

INSERT INTO `recommendation` (`guess`, `customer_email`) VALUES
('rr@prontomail.com', 'antonia@gmail.com'),
('antonia@gmail.com', 'ejemplo@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplier`
--

CREATE TABLE `supplier` (
  `NIF` varchar(9) NOT NULL,
  `name` varchar(45) NOT NULL,
  `phone` int(11) NOT NULL,
  `fax` int(11) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `door` varchar(2) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `supplier`
--

INSERT INTO `supplier` (`NIF`, `name`, `phone`, `fax`, `street`, `num`, `floor`, `door`, `city`, `code`) VALUES
('48569998D', 'Andrea Limitada', 936565640, 936655487, 'Calle Moño', 15, 1, '1', 'Sabadell', 8364),
('B80000087', 'Gafitolandia', 965878547, 963548728, 'Calle Sin Sal', 25, 5, 'A', 'Barcelona', 8003),
('B85985487', 'Gafitas S.L', 96588874, 96588875, 'Calle Orégano', 55, 2, '2', 'Barcelona', 8225);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `glass`
--
ALTER TABLE `glass`
  ADD PRIMARY KEY (`id_glass`),
  ADD KEY `fk_Glass_Supplier1` (`Supplier_NIF`);

--
-- Indices de la tabla `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id_invoice`),
  ADD KEY `fk_Ticket_Customer1` (`email_customer`);

--
-- Indices de la tabla `invoice_has_glass`
--
ALTER TABLE `invoice_has_glass`
  ADD PRIMARY KEY (`invoice_id_invoice`,`glass_id_glass`),
  ADD KEY `fk_invoice_has_glass_glass1_idx` (`glass_id_glass`),
  ADD KEY `fk_invoice_has_glass_invoice1_idx` (`invoice_id_invoice`);

--
-- Indices de la tabla `recommendation`
--
ALTER TABLE `recommendation`
  ADD PRIMARY KEY (`guess`),
  ADD KEY `fk_Recommendation_Customer2` (`customer_email`);

--
-- Indices de la tabla `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`NIF`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `glass`
--
ALTER TABLE `glass`
  ADD CONSTRAINT `fk_Glass_Supplier1` FOREIGN KEY (`Supplier_NIF`) REFERENCES `supplier` (`NIF`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `fk_Ticket_Customer1` FOREIGN KEY (`email_customer`) REFERENCES `customer` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `invoice_has_glass`
--
ALTER TABLE `invoice_has_glass`
  ADD CONSTRAINT `fk_invoice_has_glass_glass1` FOREIGN KEY (`glass_id_glass`) REFERENCES `glass` (`id_glass`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_invoice_has_glass_invoice1` FOREIGN KEY (`invoice_id_invoice`) REFERENCES `invoice` (`id_invoice`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `recommendation`
--
ALTER TABLE `recommendation`
  ADD CONSTRAINT `fk_Recommendation_Customer1` FOREIGN KEY (`guess`) REFERENCES `customer` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Recommendation_Customer2` FOREIGN KEY (`customer_email`) REFERENCES `customer` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
