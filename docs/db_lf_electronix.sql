-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 22, 2013 at 06:31 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_lf_electronix`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_action`
--

CREATE TABLE IF NOT EXISTS `tbl_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(255) NOT NULL,
  `action_description` varchar(255) DEFAULT NULL,
  `resources_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tbl_action` (`resources_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_advertisement`
--

CREATE TABLE IF NOT EXISTS `tbl_advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `heading` varchar(255) NOT NULL,
  `advertisement_image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_brand`
--

CREATE TABLE IF NOT EXISTS `tbl_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tbl_brand_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

CREATE TABLE IF NOT EXISTS `tbl_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_permissions`
--

CREATE TABLE IF NOT EXISTS `tbl_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permitted_action` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tbl_permission_resources` (`resource_id`),
  KEY `fk_tbl_permission_role` (`role_id`),
  KEY `fk_tbl_permissions_tbl_action` (`permitted_action`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE IF NOT EXISTS `tbl_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `stock` int(11) NOT NULL,
  `description` text NOT NULL,
  `product_image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tbl_products_category` (`category_id`),
  KEY `fk_tbl_products_brand` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_resources`
--

CREATE TABLE IF NOT EXISTS `tbl_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE IF NOT EXISTS `tbl_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tbl_roles`
--

INSERT INTO `tbl_roles` (`id`, `role_name`) VALUES
(1, 'Super Admin'),
(2, 'Admin'),
(3, 'User');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '3',
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tbl_user` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_action`
--
ALTER TABLE `tbl_action`
  ADD CONSTRAINT `fk_tbl_action` FOREIGN KEY (`resources_id`) REFERENCES `tbl_resources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_brand`
--
ALTER TABLE `tbl_brand`
  ADD CONSTRAINT `fk_tbl_brand_category` FOREIGN KEY (`category_id`) REFERENCES `tbl_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_permissions`
--
ALTER TABLE `tbl_permissions`
  ADD CONSTRAINT `fk_tbl_permissions_tbl_action` FOREIGN KEY (`permitted_action`) REFERENCES `tbl_action` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tbl_permission_resources` FOREIGN KEY (`resource_id`) REFERENCES `tbl_resources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tbl_permission_role` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD CONSTRAINT `fk_tbl_products_brand` FOREIGN KEY (`brand_id`) REFERENCES `tbl_brand` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tbl_products_category` FOREIGN KEY (`category_id`) REFERENCES `tbl_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `fk_tbl_user` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
