-- ATTENTION : script destructif
-- Supprime la base tifosi si elle existe, puis la recrée proprement
-- 1) Supprimer la base Tifosi si elle existe
DROP DATABASE IF EXISTS tifosi;

-- 2) Création de la base si besoin

CREATE DATABASE IF NOT EXISTS tifosi
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
  