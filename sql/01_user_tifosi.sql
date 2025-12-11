-- Script de création de l'utilisateur MySQL "tifosi"
-- À exécuter avec un compte ayant les droits administrateur (ex : root).
-- Nécessite que la base "tifosi" existe déjà (voir 00_create_database.sql).

-- 1) Création de l'utilisateur applicatif (mot de passe pédagogique à changer en contexte réel)  
CREATE USER IF NOT EXISTS 'tifosi'@'localhost'
  IDENTIFIED BY 'ChangeMe!123';

-- 2) Attribution des droits sur la base "tifosi"
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

-- 3) Rafraîchir les privilèges
FLUSH PRIVILEGES;
