/*VIDEOPROTECTION V1.0.0*/
/*Creation de la structure*/
/* Script_videoprotection.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Caroline Sarg */


/*
#################################################################### SUIVI CODE SQL ####################################################################

2025-02-07 : CS / initialisation du code
2025-02-26 : CS / gestion de la fonctionnalité corbeille
*/



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SUPPRESSION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


/*

-- ## CONTRAINTES
ALTER TABLE IF EXISTS m_videoprotection.lt_type_camera DROP CONSTRAINT IF EXISTS lt_type_camera_pkey;
ALTER TABLE IF EXISTS m_videoprotection.lt_type_support DROP CONSTRAINT IF EXISTS lt_type_support_pkey;


-- ## CLASSE
DROP TABLE IF EXISTS m_videoprotection.geo_video_camera;


-- ## DOMAINE DE VALEUR
DROP TABLE IF EXISTS m_videoprotection.lt_type_camera;
DROP TABLE IF EXISTS m_videoprotection.lt_type_support;


-- ## SEQUENCE
DROP SEQUENCE IF EXISTS m_videoprotection.geo_video_camera_idcam_seq;


-- ## FONCTION
DROP FUNCTION IF EXISTS m_videoprotection.ft_m_corbeille_delete();
DROP FUNCTION IF EXISTS m_videoprotection.ft_m_format_ref_camera();


-- ##SCHEMA
DROP SCHEMA IF EXISTS m_videoprotection CASCADE;


*/


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       SCHEMA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- SCHEMA: m_videoprotection

-- DROP SCHEMA m_videoprotection;

CREATE SCHEMA m_videoprotection
AUTHORIZATION create_sig;
	
COMMENT ON SCHEMA m_videoprotection IS 'Données métiers sur le thème de la vidéoprotection (support, équipement, intervention, procédure administrative, ...)';


GRANT ALL ON SCHEMA m_videoprotection TO create_sig;
GRANT ALL ON SCHEMA m_videoprotection TO sig_create WITH GRANT OPTION;
GRANT ALL ON SCHEMA m_videoprotection TO sig_edit WITH GRANT OPTION;
GRANT ALL ON SCHEMA m_videoprotection TO sig_read WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES FOR ROLE sig_create IN SCHEMA m_videoprotection GRANT ALL ON TABLES TO create_sig;
ALTER DEFAULT PRIVILEGES FOR ROLE sig_create IN SCHEMA m_videoprotection GRANT ALL ON TABLES TO sig_create WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES FOR ROLE sig_create IN SCHEMA m_videoprotection GRANT ALL ON TABLES TO sig_edit WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES FOR ROLE sig_create IN SCHEMA m_videoprotection GRANT ALL ON TABLES TO sig_read WITH GRANT OPTION;



 

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINE  DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- ################################################################# lt_type_camera ###############################################

-- ajout de la table de liste "lt_type_camera"

CREATE TABLE  m_videoprotection.lt_type_camera
(
	code character varying(2) NOT NULL,
	valeur character varying(254) NOT NULL,
	definition character varying(254) NOT NULL, 
	CONSTRAINT lt_type_camera_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_videoprotection.lt_type_camera IS 'Liste permettant de décrire le type de caméra';
COMMENT ON COLUMN m_videoprotection.lt_type_camera.code IS 'Code de la liste énumérée relative au type de caméra';
COMMENT ON COLUMN m_videoprotection.lt_type_camera.valeur IS 'Valeur de la liste énumérée relative au type de caméra';
COMMENT ON COLUMN m_videoprotection.lt_type_camera.definition IS 'Définition de la liste énumérée relative au type de caméra';

COMMENT ON CONSTRAINT lt_type_camera_pkey ON m_videoprotection.lt_type_camera IS 'Clé primaire du domaine de valeur lt_type_camera';

INSERT INTO m_videoprotection.lt_type_camera(
            code, valeur, definition)
    VALUES
  ('00','NR','Non renseigné'),
  ('01','DOM','Dôme'),
  ('02','FIX','Fixe'),
  ('03','FIX180','Fixe 180'),
  ('04','MULTI','Multicapteur'),
  ('99','AUT','Autre');                                
--('ZZ','Non concerné');

 
 


-- ################################################################# lt_type_support ###############################################

-- ajout de la table de liste "lt_type_support"

CREATE TABLE  m_videoprotection.lt_type_support
(
	code character varying(2) NOT NULL,
	valeur character varying(254) NOT NULL,
	definition character varying(254) NOT NULL, 
	CONSTRAINT lt_type_support_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_videoprotection.lt_type_support IS 'Liste permettant de décrire le type de caméra';
COMMENT ON COLUMN m_videoprotection.lt_type_support.code IS 'Code de la liste énumérée relative au type de caméra';
COMMENT ON COLUMN m_videoprotection.lt_type_support.valeur IS 'Valeur de la liste énumérée relative au type de caméra';
COMMENT ON COLUMN m_videoprotection.lt_type_support.definition IS 'Définition de la liste énumérée relative au type de caméra';

COMMENT ON CONSTRAINT lt_type_support_pkey ON m_videoprotection.lt_type_support IS 'Clé primaire du domaine de valeur lt_type_support';

INSERT INTO m_videoprotection.lt_type_support(
            code, valeur, definition)
    VALUES
  ('00','NR','Non renseigné'),
  ('10','BAT','Bâtiment'),
  ('11','BATANGL','Angle de bâtiment'),
  ('12','BATFAC','Façade de bâtiment'),
  ('20','POT','Poteau'),
  ('21','MATECL','Mât d''éclairage, candélabre'),
  ('30','MUR','Mur'),
  ('99','AUT','Autre');                                
--('ZZ','Non concerné');



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# Séquence sur TABLE geo_video_camera_idcam_seq ###############################################

-- SEQUENCE: m_videoprotection.geo_video_camera_idcam_seq

-- DROP SEQUENCE m_videoprotection.geo_video_camera_idcam_seq;

CREATE SEQUENCE m_videoprotection.geo_video_camera_idcam_seq
    INCREMENT 1
    START 530
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;

  

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  FONCTION                                                                    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# FONCTION ft_m_corbeille_delete ###############################################

-- FUNCTION: m_videoprotection.ft_m_corbeille_delete()

-- DROP FUNCTION IF EXISTS m_videoprotection.ft_m_corbeille_delete();
CREATE OR REPLACE FUNCTION m_videoprotection.ft_m_corbeille_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

BEGIN

-- l'opération de suppression d'un objet au dbstatut actif le rend inactif
IF (OLD.dbstatut = '10') THEN
UPDATE m_videoprotection.geo_video_camera
SET dbstatut = '11'
WHERE m_videoprotection.geo_video_camera.id_cam = OLD.id_cam; 
 RETURN NEW;
 
ELSE

-- j'autorise la suppression réelle (on considère que c'est un choix et que ça doit permettre de supprimer une erreur pour l'utilisateur)

RETURN OLD;
END IF;



END;
$BODY$;


ALTER FUNCTION m_videoprotection.ft_m_corbeille_delete() OWNER TO create_sig;

GRANT EXECUTE ON FUNCTION m_videoprotection.ft_m_corbeille_delete() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_videoprotection.ft_m_corbeille_delete() TO create_sig;


COMMENT ON FUNCTION m_videoprotection.ft_m_corbeille_delete() IS 'Fonction générant le contrôle de la suppression : fausse suppression (corbeille) et suppression réelle';


-- ################################################################# FONCTION ft_m_format_ref_camera() ###############################################

-- FUNCTION: m_videoprotection.ft_m_format_ref_camera()

-- DROP FUNCTION IF EXISTS m_videoprotection.ft_m_format_ref_camera();
CREATE OR REPLACE FUNCTION m_videoprotection.ft_m_format_ref_camera()
    RETURNS trigger		
    LANGUAGE 'plpgsql'	
    COST 100			
    VOLATILE NOT LEAKPROOF		
AS $BODY$				

BEGIN

IF
	(TG_OP = 'INSERT') OR
	(TG_OP = 'UPDATE' AND OLD.ref_cam <> NEW.ref_cam)
THEN
	IF  
		(
		RTRIM(SUBSTRING(NEW.ref_cam,4,2), '0123456789') <> '' OR	-- les 2 derniers caractères ne sont pas des chiffres
		RTRIM(SUBSTRING(NEW.ref_cam,1,1), '0123456789') = '' OR		-- le 1er caractère n'est pas une lettre
		RTRIM(SUBSTRING(NEW.ref_cam,2,1), '0123456789') = '' OR		-- le 2ème caractère n'est pas une lettre
		RTRIM(SUBSTRING(NEW.ref_cam,3,1), '0123456789') = '' OR		-- le 3ème caractère est pas une lettre
		LENGTH(NEW.ref_cam) < 4										-- la longueur < 4 ne respecte pas le format attendu
		)
	THEN 
		RAISE EXCEPTION '<font color="#FF0000"><b>La référence de caméra est incorrecte. Elle se compose de 3 lettres suivies de 2 chiffres. Corrigez votre saisie et validez.</b></font><br><br>';
	ELSE
		IF
			LENGTH(NEW.ref_cam) < 5		-- car on n'a saisit qu'un seul chiffre
		THEN 
			NEW.ref_cam := UPPER (SUBSTRING(NEW.ref_cam,1,3)) || '0' || SUBSTRING(NEW.ref_cam,4,2);		-- Passage en majuscule + Ajout du 0 
		ELSE
			NEW.ref_cam := UPPER (SUBSTRING(NEW.ref_cam,1,3)) || SUBSTRING(NEW.ref_cam,4,2);			-- Passage en majuscule
		END IF;
	END IF;
	
	-- Contrôle d'unicité
	IF
		(SELECT COUNT(*) FROM m_videoprotection.geo_video_camera c WHERE c.ref_cam = NEW.ref_cam) > 0 
	THEN
		RAISE EXCEPTION '<font color="#FF0000"><b>La référence de caméra saisie existe déjà. Corrigez votre saisie et validez</b></font><br><br>';
	END IF;
	
END IF;

RETURN NEW;

END;
$BODY$;					-- fin du corps de la fonction

ALTER FUNCTION m_videoprotection.ft_m_format_ref_camera()
    OWNER TO create_sig;

GRANT EXECUTE ON FUNCTION m_videoprotection.ft_m_format_ref_camera() TO PUBLIC;

GRANT EXECUTE ON FUNCTION m_videoprotection.ft_m_format_ref_camera() TO create_sig;

COMMENT ON FUNCTION m_videoprotection.ft_m_format_ref_camera()
    IS 'Fonction contrôlant la saisie de la référence de caméra';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE geo_video_camera ###############################################

-- DROP TABLE m_videoprotection.geo_video_camera;
  
CREATE TABLE m_videoprotection.geo_video_camera
(
    id_cam bigint NOT NULL DEFAULT nextval('m_videoprotection.geo_video_camera_idcam_seq'::regclass),
    ref_cam character(5) COLLATE pg_catalog."default",
    old_ref_cam character varying(80) COLLATE pg_catalog."default",
    type_camera character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::bpchar,
    support character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::bpchar,
    doman character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::bpchar,
    gestion character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::bpchar,
    nomfic character varying(80) COLLATE pg_catalog."default",
    urlfic character varying(254) COLLATE pg_catalog."default",
    angle integer NOT NULL DEFAULT 0,
    insee character varying(5) COLLATE pg_catalog."default",
    commune character varying(80) COLLATE pg_catalog."default",
    quartier character varying(80) COLLATE pg_catalog."default",
    situa character varying(254) COLLATE pg_catalog."default",
    observ character varying(254) COLLATE pg_catalog."default",
    x_l93 numeric(9,2),
    y_l93 numeric(10,2),
    src_geom character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::bpchar,
    dbinsert timestamp without time zone NOT NULL DEFAULT now(),
    dbupdate timestamp without time zone,
    op_sai character varying(80),  
    op_maj character varying(80),  	
	dbetat character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::bpchar,
	dbstatut character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '10'::bpchar,
	geom geometry(Point,2154),
    CONSTRAINT geo_video_camera_pkey PRIMARY KEY (id_cam),

	CONSTRAINT lt_type_camera_pkey FOREIGN KEY (type_camera)
		REFERENCES m_videoprotection.lt_type_camera (code) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO action,
	
	CONSTRAINT lt_type_support_pkey FOREIGN KEY (support)
		REFERENCES m_videoprotection.lt_type_support (code) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO action,

	CONSTRAINT lt_domanialite_pkey FOREIGN KEY (doman)
		REFERENCES r_objet.lt_domanialite (code) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO action
		
		
		
		
		
		
)
WITH (
  OIDS=FALSE
);


COMMENT ON TABLE m_videoprotection.geo_video_camera IS 'Localisation des caméras de vidéo surveillance';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.id_cam IS 'Identifiant unique de caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.ref_cam IS 'Numéro de référence de la caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.old_ref_cam IS 'Ancien numéro de référence de la caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.type_camera IS 'Type de caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.support IS 'Type de support';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.doman IS 'Domanialité de la position de la caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.gestion IS 'Gestionnaire de la caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.nomfic IS 'Nom du fichier pdf contenant la fiche technique de la caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.urlfic IS 'URL vers la fiche technique';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.angle IS 'Angle pour la représentation de l''angle de vue des caméras fixes, exprimé en degré par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.insee IS 'Code INSEE';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.commune IS 'Nom de la commune';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.quartier IS 'Nom du quartier de Compiègne';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.situa IS 'Indication complémentaire de situation de la caméra';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.observ IS 'Observations';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.y_l93 IS 'Coordonnées Y en lambert 93';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.src_geom IS 'Référentiel géographique de saisie';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.dbetat IS 'Code permettant de décrire le niveau de réalisation de l''objet (r_objet.lt_etat_avancement)';
COMMENT ON COLUMN m_videoprotection.geo_video_camera.dbstatut IS 'Code permettant de décrire le statut de l''objet (r_objet.lt_statut)';



COMMENT ON CONSTRAINT geo_video_camera_pkey ON m_videoprotection.geo_video_camera IS 'Clé primaire de la table geo_video_camera';

-- Index: geo_video_camera_geom_idx
-- DROP INDEX IF EXISTS m_videoprotection.geo_video_camera_geom_idx;

CREATE INDEX IF NOT EXISTS geo_video_camera_geom_idx
    ON m_videoprotection.geo_video_camera USING gist (geom)
    TABLESPACE pg_default;
	



-- Trigger: t_t1_dbinsert

-- DROP TRIGGER IF EXISTS t_t1_dbinsert ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t1_dbinsert
    BEFORE INSERT
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_dbinsert();


-- Trigger: t_t2_dbupdate

-- DROP TRIGGER IF EXISTS t_t2_dbupdate ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t2_dbupdate
    BEFORE UPDATE 
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_dbupdate();


-- Trigger: t_t3_videoprotection_xy_l93

-- DROP TRIGGER IF EXISTS t_t3_videoprotection_xy_l93 ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t3_videoprotection_xy_l93
    BEFORE INSERT OR UPDATE OF geom
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_xy_l93();


-- Trigger: t_t4_videoprotection_nom_commune

-- DROP TRIGGER IF EXISTS t_t4_videoprotection_nom_commune ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t4_videoprotection_nom_commune
    BEFORE INSERT OR UPDATE OF geom
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_commune_c();


-- Trigger: t_t5_videoprotection_quartier

-- DROP TRIGGER IF EXISTS t_t5_videoprotection_quartier ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t5_videoprotection_quartier
    BEFORE INSERT OR UPDATE OF geom
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_quartier();



-- Trigger: t_t6_dbstatut_corbeille

-- DROP TRIGGER IF EXISTS t_t6_dbstatut_corbeille ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t6_dbstatut_corbeille
    BEFORE DELETE 
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE m_videoprotection.ft_m_corbeille_delete();
	
	
-- Trigger: t_t7_format_ref_camera

-- DROP TRIGGER IF EXISTS t_t7_format_ref_camera ON m_videoprotection.geo_video_camera;

CREATE TRIGGER t_t7_format_ref_camera

    BEFORE INSERT OR UPDATE
    ON m_videoprotection.geo_video_camera
    FOR EACH ROW
    EXECUTE PROCEDURE m_videoprotection.ft_m_format_ref_camera();
