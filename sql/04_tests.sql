-- 03_tests.sql
-- Vérifications demandées dans le brief
-- A exécuter après 01_schema.sql et 02_seed.sql
USE tifosi;

-- 1) Afficher la liste des noms des focaccias par ordre alphabétique croissant
SELECT nom AS focaccia
FROM focaccia
ORDER BY nom ASC;

-- 2) Afficher le nombre total d'ingrédients
SELECT COUNT(*) AS nb_ingredients
FROM ingredient;

-- 3) Afficher le prix moyen des focaccias
SELECT ROUND(AVG(prix), 2) AS prix_moyen_focaccia
FROM focaccia;

-- 4) Afficher la liste des boissons avec leur marque, triée par nom de boisson
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON m.id = b.marque_id
ORDER BY b.nom ASC;

-- 5) Afficher la liste des ingrédients pour une Raclaccia
SELECT i.nom AS ingredient, fi.quantite
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.focaccia_id = f.id
JOIN ingredient i ON i.id = fi.ingredient_id
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- 6) Afficher le nom et le nombre d'ingrédients pour chaque focaccia
SELECT f.nom AS focaccia, COUNT(fi.ingredient_id) AS nb_ingredients
FROM focaccia f
LEFT JOIN focaccia_ingredient fi ON fi.focaccia_id = f.id
GROUP BY f.id, f.nom
ORDER BY nb_ingredients DESC, f.nom ASC;

-- 7) Afficher le nom de la focaccia qui a le plus d'ingrédients
SELECT f.nom AS focaccia, COUNT(fi.ingredient_id) AS nb_ingredients
FROM focaccia f
LEFT JOIN focaccia_ingredient fi ON fi.focaccia_id = f.id
GROUP BY f.id, f.nom
ORDER BY nb_ingredients DESC, f.nom ASC
LIMIT 1;

-- 8) Afficher la liste des focaccia qui contiennent de l'ail
SELECT DISTINCT f.nom AS focaccia
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.focaccia_id = f.id
JOIN ingredient i ON i.id = fi.ingredient_id
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- 9) Afficher la liste des ingrédients inutilisés
SELECT i.nom AS ingredient_non_utilise
FROM ingredient i
LEFT JOIN focaccia_ingredient fi ON fi.ingredient_id = i.id
WHERE fi.ingredient_id IS NULL
ORDER BY i.nom ASC;

-- 10) Afficher la liste des focaccia qui n'ont pas de champignons
SELECT f.nom AS focaccia_sans_champignon
FROM focaccia f
WHERE NOT EXISTS (
  SELECT 1
  FROM focaccia_ingredient fi
  JOIN ingredient i ON i.id = fi.ingredient_id
  WHERE fi.focaccia_id = f.id
    AND i.nom = 'Champignon'
)
ORDER BY f.nom ASC;
