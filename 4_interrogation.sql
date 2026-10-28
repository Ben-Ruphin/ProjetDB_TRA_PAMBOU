-- Scenario : le responsable de la programmation et des audiences cherche a
-- analyser les grilles TV, les programmes, les chaines et les audiences.
-- Executer apres 1_creation.sql, 2_contraintes.sql et 3_insertion.sql.
-- Les donnees recherchees sont decrites avant chaque requete.
-- ============================================================================

USE telediffusion;

-- ============================================================================
-- A. PROJECTIONS / SELECTIONS / TRI / DISTINCT / LIKE / IN / BETWEEN (5)
-- ============================================================================

-- Q01. Rechercher les programmes d'au moins 90 minutes, du plus long au plus court.
-- Concepts : SELECT (projection), WHERE (selection), ORDER BY (tri).
SELECT p.id_programme, p.titre_programme, p.duree_programme
FROM programme AS p
WHERE p.duree_programme >= 90
ORDER BY p.duree_programme DESC, p.titre_programme ASC;

-- Q02. Lister les differents types de contenus audiovisuels sans doublons.
-- Concepts : DISTINCT, ORDER BY.
SELECT DISTINCT ca.type_contenu
FROM contenu_audiovisuel AS ca
ORDER BY ca.type_contenu;

-- Q03. Rechercher les programmes dont le titre commence par "Les".
-- Concepts : LIKE avec le masque %.
SELECT p.id_programme, p.titre_programme, p.annee_production
FROM programme AS p
WHERE p.titre_programme LIKE 'Les%'
ORDER BY p.titre_programme;

-- Q04. Retrouver les programmes appartenant aux categories Information (1),
-- Sport (2) ou Documentaire (4), d'apres 3_insertion.sql.
-- Concepts : IN, ORDER BY.
SELECT p.id_programme, p.titre_programme, p.id_categorie
FROM programme AS p
WHERE p.id_categorie IN (1, 2, 4)
ORDER BY p.id_categorie, p.titre_programme;

-- Q05. Identifier les programmes produits de 2024 a 2026 inclus,
-- et dont la duree est comprise entre 45 et 90 minutes.
-- Concepts : BETWEEN, AND, ORDER BY.
SELECT p.id_programme, p.titre_programme,
       p.annee_production, p.duree_programme
FROM programme AS p
WHERE p.annee_production BETWEEN 2024 AND 2026
  AND p.duree_programme BETWEEN 45 AND 90
ORDER BY p.annee_production DESC, p.duree_programme;

-- ============================================================================
-- B. STATISTIQUES : AGREGATIONS + GROUP BY + HAVING (5)
-- ============================================================================

-- Q06. Compter les diffusions de chaque chaine et garder celles qui ont
-- diffusé au moins 15 programmes (diffusions, meme si un programme revient).
-- Concepts : COUNT, LEFT JOIN, GROUP BY, HAVING.
SELECT c.id_chaine, c.nom_chaine,
       COUNT(d.id_diffusion) AS nombre_diffusions
FROM chaine AS c
         LEFT JOIN diffusion AS d ON d.id_chaine = c.id_chaine
GROUP BY c.id_chaine, c.nom_chaine
HAVING COUNT(d.id_diffusion) >= 15
ORDER BY nombre_diffusions DESC, c.nom_chaine;

-- Q07. Calculer la part d'audience moyenne par chaine
-- et conserver celles ayant une moyenne superieure a 20 %.
-- Concepts : AVG, ROUND, GROUP BY, HAVING.
SELECT c.id_chaine, c.nom_chaine,
       ROUND(AVG(a.part_audience), 2) AS audience_moyenne_pct
FROM chaine AS c
         JOIN diffusion AS d ON d.id_chaine = c.id_chaine
         JOIN audience AS a ON a.id_diffusion = d.id_diffusion
GROUP BY c.id_chaine, c.nom_chaine
HAVING AVG(a.part_audience) > 20
ORDER BY audience_moyenne_pct DESC;

-- Q08. Compter les programmes par categorie et ne garder que les categories
-- comprenant au moins 10 programmes.
-- Concepts : COUNT, GROUP BY, HAVING.
SELECT ca.nom_categorie,
       COUNT(p.id_programme) AS nombre_programmes
FROM categorie AS ca
         LEFT JOIN programme AS p ON p.id_categorie = ca.id_categorie
GROUP BY ca.id_categorie, ca.nom_categorie
HAVING COUNT(p.id_programme) >= 10
ORDER BY nombre_programmes DESC, ca.nom_categorie;

-- Q09. Trouver les programmes cumulant au moins 1 000 000 de telespectateurs
-- sur leurs diffusions ayant une audience mesuree.
-- Concepts : SUM, GROUP BY, HAVING.
SELECT p.id_programme, p.titre_programme,
       SUM(a.nbre_telespectateurs) AS cumul_telespectateurs
FROM programme AS p
         JOIN diffusion AS d ON d.id_programme = p.id_programme
         JOIN audience AS a ON a.id_diffusion = d.id_diffusion
GROUP BY p.id_programme, p.titre_programme
HAVING SUM(a.nbre_telespectateurs) >= 1000000
ORDER BY cumul_telespectateurs DESC;

-- Q10. Reperer les emissions ayant au moins 3 episodes references.
-- Concepts : COUNT, GROUP BY, HAVING.
SELECT e.id_emission, e.nom_emission,
       COUNT(ep.num_episode) AS nombre_episodes
FROM emission AS e
         LEFT JOIN episode AS ep ON ep.id_emission = e.id_emission
GROUP BY e.id_emission, e.nom_emission
HAVING COUNT(ep.num_episode) >= 3
ORDER BY nombre_episodes DESC, e.nom_emission;

-- ============================================================================
-- C. JOINTURES INTERNES / EXTERNES / MULTIPLES (5)
-- ============================================================================

-- Q11. Sur la chaine 1 (Horizon TV), quelles diffusions concernent des
-- programmes d'au moins 60 minutes ?
-- Concepts : deux INNER JOIN, WHERE, projection, tri.
-- CETTE REQUETE EST CELLE ANALYSEE DANS LE README (DEUX PLANS D'EXECUTION).
SELECT d.id_diffusion, c.nom_chaine,
       p.titre_programme, p.duree_programme
FROM chaine AS c
         INNER JOIN diffusion AS d ON d.id_chaine = c.id_chaine
         INNER JOIN programme AS p ON p.id_programme = d.id_programme
WHERE c.id_chaine = 1
  AND p.duree_programme >= 60
ORDER BY d.id_diffusion;

-- Q12. Afficher les programmes et leurs diffusions eventuelles.
-- Un programme sans diffusion resterait present (colonnes d.id_diffusion NULL).
-- Concepts : LEFT JOIN, jointure externe.
SELECT p.id_programme, p.titre_programme,
       d.id_diffusion, d.date_debut_diffusion
FROM programme AS p
         LEFT JOIN diffusion AS d ON d.id_programme = p.id_programme
ORDER BY p.id_programme, d.date_debut_diffusion;

-- Q13. Identifier les diffusions qui n'ont pas encore de mesure d'audience.
-- Concepts : LEFT JOIN et test IS NULL (jointure externe).
SELECT d.id_diffusion, d.id_chaine,
       d.date_debut_diffusion, d.heure_debut_diffusion
FROM diffusion AS d
         LEFT JOIN audience AS a ON a.id_diffusion = d.id_diffusion
WHERE a.id_audience IS NULL
ORDER BY d.date_debut_diffusion, d.heure_debut_diffusion;

-- Q14. Afficher chaque episode avec son emission et le programme correspondant.
-- Concepts : deux INNER JOIN, jointure multiple.
SELECT e.nom_emission, ep.num_episode,
       p.id_programme, p.titre_programme
FROM episode AS ep
         INNER JOIN emission AS e ON e.id_emission = ep.id_emission
         INNER JOIN programme AS p ON p.id_programme = ep.id_programme
ORDER BY e.nom_emission, ep.num_episode;

-- Q15. Indiquer les modes de diffusion disponibles pour chaque programme.
-- Concepts : association plusieurs-a-plusieurs, jointures multiples.
SELECT p.id_programme, p.titre_programme, md.nom_mode
FROM programme AS p
         INNER JOIN distribuer AS di ON di.id_programme = p.id_programme
         INNER JOIN mode_diffusion AS md ON md.id_mode = di.id_mode
ORDER BY p.titre_programme, md.nom_mode;

-- ============================================================================
-- D. SOUS-REQUETES : IN / NOT IN / EXISTS / NOT EXISTS / ANY / ALL (6)
-- ============================================================================

-- Q16. Rechercher les programmes appartenant aux categories Sport
-- ou Documentaire a l'aide d'une sous-requete IN.
SELECT p.id_programme, p.titre_programme
FROM programme AS p
WHERE p.id_categorie IN (
    SELECT ca.id_categorie
    FROM categorie AS ca
    WHERE ca.nom_categorie IN ('Sport', 'Documentaire')
)
ORDER BY p.titre_programme;

-- Q17. Trouver les diffusions dont l'identifiant n'apparait pas dans AUDIENCE.
-- Concepts : NOT IN. id_diffusion est NOT NULL dans les deux tables.
SELECT d.id_diffusion, d.id_chaine, d.date_debut_diffusion
FROM diffusion AS d
WHERE d.id_diffusion NOT IN (
    SELECT a.id_diffusion
    FROM audience AS a
)
ORDER BY d.id_diffusion;

-- Q18. Identifier les chaines ayant au moins une diffusion avec une
-- part d'audience superieure a 30 %.
-- Concepts : sous-requete correlee EXISTS.
SELECT c.id_chaine, c.nom_chaine
FROM chaine AS c
WHERE EXISTS (
    SELECT 1
    FROM diffusion AS d
             JOIN audience AS a ON a.id_diffusion = d.id_diffusion
    WHERE d.id_chaine = c.id_chaine
      AND a.part_audience > 30
)
ORDER BY c.nom_chaine;

-- Q19. Identifier les programmes qui ne sont rattaches a aucun episode
-- (par exemple les films autonomes ou les programmes hors emission).
-- Concepts : sous-requete correlee NOT EXISTS.
SELECT p.id_programme, p.titre_programme
FROM programme AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM episode AS ep
    WHERE ep.id_programme = p.id_programme
)
ORDER BY p.id_programme;

-- Q20. Trouver les programmes plus longs qu'AU MOINS UN programme
-- de la categorie Jeunesse (id_categorie = 8 dans 3_insertion.sql).
-- Concepts : comparaison > ANY (MySQL 8).
SELECT p.id_programme, p.titre_programme, p.duree_programme
FROM programme AS p
WHERE p.duree_programme > ANY (
    SELECT p2.duree_programme
    FROM programme AS p2
    WHERE p2.id_categorie = 8
)
ORDER BY p.duree_programme DESC, p.id_programme;

-- Q21. Trouver les programmes dont la duree est superieure ou egale a
-- TOUTES les autres durees : les programmes les plus longs de la base.
-- Concepts : comparaison >= ALL (MySQL 8).
SELECT p.id_programme, p.titre_programme, p.duree_programme
FROM programme AS p
WHERE p.duree_programme >= ALL (
    SELECT p2.duree_programme
    FROM programme AS p2
)
ORDER BY p.id_programme;


