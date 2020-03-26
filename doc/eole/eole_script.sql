-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 03 mai 2018 à 11:40
-- Version du serveur :  5.7.19
-- Version de PHP :  7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `eole`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `ID_CATEGORIE` int(11) NOT NULL,
  `LIBELLER` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID_CATEGORIE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`ID_CATEGORIE`, `LIBELLER`) VALUES
(1, 'Catégorie A'),
(2, 'Catégorie B'),
(3, 'Catégorie C'),
(4, 'Catégorie D');

-- --------------------------------------------------------

--
-- Structure de la table `classement`
--

DROP TABLE IF EXISTS `classement`;
CREATE TABLE IF NOT EXISTS `classement` (
  `ID_VOILIER` int(11) NOT NULL,
  `ID_REGATE` int(11) NOT NULL,
  `TEMPS_ARRIVER` time DEFAULT NULL,
  `TEMPS_COMPENSE` time DEFAULT NULL,
  KEY `FK_ID_VOILIER` (`ID_VOILIER`) USING BTREE,
  KEY `FK_ID_REGATE` (`ID_REGATE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `classement`
--

INSERT INTO `classement` (`ID_VOILIER`, `ID_REGATE`, `TEMPS_ARRIVER`, `TEMPS_COMPENSE`) VALUES
(78, 18, '00:03:26', '00:27:33'),
(79, 18, '00:04:29', '00:27:55'),
(80, 18, '00:03:46', '00:31:03'),
(81, 18, '00:04:42', '00:30:24'),
(82, 18, '00:04:23', '00:27:11'),
(83, 18, '00:04:56', '00:32:34'),
(89, 21, '00:32:21', '01:22:44'),
(90, 21, '00:42:55', '01:36:58'),
(91, 21, '00:35:19', '01:22:19'),
(92, 21, '00:37:42', '01:30:05'),
(93, 21, '00:32:42', '01:19:19'),
(94, 21, '00:37:33', '01:26:09'),
(95, 21, '00:37:54', '01:38:05'),
(96, 21, '00:38:23', '01:47:26'),
(97, 21, '00:33:45', '01:40:29'),
(98, 21, '00:00:00', '00:00:00'),
(99, 21, '00:44:23', '02:10:05'),
(100, 21, '00:36:03', '01:20:35'),
(101, 21, '00:47:08', '02:23:56'),
(104, 23, NULL, NULL),
(105, 23, NULL, NULL),
(106, 23, NULL, NULL),
(107, 23, NULL, NULL),
(108, 23, NULL, NULL),
(109, 23, NULL, NULL),
(110, 23, NULL, NULL),
(111, 23, NULL, NULL),
(112, 23, NULL, NULL),
(113, 23, NULL, NULL),
(114, 23, NULL, NULL),
(115, 23, NULL, NULL),
(116, 23, NULL, NULL),
(117, 23, NULL, NULL),
(118, 23, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `regate`
--

DROP TABLE IF EXISTS `regate`;
CREATE TABLE IF NOT EXISTS `regate` (
  `ID_REGATE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DISTANCE` double NOT NULL,
  `DATE_DEPART` date NOT NULL,
  `CLOTURE` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID_REGATE`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `regate`
--

INSERT INTO `regate` (`ID_REGATE`, `LIBELLE`, `DISTANCE`, `DATE_DEPART`, `CLOTURE`) VALUES
(18, 'Exemple', 2, '2018-03-29', 1),
(21, 'Kaido', 4.3, '2018-03-17', 1),
(23, 'Mano mai', 30, '2018-05-30', 0);

-- --------------------------------------------------------

--
-- Structure de la table `voilier`
--

DROP TABLE IF EXISTS `voilier`;
CREATE TABLE IF NOT EXISTS `voilier` (
  `ID_VOILIER` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORIE` int(11) NOT NULL,
  `NOM_VOILIER` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NOM_SKIPPEUR` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PRENOM_SKIPPEUR` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `RATING` int(11) NOT NULL,
  PRIMARY KEY (`ID_VOILIER`),
  KEY `FK_ID_CATEGORIE` (`CATEGORIE`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `voilier`
--

INSERT INTO `voilier` (`ID_VOILIER`, `CATEGORIE`, `NOM_VOILIER`, `NOM_SKIPPEUR`, `PRENOM_SKIPPEUR`, `RATING`) VALUES
(78, 1, 'Le Nautilus', 'Walter', 'Pierre', 47),
(79, 1, 'Le Chancellor', 'Drieux', 'Marc', 50),
(80, 2, 'Titanic', 'Smith', 'Edward', 36),
(81, 2, 'Le Hollandais volant', 'Fokke', 'Bernard', 41),
(82, 1, 'Rubiks', 'Durant', 'Camille', 53),
(83, 2, 'Le renard', 'Loch', 'Sophie', 35),
(84, 1, 'test', 'Marc', 'Durant', 45),
(85, 1, 'test2', 'Jean', 'Maurice', 56),
(86, 1, 'Voilier de test', 'Test', 'Test', 23),
(87, 1, 'Voilier', 'Toto', 'Walter', 34),
(88, 1, 'Voilier 2', 'Tata', 'Walter', 45),
(89, 1, 'voilier 1', 'Dupont', 'Jean', 50),
(90, 2, 'voilier 2', 'Durand', 'Camille', 43),
(91, 1, 'voilier 3', 'Walter', 'Quentin', 58),
(92, 2, 'voilier 4', 'Walter', 'Pierre', 46),
(93, 1, 'vilier 5', 'Gross', 'Bernard', 59),
(94, 1, 'voilier 6', 'Erny', 'Pierre', 54),
(95, 3, 'voilier 7', 'Dupont', 'Marc', 34),
(96, 3, 'voilier 8', 'Durand', 'Sophie', 25),
(97, 3, 'voilier 9', 'Laie', 'Marie', 27),
(98, 2, 'voilier 10', 'Kolb', 'François', 47),
(99, 4, 'voilier 11', 'Drieux', 'Hugo', 15),
(100, 1, 'voilier 12', 'Conrad', 'Laura', 65),
(101, 4, 'voilier 13', 'Schneder', 'Charle', 11),
(102, 2, 'Voilier 4', 'Lkjsdf', 'Dlksjdf', 45),
(103, 2, 'Voilier jh', 'Kljsqd', 'Ljsdf', 67),
(104, 1, 'Le Nautilus', 'Walter', 'Pierre', 47),
(105, 1, 'Le Chancellor', 'Direux', 'Marc', 50),
(106, 2, 'Titanic', 'Smith', 'Edward', 36),
(107, 2, 'Le Hollandais volant', 'Fokke', 'Bernard', 41),
(108, 1, 'Rubiks', 'Durant', 'Camille', 53),
(109, 2, 'Le Renard', 'Loch', 'Sophie', 35),
(110, 3, 'Stylos', 'Michel', 'Andrea', 25),
(111, 3, 'Jial', 'Kolb', 'Hugo', 23),
(112, 1, 'Neolis', 'Wiess', 'Lucie', 51),
(113, 1, 'La Mouche', 'Vox', 'Bruno', 59),
(114, 4, 'Overwash', 'Walter', 'Robin', 15),
(115, 4, 'Licorne', 'Huch', 'Angela', 17),
(116, 3, 'Rozana', 'Kolb', 'Davide', 28),
(117, 3, 'Sigma', 'Walter', 'Laure', 25),
(118, 3, 'LADY NONONE', 'Damien', 'Schneider', 21);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `classement`
--
ALTER TABLE `classement`
  ADD CONSTRAINT `classement_ibfk_1` FOREIGN KEY (`ID_REGATE`) REFERENCES `regate` (`ID_REGATE`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `classement_ibfk_2` FOREIGN KEY (`ID_VOILIER`) REFERENCES `voilier` (`ID_VOILIER`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `voilier`
--
ALTER TABLE `voilier`
  ADD CONSTRAINT `FK_ID_CATEGORIE` FOREIGN KEY (`CATEGORIE`) REFERENCES `categorie` (`ID_CATEGORIE`),
  ADD CONSTRAINT `voilier_ibfk_1` FOREIGN KEY (`CATEGORIE`) REFERENCES `categorie` (`ID_CATEGORIE`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
