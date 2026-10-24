
ALTER TABLE diffusion
    ADD CONSTRAINT chk_diffusion_ordre_chronologique
        CHECK (
            date_fin_diffusion > date_debut_diffusion
                OR (
                date_fin_diffusion = date_debut_diffusion
                    AND heure_fin_diffusion > heure_debut_diffusion
                )
            ),
    ADD CONSTRAINT chk_diffusion_heure_debut
        CHECK (heure_debut_diffusion BETWEEN '00:00:00' AND '23:59:59'),
    ADD CONSTRAINT chk_diffusion_heure_fin
        CHECK (heure_fin_diffusion BETWEEN '00:00:00' AND '23:59:59');

-- ================================================================
-- 5. TRIGGERS : INTERDIRE LE CHEVAUCHEMENT DES DIFFUSIONS
-- Sur la meme chaine, deux intervalles [debut, fin[ ne doivent
-- pas se superposer. Deux emissions consecutives peuvent se
-- toucher exactement a la frontiere de leurs horaires.
-- ================================================================

DELIMITER $$

DROP TRIGGER IF EXISTS trg_diffusion_sans_chevauchement_ins$$
CREATE TRIGGER trg_diffusion_sans_chevauchement_ins
    BEFORE INSERT ON diffusion
    FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM diffusion AS d
        WHERE d.id_chaine = NEW.id_chaine
          AND TIMESTAMP(d.date_debut_diffusion, d.heure_debut_diffusion)
            < TIMESTAMP(NEW.date_fin_diffusion, NEW.heure_fin_diffusion)
          AND TIMESTAMP(d.date_fin_diffusion, d.heure_fin_diffusion)
            > TIMESTAMP(NEW.date_debut_diffusion, NEW.heure_debut_diffusion)
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Chevauchement de diffusions sur cette chaine';
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_diffusion_sans_chevauchement_upd$$
CREATE TRIGGER trg_diffusion_sans_chevauchement_upd
    BEFORE UPDATE ON diffusion
    FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM diffusion AS d
        WHERE d.id_chaine = NEW.id_chaine
          AND d.id_diffusion <> OLD.id_diffusion
          AND TIMESTAMP(d.date_debut_diffusion, d.heure_debut_diffusion)
            < TIMESTAMP(NEW.date_fin_diffusion, NEW.heure_fin_diffusion)
          AND TIMESTAMP(d.date_fin_diffusion, d.heure_fin_diffusion)
            > TIMESTAMP(NEW.date_debut_diffusion, NEW.heure_debut_diffusion)
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Chevauchement de diffusions sur cette chaine';
    END IF;
END$$

-- ================================================================
-- 6. TRIGGERS : DERIVATION DES CONTENUS AUDIOVISUELS
-- Un contenu ne peut pas etre son propre ancetre. On ne met pas
-- de CHECK sur id_contenu_origine car cette cle etrangere utilise
-- ON DELETE SET NULL et ON UPDATE CASCADE dans 1_creation.sql.
-- ================================================================

DROP TRIGGER IF EXISTS trg_contenu_pas_de_cycle_ins$$
CREATE TRIGGER trg_contenu_pas_de_cycle_ins
    BEFORE INSERT ON contenu_audiovisuel
    FOR EACH ROW
BEGIN
    DECLARE v_ancetre INT;
    SET v_ancetre = NEW.id_contenu_origine;

    WHILE v_ancetre IS NOT NULL DO
            IF v_ancetre = NEW.id_contenu THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Derivation cyclique interdite';
            END IF;

            SELECT MAX(c.id_contenu_origine)
            INTO v_ancetre
            FROM contenu_audiovisuel AS c
            WHERE c.id_contenu = v_ancetre;
        END WHILE;
END$$

DROP TRIGGER IF EXISTS trg_contenu_pas_de_cycle_upd$$
CREATE TRIGGER trg_contenu_pas_de_cycle_upd
    BEFORE UPDATE ON contenu_audiovisuel
    FOR EACH ROW
BEGIN
    DECLARE v_ancetre INT;
    SET v_ancetre = NEW.id_contenu_origine;

    WHILE v_ancetre IS NOT NULL DO
            IF v_ancetre = NEW.id_contenu THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Derivation cyclique interdite';
            END IF;

            SELECT MAX(c.id_contenu_origine)
            INTO v_ancetre
            FROM contenu_audiovisuel AS c
            WHERE c.id_contenu = v_ancetre;
        END WHILE;
END$$

DELIMITER ;
