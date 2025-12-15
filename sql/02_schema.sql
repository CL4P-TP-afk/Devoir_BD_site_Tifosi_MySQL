-- Sélectionner la base Tifosi (la base doit exister)
USE tifosi;

-- 0 Suppression des tables dans l'ordre inverse des dépendances (FK)
DROP TABLE IF EXISTS achat;
DROP TABLE IF EXISTS menu_boisson;
DROP TABLE IF EXISTS focaccia_ingredient;
DROP TABLE IF EXISTS boisson;
DROP TABLE IF EXISTS focaccia;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS marque;

-- 1 Table: marque
-- Règles simples : id auto-incrémenté, nom unique, timestamps utiles
CREATE TABLE IF NOT EXISTS marque (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_marque_nom (nom)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- 2 Table: ingredient
CREATE TABLE IF NOT EXISTS ingredient (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ingredient_nom (nom)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- 3 Table: focaccia
CREATE TABLE IF NOT EXISTS focaccia (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prix DECIMAL(5,2) NOT NULL,
  menu_id BIGINT UNSIGNED NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_focaccia_nom (nom),
  KEY idx_focaccia_prix (prix),
  KEY idx_focaccia_menu (menu_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;


-- 4 Table: boisson
CREATE TABLE IF NOT EXISTS boisson (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  marque_id BIGINT UNSIGNED NOT NULL,  -- FK vers marque
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_boisson_nom_marque (nom, marque_id), -- évite doublon même nom dans une même marque
  KEY idx_boisson_marque (marque_id),
  CONSTRAINT fk_boisson_marque
    FOREIGN KEY (marque_id) REFERENCES marque(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- 5 Table: focaccia_ingredient
-- Association N–N entre focaccia et ingredient, avec attribut quantite
CREATE TABLE IF NOT EXISTS focaccia_ingredient (
  focaccia_id BIGINT UNSIGNED NOT NULL,
  ingredient_id BIGINT UNSIGNED NOT NULL,
  quantite INT NULL,
  PRIMARY KEY (focaccia_id, ingredient_id),
  CONSTRAINT fk_fi_focaccia
    FOREIGN KEY (focaccia_id) REFERENCES focaccia(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_fi_ingredient
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- 6 Table: client
CREATE TABLE IF NOT EXISTS client (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  code_postal VARCHAR(10) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_client_email (email)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- 7 Table: menu 
CREATE TABLE IF NOT EXISTS menu (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prix DECIMAL(5,2) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_menu_nom (nom)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;
  
/* menu_id est NULL pour ne pas casser les données actuelles (table menu vide).
Quand la table menu auras des menus, on passe cette colonne en NOT NULL */
ALTER TABLE focaccia
  ADD CONSTRAINT fk_focaccia_menu
    FOREIGN KEY (menu_id) REFERENCES menu(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

-- 8 Table: menu_boisson
-- Association N–N entre menu et boisson
CREATE TABLE IF NOT EXISTS menu_boisson (
  menu_id BIGINT UNSIGNED NOT NULL,
  boisson_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (menu_id, boisson_id),
  KEY idx_mb_boisson (boisson_id),
  CONSTRAINT fk_mb_menu
    FOREIGN KEY (menu_id) REFERENCES menu(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_mb_boisson
    FOREIGN KEY (boisson_id) REFERENCES boisson(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- 9 Table: achat
-- Association N–N entre client et menu , porteuse d'attribut date_achat
CREATE TABLE IF NOT EXISTS achat (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  client_id BIGINT UNSIGNED NOT NULL,
  menu_id BIGINT UNSIGNED NOT NULL,
  date_achat DATE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_achat_client (client_id),
  KEY idx_achat_menu (menu_id),
  KEY idx_achat_date (date_achat),
  CONSTRAINT fk_achat_client
    FOREIGN KEY (client_id) REFERENCES client(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_achat_menu
    FOREIGN KEY (menu_id) REFERENCES menu(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

