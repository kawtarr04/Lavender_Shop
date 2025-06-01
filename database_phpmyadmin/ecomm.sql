-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 17 jan. 2025 à 20:54
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecomm`
--

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

CREATE TABLE `livraison` (
  `nomC` varchar(250) NOT NULL,
  `numero_tel` int(10) NOT NULL,
  `adresseMail` varchar(20) NOT NULL,
  `adresseLivraison` varchar(250) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `livraison`
--

INSERT INTO `livraison` (`nomC`, `numero_tel`, `adresseMail`, `adresseLivraison`, `id`) VALUES
('kawtarrr', 689291196, 'k.tabaa09@gmail.com', 'hay el ouard 104 casablanca', 1),
('Sara', 689291196, 'sara@gmail.com', 'Quartier Oasis 234, Casablanca', 7);

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `o_id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `o_quantity` int(11) NOT NULL,
  `o_date` varchar(450) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`o_id`, `p_id`, `u_id`, `o_quantity`, `o_date`) VALUES
(6, 0, 3, 5, '2025-01-09'),
(8, 1, 3, 1, '2025-01-09'),
(9, 3, 3, 5, '2025-01-09'),
(10, 2, 3, 1, '2025-01-09'),
(21, 3, 6, 2, '2025-01-09'),
(23, 3, 6, 1, '2025-01-16'),
(28, 8, 5, 1, '2025-01-17'),
(29, 6, 5, 1, '2025-01-17');

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `card_name` varchar(255) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `expiration_date` varchar(5) NOT NULL,
  `security_code` varchar(4) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `payments`
--

INSERT INTO `payments` (`id`, `card_name`, `card_number`, `expiration_date`, `security_code`, `user_id`) VALUES
(1, 'Kawtar', '1234567898765432', '05/30', '465', 6),
(2, 'Malak', '1234548598765432', '02/29', '452', 2),
(3, 'Hiba', '1234548598765432', '02/40', '354', 3),
(4, 'Kawtar T', '1234567890675432', '05/30', '475', 6),
(5, 'Kawtar T', '1234567890675432', '05/30', '475', 6),
(6, 'Sara ', '1234567890675843', '05/30', '347', 5);

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `name` varchar(450) NOT NULL,
  `category` varchar(450) NOT NULL,
  `price` double NOT NULL,
  `image` varchar(450) NOT NULL,
  `description` longtext DEFAULT NULL,
  `rating` float NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`name`, `category`, `price`, `image`, `description`, `rating`, `id`) VALUES
('Roses', 'Bouquet Composé', 180, 'multi.jpeg', '', 0, 1),
('Tulipes', 'Bouquet Composé', 320, 'tulipes.jpeg', '', 0, 2),
('Hortensia', 'Bouquet Simple', 410, 'blanc.jpeg', '', 0, 3),
('L\'Iris', 'Bouquet Simple', 110, 'iris.jpeg', '', 0, 4),
('Jacinthes', 'Bouquet Simple', 340, 'mauve.jpeg', '', 0, 5),
('Tournesol', 'Bouquet Simple', 380, 'tournesol.jpeg', NULL, 0, 6),
('Jasmines', 'Bouquet Simple', 200, 'jasmin.jpeg', '', 0, 8);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'costumer',
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `role`, `email`, `password`) VALUES
(2, 'malak', 'admin', 'malaktabaa7@gmail.com', '123456'),
(3, 'hiba', 'costumer', 'hibaben@gmail.com', '1234567'),
(4, 'nada', 'costumer', 'nada@gmail.com', '1234'),
(5, 'sara', 'costumer', 'sara@gmail.com', '123'),
(6, 'kawtar', 'costumer', 'k.tabaa09@gmail.com', '123');

-- --------------------------------------------------------

--
-- Structure de la table `validation`
--

CREATE TABLE `validation` (
  `o_id` int(11) NOT NULL,
  `statut_paiement` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `validation`
--

INSERT INTO `validation` (`o_id`, `statut_paiement`) VALUES
(10, 'Paiement effectué'),
(21, 'En Attente De Paiement'),
(23, 'En Attente De Paiement');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`o_id`);

--
-- Index pour la table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Index pour la table `validation`
--
ALTER TABLE `validation`
  ADD PRIMARY KEY (`o_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `livraison`
--
ALTER TABLE `livraison`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `o_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT pour la table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `validation`
--
ALTER TABLE `validation`
  ADD CONSTRAINT `validation_ibfk_1` FOREIGN KEY (`o_id`) REFERENCES `orders` (`o_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
