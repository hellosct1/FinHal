--
-- Structure de la table `OWNER_TOKENS`
--

CREATE TABLE `OWNER_TOKENS` (
  `TID` int(10) UNSIGNED NOT NULL,
  `UID` int(10) UNSIGNED NOT NULL,
  `DOCID` int(10) UNSIGNED NOT NULL,
  `TOKEN` varchar(40) NOT NULL,
  `TIME_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `USAGE` enum('UNSHARE') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour la table `OWNER_TOKENS`
--
ALTER TABLE `OWNER_TOKENS`
  ADD PRIMARY KEY (`TID`);

--
-- AUTO_INCREMENT pour la table `OWNER_TOKENS`
--
ALTER TABLE `OWNER_TOKENS`
  MODIFY `TID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;