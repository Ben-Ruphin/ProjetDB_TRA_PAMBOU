-- Création de la base de données

CREATE DATABASE IF NOT EXISTS telediffusion;

USE telediffusion;


-- ============================================
-- 1. TABLE CHAINE
-- ============================================

CREATE TABLE chaine (
                        id_chaine INT PRIMARY KEY,
                        nom_chaine VARCHAR(50) NOT NULL,
                        description_chaine VARCHAR(250)
);


-- ============================================
-- 2. TABLE CATEGORIE
-- ============================================

CREATE TABLE categorie (
                           id_categorie INT PRIMARY KEY,
                           nom_categorie VARCHAR(100) NOT NULL
);


-- ============================================
-- 3. TABLE PRODUCTEUR
-- ============================================

CREATE TABLE producteur (
                            id_producteur INT PRIMARY KEY,
                            nom_producteur VARCHAR(100) NOT NULL,
                            prenom_producteur VARCHAR(100) NOT NULL
);


-- ============================================
-- 4. TABLE INTERVENANT
-- ============================================

CREATE TABLE intervenant (
                             id_intervenant INT PRIMARY KEY,
                             nom_intervenant VARCHAR(100) NOT NULL,
                             prenom_intervenant VARCHAR(100) NOT NULL,
                             fonction_intervenant VARCHAR(100) NOT NULL
);


-- ============================================
-- 5. TABLE EMISSION
-- ============================================

CREATE TABLE emission (
                          id_emission INT PRIMARY KEY,
                          nom_emission VARCHAR(100) NOT NULL
);


-- ============================================
-- 6. TABLE MODE_DIFFUSION
-- ============================================

CREATE TABLE mode_diffusion (
                                id_mode INT PRIMARY KEY,
                                nom_mode VARCHAR(100) NOT NULL
);


-- ============================================
-- 7. TABLE CONTENU_AUDIOVISUEL
-- Association récursive DERIVER_DE
-- ============================================

CREATE TABLE contenu_audiovisuel (
                                     id_contenu INT PRIMARY KEY,
                                     titre_contenu VARCHAR(100) NOT NULL,
                                     type_contenu VARCHAR(100),
                                     duree_contenu INT NOT NULL,
                                     id_contenu_origine INT NULL,

                                     CONSTRAINT fk_contenu_origine
                                         FOREIGN KEY (id_contenu_origine)
                                             REFERENCES contenu_audiovisuel(id_contenu)
                                             ON DELETE SET NULL
                                             ON UPDATE CASCADE
);


-- ============================================
-- 8. TABLE PROGRAMME
-- ============================================

CREATE TABLE programme (
                           id_programme INT PRIMARY KEY,
                           titre_programme VARCHAR(100) NOT NULL,
                           description_programme VARCHAR(255) NOT NULL,
                           duree_programme INT NOT NULL,
                           annee_production INT NOT NULL,
                           id_categorie INT NOT NULL,

                           CONSTRAINT fk_programme_categorie
                               FOREIGN KEY (id_categorie)
                                   REFERENCES categorie(id_categorie)
                                   ON DELETE CASCADE
                                   ON UPDATE CASCADE
);


-- ============================================
-- 9. TABLE DIFFUSION
-- ============================================

CREATE TABLE diffusion (
                           id_diffusion INT PRIMARY KEY,
                           date_debut_diffusion DATE NOT NULL,
                           heure_debut_diffusion TIME NOT NULL,
                           heure_fin_diffusion TIME NOT NULL,
                           date_fin_diffusion DATE NOT NULL,
                           id_programme INT NOT NULL,
                           id_chaine INT NOT NULL,

                           CONSTRAINT fk_diffusion_programme
                               FOREIGN KEY (id_programme)
                                   REFERENCES programme(id_programme)
                                   ON DELETE CASCADE
                                   ON UPDATE CASCADE,

                           CONSTRAINT fk_diffusion_chaine
                               FOREIGN KEY (id_chaine)
                                   REFERENCES chaine(id_chaine)
                                   ON DELETE CASCADE
                                   ON UPDATE CASCADE
);


-- ============================================
-- 10. TABLE AUDIENCE
-- ============================================

CREATE TABLE audience (
                          id_audience INT PRIMARY KEY,
                          part_audience DECIMAL(5,2) NOT NULL,
                          nbre_telespectateurs BIGINT NOT NULL,
                          id_diffusion INT NOT NULL UNIQUE,

                          CONSTRAINT fk_audience_diffusion
                              FOREIGN KEY (id_diffusion)
                                  REFERENCES diffusion(id_diffusion)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);


-- ============================================
-- 11. TABLE EPISODE
-- Entité faible dépendant de EMISSION
-- ============================================

CREATE TABLE episode (
                         id_emission INT NOT NULL,
                         num_episode INT NOT NULL,
                         id_programme INT NOT NULL UNIQUE,

                         PRIMARY KEY (id_emission, num_episode),

                         CONSTRAINT fk_episode_emission
                             FOREIGN KEY (id_emission)
                                 REFERENCES emission(id_emission)
                                 ON DELETE CASCADE
                                 ON UPDATE CASCADE,

                         CONSTRAINT fk_episode_programme
                             FOREIGN KEY (id_programme)
                                 REFERENCES programme(id_programme)
                                 ON DELETE CASCADE
                                 ON UPDATE CASCADE
);


-- ============================================
-- 12. TABLE PRODUIRE
-- Association PRODUCTEUR / PROGRAMME
-- ============================================

CREATE TABLE produire (
                          id_programme INT NOT NULL,
                          id_producteur INT NOT NULL,

                          PRIMARY KEY (id_programme, id_producteur),

                          CONSTRAINT fk_produire_programme
                              FOREIGN KEY (id_programme)
                                  REFERENCES programme(id_programme)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE,

                          CONSTRAINT fk_produire_producteur
                              FOREIGN KEY (id_producteur)
                                  REFERENCES producteur(id_producteur)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);


-- ============================================
-- 13. TABLE PARTICIPER
-- Association INTERVENANT / EMISSION
-- ============================================

CREATE TABLE participer (
                            id_intervenant INT NOT NULL,
                            id_emission INT NOT NULL,

                            PRIMARY KEY (id_intervenant, id_emission),

                            CONSTRAINT fk_participer_intervenant
                                FOREIGN KEY (id_intervenant)
                                    REFERENCES intervenant(id_intervenant)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE,

                            CONSTRAINT fk_participer_emission
                                FOREIGN KEY (id_emission)
                                    REFERENCES emission(id_emission)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE
);


-- ============================================
-- 14. TABLE UTILISER
-- Association PROGRAMME / CONTENU_AUDIOVISUEL
-- ============================================

CREATE TABLE utiliser (
                          id_programme INT NOT NULL,
                          id_contenu INT NOT NULL,

                          PRIMARY KEY (id_programme, id_contenu),

                          CONSTRAINT fk_utiliser_programme
                              FOREIGN KEY (id_programme)
                                  REFERENCES programme(id_programme)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE,

                          CONSTRAINT fk_utiliser_contenu
                              FOREIGN KEY (id_contenu)
                                  REFERENCES contenu_audiovisuel(id_contenu)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);


-- ============================================
-- 15. TABLE DISTRIBUER
-- Association PROGRAMME / MODE_DIFFUSION
-- ============================================

CREATE TABLE distribuer (
                            id_programme INT NOT NULL,
                            id_mode INT NOT NULL,

                            PRIMARY KEY (id_programme, id_mode),

                            CONSTRAINT fk_distribuer_programme
                                FOREIGN KEY (id_programme)
                                    REFERENCES programme(id_programme)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE,

                            CONSTRAINT fk_distribuer_mode
                                FOREIGN KEY (id_mode)
                                    REFERENCES mode_diffusion(id_mode)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE
);
