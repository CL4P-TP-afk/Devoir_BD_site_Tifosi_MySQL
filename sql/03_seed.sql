-- 02_seed.sql
-- Peuplement initial de la base Tifosi
-- A exécuter après 01_schema.sql
USE tifosi;

-- 1) Marque
INSERT INTO marque (nom) VALUES
('Coca-cola'),
('Cristalline'),
('Monster'),
('Pepsico');

-- 2) Boisson
INSERT INTO boisson (nom, marque_id) VALUES
('Coca-cola zéro', (SELECT id FROM marque WHERE nom = 'Coca-cola')),
('Coca-cola original', (SELECT id FROM marque WHERE nom = 'Coca-cola')),
('Fanta citron', (SELECT id FROM marque WHERE nom = 'Coca-cola')),
('Fanta orange', (SELECT id FROM marque WHERE nom = 'Coca-cola')),
('Capri-sun', (SELECT id FROM marque WHERE nom = 'Coca-cola')),
('Pepsi', (SELECT id FROM marque WHERE nom = 'Pepsico')),
('Pepsi Max Zéro', (SELECT id FROM marque WHERE nom = 'Pepsico')),
('Lipton zéro citron', (SELECT id FROM marque WHERE nom = 'Pepsico')),
('Lipton Peach', (SELECT id FROM marque WHERE nom = 'Pepsico')),
('Monster energy ultra gold',   (SELECT id FROM marque WHERE nom = 'Monster')),
('Monster energy ultra blue', (SELECT id FROM marque WHERE nom = 'Monster')),
('Eau de source', (SELECT id FROM marque WHERE nom = 'Cristalline'));

-- 3) Ingrédient
INSERT INTO ingredient (nom) VALUES
('Ail'),
('Ananas'),
('Artichaut'),
('Bacon'),
('Base tomate'),
('Base crème'),
('Champignon'),
('Chèvre'),
('Cresson'),
('Emmental'),
('Gorgonzola'),
('Jambon cuit'),
('Jambon fumé'),
('Oeuf'),
('Oignon'),
('Olive noire'),
('Olive verte'),
('Parmesan'),
('Piment'),
('Poivre'),
('Pomme de terre'),
('Raclette'),
('Salami'),
('Tomate cerise'),
('Mozarella');


-- 4) Focaccia
INSERT INTO focaccia (nom, prix) VALUES
('Mozaccia', 9.80),
('Gorgonzollaccia', 10.80),
('Raclaccia', 8.90),
('Emmentalaccia', 9.80),
('Tradizione', 8.90),
('Hawaienne', 11.20),
('Américaine', 10.80),
('Paysanne', 12.80);

-- 5) Focaccia_ingredient (liaisons N–N)
START TRANSACTION;

-- === Mozaccia ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Mozaccia' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base tomate' AS nom, 200 AS qte UNION ALL
  SELECT 'Mozarella', 50 UNION ALL 
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Jambon fumé', 80 UNION ALL
  SELECT 'Ail', 2 UNION ALL
  SELECT 'Artichaut', 20 UNION ALL
  SELECT 'Champignon', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Olive noire', 20
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Gorgonzollaccia ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Gorgonzollaccia' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base tomate' AS nom, 200 AS qte UNION ALL
  SELECT 'Gorgonzola', 50 UNION ALL
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Ail', 2 UNION ALL
  SELECT 'Champignon', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Olive noire', 20
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Raclaccia ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Raclaccia' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base tomate' AS nom, 200 AS qte UNION ALL
  SELECT 'Raclette', 50 UNION ALL
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Ail', 2 UNION ALL
  SELECT 'Champignon', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Emmentalaccia ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Emmentalaccia' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base crème' AS nom, 200 AS qte UNION ALL        
  SELECT 'Emmental', 50 UNION ALL
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Champignon', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Oignon', 20
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Tradizione ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Tradizione' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base tomate' AS nom, 200 AS qte UNION ALL      
  SELECT 'Mozarella', 50 UNION ALL
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'jambon cuit', 80 UNION ALL
  SELECT 'Champignon', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Olive noire', 10 UNION ALL
  SELECT 'Olive verte', 10 
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Hawaienne ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Hawaienne' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base tomate' AS nom, 200 AS qte UNION ALL  
  SELECT 'Mozarella', 50 UNION ALL
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Bacon', 80 UNION ALL
  SELECT 'Ananas', 40 UNION ALL
  SELECT 'Piment', 2 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Olive noire', 20
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Américaine ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Américaine' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base tomate' AS nom, 200 AS qte UNION ALL   
  SELECT 'Mozarella', 50 UNION ALL
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Bacon', 80 UNION ALL
  SELECT 'Pomme de terre', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Olive noire', 20
) AS t
JOIN ingredient i ON i.nom = t.nom;

-- === Paysanne ===
INSERT INTO focaccia_ingredient (focaccia_id, ingredient_id, quantite)
SELECT f.id, i.id, t.qte
FROM (SELECT 'Paysanne' AS focaccia_nom) f0
JOIN focaccia f ON f.nom = f0.focaccia_nom
JOIN (
  SELECT 'Base crème' AS nom, 200 AS qte UNION ALL   
  SELECT 'Chèvre', 50 UNION ALL 
  SELECT 'Cresson', 20 UNION ALL
  SELECT 'Pomme de terre', 80 UNION ALL
  SELECT 'Jambon fumé', 80 UNION ALL
  SELECT 'Ail', 2 UNION ALL
  SELECT 'Artichaut', 20 UNION ALL
  SELECT 'Champignon', 40 UNION ALL
  SELECT 'Parmesan', 50 UNION ALL
  SELECT 'Poivre', 1 UNION ALL
  SELECT 'Olive noire', 20 UNION ALL
  SELECT 'Oeuf', 50
) AS t
JOIN ingredient i ON i.nom = t.nom;

COMMIT;


