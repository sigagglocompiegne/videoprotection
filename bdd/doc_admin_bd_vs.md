![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des caméras de vidéosurveillance #

## Modèle conceptuel de données

![mcd](mcd_videoprotection.png)


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

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id_cam`
* Une clé étrangère existe sur la liste de valeurs `lt_domanialite`
* Une clé étrangère existe sur la liste de valeurs `lt_type_camera`
* Une clé étrangère existe sur la liste de valeurs `lt_type_support`

`geo_video_antenne` : table de ponctuels représentant la localisation des antennes liées aux caméras de vidéosurveillance

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|gid|Identifiant unique d'antenne|character(10)| |
|id_ant|Référence d'antenne|character(10)| |
|type|Type|character varying(50)| |
|support|Support|character varying(30)| |
|photo|Photo|character varying(254)| |
|insee|Code INSEE|character varying(5)| |
|commune|Nom de la commune|character varying(80)| |
|observ|Observations|character varying(254)| |
|x_l93|Coordonnées X en lambert 93|numeric |
|y_l93|Coordonnées Y en lambert 93|numeric |
|src_geom|Référentiel géographique de saisie|character varying(2)| |
|dbinsert|Horodatage de l'intégration en base de l'objet|timestamp without time zone |
|dbupdate|Horodatage de la mise à jour en base de l'objet|timestamp without time zone| |
|op_sai|Opérateur de saisie de l'objet|character varying(80)| |
|op_maj|Opérateur de la dernière mise à jour de l'objet|character varying(80)| |
|geom|Géométrie ponctuelle de l'objet|USER-DEFINED| |

Particularité(s) à noter : 
* Une clé primaire existe sur le champ `gid`

`geo_video_pro` : table de ponctuels représentant la localisation des points de raccordement optique liés à la mise en place du système de vidéosurveillance

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|id_pro|Identifiant unique de point de raccordement optique|character(10)| |
|photo|Photo|character varying(254)| |
|insee|Code INSEE|character varying(5)| |
|commune|Nom de la commune|character varying(80)| |
|observ|Observations|character varying(254)| |
|x_l93|Coordonnées X en lambert 93|numeric |
|y_l93|Coordonnées Y en lambert 93|numeric |
|src_geom|Référentiel géographique de saisie|character varying(2)| |
|dbinsert|Horodatage de l'intégration en base de l'objet|timestamp without time zone |
|dbupdate|Horodatage de la mise à jour en base de l'objet|timestamp without time zone| |
|op_sai|Opérateur de saisie de l'objet|character varying(80)| |
|op_maj|Opérateur de la dernière mise à jour de l'objet|character varying(80)| |
|geom|Géométrie ponctuelle de l'objet|USER-DEFINED| |

Particularité(s) à noter : aucune


## Liste de valeur

`lt_type_camera` : Liste permettant de décrire les différents types de caméra, définie dans le schéma m_videoprotection

|code | valeur | definition|
|:---|:---|:---| 
|code|Code de la liste énumérée relative au type de caméra de vidéosurveillance|character varying(2)| |
|valeur|Valeur de la liste énumérée relative au type de caméra de vidéosurveillance|character varying(254)| |
|valeur|Valeur littérale de la liste énumérée relative au type de caméra de vidéosurveillance|character varying(254)| |

Particularité(s) à noter :

    Une clé primaire existe sur le champ code  

Valeurs possibles : 
|code | valeur | definition|
|:---|:---|:---|
|00|NR|Non renseigné|
|01|DOM|Dôme|
|02|FIX|Fixe|
|03|FIX180|Fixe 180|
|04|MULTI|Multicapteur|
|99|AUT|Autre|

`lt_type_support` : Liste permettant de décrire les différents supports de caméra, définie dans le schéma m_videoprotection

|code | valeur | definition|
|:---|:---|:---| 
|code|Code de la liste énumérée relative au support de caméra de vidéosurveillance|character varying(2)| |
|valeur|Valeur de la liste énumérée relative au support de caméra de vidéosurveillance|character varying(254)| |
|valeur|Valeur littérale de la liste énumérée relative au support de caméra de vidéosurveillance|character varying(254)| |

Particularité(s) à noter :

    Une clé primaire existe sur le champ code  

Valeurs possibles : 
|code | valeur | definition|
|:---|:---|:---|
|00|NR|Non renseigné|
|10|BAT|Bâtiment|
|11|BATANGL|Angle de bâtiment|
|12|BATFAC|Façade de bâtiment|
|20|POT|Poteau|
|21|MATECL|Mât d'éclairage, candélabre|
|30|MUR|Mur|
|99|AUT|Autre|

`lt_etat_avancement` : Liste permettant de décrire les différents niveaux de réalisation, définie dans le schéma r_objet

|code | valeur |
|:---|:---|
|code|Code de la liste énumérée relative au niveau de réalisation|character varying(2)| |
|valeur|Valeur de la liste énumérée relative au niveau de réalisation|character varying(40)| |

Particularité(s) à noter :

    Une clé primaire existe sur le champ code  

Valeurs possibles : 
|code | valeur |
|:---|:---|
|00|Non renseigné|
|10|En projet|
|11|Non-retenu|
|20|Arrêté|
|30|En travaux|
|40|En service|
|90|Provisoire|
|ZZ|Non concerné|

`lt_domanialite` : Liste permettant de décrire les différentes situations de domanialité de la posittion de la caméra, définie dans le schéma r_objet

||
|:---|:---|:---| 
|code|Code de la liste énumérée relative à la domanialité de la position de caméra de vidéosurveillance|character varying(2)| |
|valeur|Valeur de la liste énumérée relative à la domanialité de la position de caméra de vidéosurveillance|character varying(254)| |
|valeur|Valeur littérale de la liste énumérée relative à la domanialité de la position de caméra de vidéosurveillance|character varying(254)| |

Particularité(s) à noter :

    Une clé primaire existe sur le champ code  

Valeurs possibles : 
||
|:---|:---|:---|
|00|NR|Non renseigné|
|01|PUB|Public|
|02|PRI|Privé|

`lt_gestion` : Liste permettant de décrire les différentes situations de gestionnaire de la caméra, définie dans le schéma m_reseau_sec

|code | valeur | definition|
|:---|:---|:---| 
|code|Code de la liste énumérée relative au gestionnaire de la caméra de vidéosurveillance|character varying(2)| |
|valeur|Valeur de la liste énumérée relative au gestionnaire de la caméra de vidéosurveillance|character varying(80)| |
|valeur|Valeur littérale de la liste énumérée relative au gestionnaire de la caméra de vidéosurveillance|character varying(254)| |

Particularité(s) à noter :

    Une clé primaire existe sur le champ code  

Valeurs possibles : 
|code | valeur | definition|
|:---|:---|:---|
|00|NR|Non renseigné|
|01|INT|Intercommunalité|
|02|COM|Commune|
|99|AUT|Autre|

`lt_src_geom` : Liste permettant de décrire les différents référeniels géographiques utilisés lors de la saisie/mise à jour des caméras, définie dans le schéma r_objet

|code | valeur |
|:---|:---|
|code|Code de la liste énumérée relative aux référentiels géographiques|character varying(2)| |
|valeur|Valeur de la liste énumérée relative aux référentiels géographiques|character varying(254)| |

Particularité(s) à noter :

    Une clé primaire existe sur le champ code  

Valeurs possibles : 
|code | valeur |
|:---|:---|
|00|Non renseigné|
|10|Cadastre|
|11|PCI vecteur|
|12|BD Parcellaire|
|13|RPCU|
|20|Ortho-images|
|21|Orthophotoplan IGN|
|22|Orthophotoplan partenaire|
|23|Orthophotoplan local|
|30|Filaire voirie|
|31|Route BDTopo|
|32|Route OSM|
|40|Cartes|
|41|Scn25|
|50|Lever|
|51|Plan topographique|
|52|PCRS|
|53|Trace GPS|
|54|Coordonnées X,Y|
|60|Géocodage|
|61|Base Adresse Locale|
|70|Plan masse|
|71|Plan masse vectoriel|
|72|Plan masse redessiné|
|80|Thématique|
|81|Document d'urbanisme|
|82|Occupation du sol|
|83|Thème BDTopo|
|99|Autre|

## Migration des données

Un traitement FME exécuté après la création de la structure en base, permet de réaliser la migration des données existantes: caméras, périmètres d'autorisation préfectorale, antennes,  points de raccordement optique:

R:\Projets\Metiers\2409RESS-ARC-Videoprotection\Insert_donnees_videoprotection_base_test.fmw

En raison de la présence de référence doublonnées, et afin de ne pas surcharger les dates de saisie des caméras, les triggers portant sur le contrôle de référence de caméra, ainsi que l'alimentation des dates d'insertion et de mise à jour des données caméras, sont désactivés en début de traitement et ré-activés en fin de traitement.

Dans le traitement FME: 

- l'attribut "dbstatut" est systématiquement initialisé à '10' (Actif). A charge pour l'utilisateur de supprimer ultérieurement lui-même les caméras qu'il souhaite.
  
- la référence actuelle est setée dans l'attribut old_ref_cam. La valeur setée dans l'attribut ref_cam tiend compte de la nouvelle nomenclature : 3 lettres + 2 chiffres


