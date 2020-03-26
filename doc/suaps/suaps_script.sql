-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  Dim 20 mai 2018 à 18:40
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
-- Base de données :  `suaps`
--

-- --------------------------------------------------------

--
-- Structure de la table `droit`
--

DROP TABLE IF EXISTS `droit`;
CREATE TABLE IF NOT EXISTS `droit` (
  `ID_DROIT` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE_DROIT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_DROIT`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `droit`
--

INSERT INTO `droit` (`ID_DROIT`, `LIBELLE_DROIT`) VALUES
(1, 'Réserver un place'),
(2, 'Supprimer une réservation'),
(3, 'Edition de statistique'),
(4, 'Saisie des adhérants'),
(5, 'MAJ des membre'),
(6, 'Ajouter des tickets'),
(7, 'Acheter des tickets');

-- --------------------------------------------------------

--
-- Structure de la table `place`
--

DROP TABLE IF EXISTS `place`;
CREATE TABLE IF NOT EXISTS `place` (
  `ID_PLACE` int(11) NOT NULL,
  `LIBELLE_PLACE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_PLACE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `place`
--

INSERT INTO `place` (`ID_PLACE`, `LIBELLE_PLACE`) VALUES
(1, 'Place 1'),
(2, 'Place 2'),
(3, 'Place 3'),
(4, 'Place 4');

-- --------------------------------------------------------

--
-- Structure de la table `possede`
--

DROP TABLE IF EXISTS `possede`;
CREATE TABLE IF NOT EXISTS `possede` (
  `ID_ROLE` int(11) NOT NULL,
  `ID_DROIT` int(11) NOT NULL,
  PRIMARY KEY (`ID_ROLE`,`ID_DROIT`),
  KEY `POSSEDE2_FK` (`ID_ROLE`),
  KEY `POSSEDE_FK` (`ID_DROIT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `possede`
--

INSERT INTO `possede` (`ID_ROLE`, `ID_DROIT`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(2, 1),
(2, 2),
(2, 7);

-- --------------------------------------------------------

--
-- Structure de la table `reserver`
--

DROP TABLE IF EXISTS `reserver`;
CREATE TABLE IF NOT EXISTS `reserver` (
  `ID_UTIL` int(11) NOT NULL,
  `ID_PLACE` int(11) NOT NULL,
  `DATE_RESERVATION` date NOT NULL,
  `ID_INVITE` int(11) DEFAULT NULL COMMENT 'id de la personne qui à invité l''utilisateur',
  `ETAT` tinyint(1) DEFAULT NULL COMMENT 'Ticket décompté ? (o/n)',
  PRIMARY KEY (`ID_UTIL`,`ID_PLACE`,`DATE_RESERVATION`),
  KEY `RESERVER2_FK` (`ID_UTIL`),
  KEY `RESERVER_FK` (`ID_PLACE`),
  KEY `DATE_RESERVATION` (`DATE_RESERVATION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `reserver`
--

INSERT INTO `reserver` (`ID_UTIL`, `ID_PLACE`, `DATE_RESERVATION`, `ID_INVITE`, `ETAT`) VALUES
(5, 1, '2018-05-14', NULL, NULL),
(5, 1, '2018-05-09', NULL, NULL),
(6, 2, '2018-05-13', 3, NULL),
(3, 2, '2018-05-12', NULL, NULL),
(3, 1, '2018-05-13', NULL, NULL),
(1, 1, '2018-05-12', NULL, NULL),
(4, 3, '2018-05-04', 1, NULL),
(2, 2, '2018-05-04', 1, NULL),
(1, 1, '2018-05-04', NULL, NULL),
(6, 1, '2018-05-19', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `ID_ROLE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE_ROLE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_ROLE`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`ID_ROLE`, `LIBELLE_ROLE`) VALUES
(1, 'Administrateur'),
(2, 'Membre'),
(3, 'Invité'),
(4, 'Adhérant');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `ID_UTIL` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ROLE` int(11) NOT NULL,
  `LASTNAME_UTIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIRSTNAME_UTIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PASSWORD_UTIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NB_TICKETS_SEMAINE` int(11) DEFAULT NULL,
  `NB_TICKETS_WEEKEND` int(11) DEFAULT NULL,
  `NB_TICKETS_TOTAL_UTIL` int(11) NOT NULL,
  `NB_ANNULATION_TOTAL` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_UTIL`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  KEY `OCCUPE_FK` (`ID_ROLE`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`ID_UTIL`, `ID_ROLE`, `LASTNAME_UTIL`, `FIRSTNAME_UTIL`, `PASSWORD_UTIL`, `EMAIL`, `NB_TICKETS_SEMAINE`, `NB_TICKETS_WEEKEND`, `NB_TICKETS_TOTAL_UTIL`, `NB_ANNULATION_TOTAL`) VALUES
(1, 1, 'MOCHEL', 'Anthony', 'admin', 'admin@exemple.com', 2, 4, 2, 1),
(2, 2, 'DURANT', 'Marc', '1234', 'durantmarc@gmail.com', 5, 5, 1, 0),
(3, 4, 'HAWKINS', 'JIM', '1234', 'hawjim@gmail.com', 5, 2, 2, 0),
(4, 2, 'OBRA', 'Jemal', '1234', 'jaimalobra@gmail.com', 5, 5, 1, 0),
(5, 4, 'ALJAMB', 'Jemal', 'Azerty', 'jemalaljamb@gmail.com', 3, 5, 2, 0),
(6, 4, 'PARMENTIER', 'Achille', 'Azerty', 'achilleparmentier@gmail.com', 5, 4, 2, 2),
(7, 2, 'EXEMPLE', 'Camille', '1234', 'eca@gmail.com', 0, 0, 0, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
