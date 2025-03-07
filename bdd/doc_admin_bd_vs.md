![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des caméras de vidéosurveillance #

## Modèle conceptuel de données

![picto](mcd_videoprotection.png)


## Classes d'objets

L'ensemble des classes d'objets portant sur la vidéoprotection est stocké dans le schéma m_videoprotection.

### Classe d'objet patrimoniale

`geo_video_camera` : table de ponctuels représentant les caméras de vidéosurveillance

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|id_cam|Identifiant unique de caméra|bigint|nextval('m_videoprotection.geo_video_camera_idcam_seq'::regclass)|
|refcam|Numéro de référence de la caméra|character(5)| |
|old_ref_cam|Ancien numéro de référence de la caméra|character varying(80)| |
|type_camera|Type de caméra|character varying(2)| |
|support|Type de support|character varying(2)| |
|doman|Domanialité de la position de la caméra|character varying(2)| |
|gestion|Gestionnaire de la caméra|character varying(2)| |
|nomfic|Nom du fichier pdf contenant la fiche technique de la caméra|character varying(80) |
|urlfic|URL vers la fiche technique|character varying(254)| |
|angle|Angle pour la représentation de l'angle de vue des caméras fixes, exprimé en degré par rapport à l'horizontale, dans le sens trigonométrique|integer| |
|insee|Code INSEE|character varying(5)| |
|commune|Nom de la commune|character varying(80)| |
|quartier|Nom du quartier de Compiègne|character varying(80)| |
|situa|Indication complémentaire de situation de la caméra|character varying(254)| |
|observ|Observations|character varying(254)| |
|x_l93|Coordonnées X en lambert 93|numeric |
|y_l93|Coordonnées Y en lambert 93|numeric |
|src_geom|Référentiel géographique de saisie|character varying(2)| |
|dbinsert|Horodatage de l'intégration en base de l'objet|timestamp without time zone |
|dbupdate|Horodatage de la mise à jour en base de l'objet|timestamp without time zone| |
|op_sai|Opérateur de saisie de l'objet|character varying(80)| |
|op_maj|Opérateur de la dernière mise à jour de l'objet|character varying(80)| |
|dbetat|Code permettant de décrire le niveau de réalisation de l'objet (r_objet.lt_etat_avancement)|character varying(2)| |
|dbstatut|Code permettant de décrire le statut de l'objet (r_objet.lt_statut)|character varying(2)| |
|geom|Géométrie ponctuelle de l'objet|USER-DEFINED| |



