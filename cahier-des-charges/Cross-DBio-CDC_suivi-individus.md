
# Cahier des charges pour la solution de suivi et gestion d’individus

> *Projet européen Cross-DBio / Autrice : Cynthia Borot - Parc National de la Vanoise*

- [Cahier des charges pour la solution de suivi et gestion d’individus](#cahier-des-charges-pour-la-solution-de-suivi-et-gestion-dindividus)
  - [Contexte et besoin](#contexte-et-besoin)
  - [Objectifs](#objectifs)
  - [Architecture](#architecture)
    - [Le choix d'aller vers GeoNature](#le-choix-daller-vers-geonature)
    - [Organisation des développements](#organisation-des-développements)
      - [Module individus](#module-individus)
      - [Modifications dans le coeur](#modifications-dans-le-coeur)
        - [Occtax](#occtax)
        - [Synthese](#synthese)
        - [Common](#common)
  - [Données concernées par le projet](#données-concernées-par-le-projet)
    - [La capture](#la-capture)
    - [Les prélèvements d’échantillons](#les-prélèvements-déchantillons)
    - [Les individus](#les-individus)
    - [Les marquages](#les-marquages)
    - [Les émetteurs/balises](#les-émetteursbalises)
    - [Biométrie](#biométrie)
    - [Les résultats d'analyse d'échantillons effectués en laboratoire](#les-résultats-danalyse-déchantillons-effectués-en-laboratoire)
    - [Observations humaines d'individus-marqués](#observations-humaines-dindividus-marqués)
    - [Observation via un émetteur GPS](#observation-via-un-émetteur-gps)
    - [Observation via piège photo](#observation-via-piège-photo)
  - [Modèle de données relationnel](#modèle-de-données-relationnel)
    - [Individus](#individus)
    - [Interactions entre individus](#interactions-entre-individus)
    - [Echantillons](#echantillons)
      - [Analyse des échantillons](#analyse-des-échantillons)
    - [Captures et équipement d'individus](#captures-et-équipement-dindividus)
    - [Bibliothèque de matériel](#bibliothèque-de-matériel)
    - [Types de sujet d’observation](#types-de-sujet-dobservation)
    - [Modèle de données complet](#modèle-de-données-complet)
  - [Mise en relation avec le besoin initial](#mise-en-relation-avec-le-besoin-initial)
    - [Données de capture](#données-de-capture)
    - [Données de prélèvements d’échantillons](#données-de-prélèvements-déchantillons)
    - [Données sur les individus](#données-sur-les-individus)
    - [Données de marquages](#données-de-marquages)
    - [Données sur les émetteurs/balises](#données-sur-les-émetteursbalises)
    - [Données de biométrie](#données-de-biométrie)
    - [Données sur les résultats d'analyses d'échantillons effectuées en laboratoire](#données-sur-les-résultats-danalyses-déchantillons-effectuées-en-laboratoire)
    - [Données d'observations humaines d'individus marqués](#données-dobservations-humaines-dindividus-marqués)
    - [Données d'observations via émetteur type GPS](#données-dobservations-via-émetteur-type-gps)
    - [Données d'observation via piège photo](#données-dobservation-via-piège-photo)

## Contexte et besoin

Le Parc national de la Vanoise (PNV) et le Parc national du Grand Paradis (PNGP) partagent un patrimoine naturel exceptionnel, avec des milieux alpins similaires et des espèces emblématiques communes. Les populations animales, notamment le bouquetin des Alpes, se déplacent ponctuellement entre les deux territoires, ignorant les frontières administratives. Cette continuité écologique nécessite une approche transfrontalière de la gestion et du suivi de la biodiversité.

Les deux parcs ont développé, au fil des années, des protocoles de suivi rigoureux qui ont généré une masse considérable de données : plus de 1500 bouquetins capturés et marqués, des dizaines de milliers de données GPS issues du suivi télémétrique de différentes espèces (bouquetins, gypaètes barbus, aigles royaux, tétras-lyres), et une quantité croissante d'images issues des pièges photographiques. Ces données, d'une valeur scientifique inestimable, sont actuellement stockées dans des formats et sur des supports variés, rendant leur exploitation complexe et limitée.

De plus, l’avancée dans les technologies de deep learning ouvre des perspectives prometteuses pour le traitement et la valorisation des données issues de piège photo. Cependant, leur exploitation nécessite une restructuration préalable des données actuelles sous forme de base de données relationnelles selon des standards communs.

Cette harmonisation permettra non seulement d'optimiser l'exploitation des données existantes, mais aussi de faciliter le partage d'informations, via des outils simples d’usage et standardisés, entre les deux parcs puis avec la communauté scientifique.

## Objectifs

Cette application vise à :

- Rationnaliser la récolte des données de suivi des individus marqués : suivi dynamique de population, veille sanitaire, données issues après post-traitement de pièges photo …
- Centraliser ces données
- Faciliter la réalisation de bilans et l’aide à la décision : optimiser le suivi en permettant aux agents une interrogation des données existantes (repérage des sites préférentiels, connaissance de la date des dernières observations)
- Permettre, via des exports et/ou des interrogations directes à la base de données, de mieux valoriser ces données sur des cartographies faciles à réaliser et adaptées aux différents besoins (animations scolaires, partenaires)
- Faciliter la récupération des données pour les futures analyses et travaux de recherche (CMR, réseaux sociaux, analyse de reproduction, analyse spatiale, taille des groupes etc.) avec nos partenaires et futurs collaborateurs
- Proposer une consultation grand public des déplacements des individus

Elle remplacera au parc national de la Vanoise :

- Le tableur « BDD bouquetins »
- La base de données « Bouquetins marqués »
- Le portail de gestion et de visualisation des données GPS « GPS 3 vallées » (plus fonctionnel).

## Architecture

### Le choix d'aller vers GeoNature

GeoNature est actuellement le coeur du sytème d'information du parc national de la Vanoise.

Les observations occasionelles d'animaux marqués, donc d'individus, sont actuellement insérées dans la synthèse mais avec une perte d'information occasionnée par le fait que GeoNature ne puisse pas accueillir tous les éléments de l'observations.

Au regard du besoin du PNV, de son envie de faire bénéficier à d'uatres du développement de nouvelles fonctionnalités et de son souhait de contribuer plus fortement au projet de Geonature, le choix de contribuer au projet de GeoNature est une évidence.

Après divers échanges avec le Parc national des Cevennes et le Parc national des Ecrins, notre souhait est conforté par leur validation à nous appuyer sur cet écosystème pour développer les fonctionnalités dont nous avons besoin. Cela implique :

- d'élargir les réflexions pour des fonctionnalités servant l'ensemble de la communauté
- de respecter les méthodes de travail du projet
- de respecter les choix techniques

Les développements à venir s'appuieront donc sur le socle de Geonature, ainsi les technologies utilisées seront donc celles de la dernière release :

- PostgreSQL / PostGIS
- Python 3 et dépendances Python nécessaires à l’application
- Flask (framework web Python)
- Apache
- Angular 15, Angular CLI, NodeJS
- Librairies javascript (Leaflet, ChartJS)
- Librairies CSS (Bootstrap, Material Design)

### Organisation des développements

Pendant la réunion de travail du 29/01/2026 avec les principaux mainteneurs de GeoNature (Jacques Fize, Amandine Sahl, Camillle Monchicourt, Théo Lechemia), nous avons longement discuté sur ce qui pouvait être intégré au coeur de GeoNature ou développé dans un module à part. Voici donc dans les paragraphes suivants, l'arbitrage qui a été fait.

#### Module individus

Un nouveau module appelé `gn_individual` sera développé afin d'acueillir et gérer toutes les données spécifiques aux individus (hors observations occasionelles) :

- La gestion des individus (CRUD),
- Les CMR avec les notions de :
  - captures
  - équipement d'individus (marquages + balises),
  - biométrie et observations sur l'état physiologiques
  - les prélèvements d'échantillons
- La gestion des analyses faites en laboratoire (CRUD)
- La gestion du matériel de suivi

Ce choix de réaliser l'ensemble des développements dans un module à part permet :

- De limiter l'impact sur le coeur et ainsi aussi la complexité des développement pour une équipe "junior" sur Geonature
- De ne pas bloquer l'éuipe de dev par des discussions et validations régulières de la part des mainteneurs. L'équipe aura donc plus d'autonomie dans ses développements tant dans le contenu que dans la plannification.

Il est convenu que dans un 1er temps certaines tables soient en doublons avec celles nouvellement créés dans le monitoring mais le travail de fusion sera porté par la suite.

Le Parc national de la Vanoise souhaitant que les fonctionnalités soit le plus transversales possible, s'engage à régulièrement travailler avec les mainteneurs pour que le module puisse répondre aux besoins d'autres structures.

#### Modifications dans le coeur

##### Occtax

Ces modifications seront relativements mineures si ce n'est, côté frontend, d'intégrer la possibilité de sélectionner un individus dans le dénombrement.

Nous aurons donc comme modifications à apporter :

- L'intégration de la notion d'individus au niveau du dénombrement. Cette modification demandera une réelle réflexion sur le frontend pour l'accès à cette fonctionnalité de façon fluide (UX).
- La possibilité de rattacher un échantillon à une occurence
- Ajout des notions d'interaction entre dénombrements

##### Synthese

Prise en compte des individus

##### Common

Gestion des échantillons en collaboration avec le projet du CBNA.

## Données concernées par le projet

Les données relatives aux individus devront être centralisées dans une base de données relationnelle, permettant de stocker toutes les données listées ci-après.

### La capture

- Nom de/des personnes ayant capturé
- Géolocalisation
- Lieu-dit
- Date de capture
- Type de capture
- Température
- Poids
- Rythme cardiaque
- Echographie
- Anesthésie / antidote :
  - Nombre de tests injection (=nb tirs)
  - Distance
  - Heure injection anesthésiant
  - Localisation injection
  - Produit anesthésiant
  - Posologie
  - Délais : Type de délais (perte posture, coucher, sommeil, maîtrise, réaction capture, relevé tête, déplacement) + unité + valeur
  - Heure injection antidote
  - Produit antidote
  - Observations

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données de capture](#données-de-capture)

### Les prélèvements d’échantillons

Les prélèvements sont réalisés lors de capture ou lors d’une observation d'indices de présence.

- Type de prélèvement (nomenclature : sang, carcasse, selles, urines, plumes, poils …)
- Date de prélèvement
- Identifiant

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données de prélèvements d’échantillons](#données-de-prélèvements-déchantillons)

### Les individus

La notion d'individus ne concerne que la faune. Ces données sont immuables dans le temps.

- Nom
- Identifiant unique
- Espèce
- Année de naissance
- Sexe (peut être optionnel selon l’espèce)
- Population / sous-population

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données sur les individus](#données-sur-les-individus)

### Les marquages

Les marquages sont réalisés sur l’animal lors des captures / recaptures. Un individu peut posséder plusieurs marquages

- Type de marquage : Collier, boucles, peinture, encoches …
- Caractéristiques du marquage (nomenclature : couleur, lettre)
- Localisation du marquage sur l’animal : oreille droite, oreille gauche, cou, carcasse, aile droite …
- Remarques

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données de marquages](#données-de-marquages)
  
### Les émetteurs/balises

Il est question des émetteurs installés sur l'animal. Ces données n'étant pas encore traitées au sein du PNV, cette liste de champs provient de réflexions avec le PNGP.

- Type d’émetteur : balise GPS, collier GPS, collier VHF …
- Informations techniques : (Marque, modèle, batterie …)
- Date de pose
- Géolocalisation lors de la pose
- Date de retrait
- Géolocalisation lors du retrait
- Référentiel géographique

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données sur les émetteurs/balises](#données-sur-les-émetteursbalises)
  
### Biométrie

Cela concerne les données de biométrie réalisées lors des captures et recaptures.

- Date des mesures
- Mesures :
  - Localisation de la mesure sur l’animal (nomenclature)
  - Mesure
  - Unité de mesure (nomenclature)

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données de biométrie](#données-de-biométrie)

### Les résultats d'analyse d'échantillons effectués en laboratoire

- Type d’analyse (nomenclature : sérologie, test gestation, génétique, coprologie, autopsie …)
- Date de réception au laboratoire
- Nom du laboratoire (nomenclature)
- Référence de dossier transmis par le laboratoire
- Mode de conservation de l’échantillon ou du cadavre entier (nomenclature)
- Commentaires

La liste suivante pourra évoluer dans le temps.

Sérologie :

- Virus recherchés :
  - Nom du virus (nomenclature)
  - Résultat
  
Tests de gestation :

- Type de dosage (nomenclature)
- Valeurs

Génétique :

- Données relatives à l’empreinte génétique
- Informations de filiation

Autopsie :

- Date mort présumée
- Etat cadavre (nomenclature)
- Etat physiologique (doublon avec observation visuelles ?)
- Statut reproducteur
- Synthèse lésionnelle + harmonisée
- Affection / virus / maladies :
  - Type
  - Résultat
- Causes mort (+ respi cause mort)
- Evolutions terminales
- Découvertes
- Matrices bact, Nb de matrices bact
- Bactério P
- Bactéries aéro 1 à 7, bactéries anaéréo 1 et 2
- Parasito directe
- Coproscopie
- VIRP / Myco/ Autre

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données sur les résultats d'analyse d'échantillons effectuées en laboratoire](#données-sur-les-résultats-danalyse-déchantillons-effectuées-en-laboratoire)

### Observations humaines d'individus-marqués

- Géolocalisation
- Identifiant observateur (identifiant Geonature)
- Etat physiologique
- Interaction entre individus
  - Suitée
  - Identifiants d’autres individus marqués
  - Nombre d’individus du groupe observé (dont les marqués)
    - Sexe
    - Classe d’âge
    - Nombre
  - Caractérisation de l’interaction entre 2 individus
- Autres observations :
  - Type observation (dyspnee, jetage, kerato, toux …)
  - Valeur (nomenclature)

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données d'observations humaines d'individus marqués]((#données-dobservations-humaines-dindividus-marqués))

### Observation via un émetteur GPS

- Identifiant de l'émetteur ou de la balise
- Individu
- Géolocalisation (point)
- Date + heure
- Température contre l'animal
- Autres informations dépendantes des émetteurs

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données d'observations via émetteur](#données-dobservations-via-émetteur)

### Observation via piège photo

- Identifiant du piège photo
- Espèce
- Dénombrement
- Géolocalisation
- Date + heure
- Méthode de détermination (humain ou algorithme)
- Autres informations d'observation

Pour comprendre comment ont été implémentés ces champs en BDD, cf le tableau de correspondance suivant : [Données d'observation via piège photo](#données-dobservation-via-piège-photo)

## Modèle de données relationnel

Dans la présentation du modèle de données ci-après, nous nous efforçons d'expliquer la généricité des choix opérés.

### Individus

Depuis la version 2.16.0 du cœur de geonature et de la version 1.1.0 du module `gn_module_monitoring`, la notion d’individu est rajoutée pour les protocoles de suivi avec l’ajout des tables `t_base_individuals` et `t_marking_events` (issue [#213](https://github.com/PnX-SI/gn_module_monitoring/issues/213)).

La modification du modèle de données proposée doit permettre d’associer un ou plusieurs individus à une observation occasionnelle.

Ainsi pour la faune, le dénombrement rattaché à l'occurence (au taxon) pourra porté sur un ou plusieurs individus de l'espèce concernée : nous pouvons ainsi ajouter un champ `id_individual` à la table `pr_occtax.cor_couting_occtax` qui fera référence à la table des individus. Cette modification sera à répercuter dans la synthèse `gn_synthese.synthese`.

<!-- 
Rajouter :
Détail des champs 
-->

*Schéma de liaison entre les tables t_individuals et cor_counting_occtax* :

![Schéma cor_counting_occtax / t_individuals](./images/gestion_individus.png)

### Interactions entre individus

Pour le suivi des populations, la notion d'interaction entre individus peut-être une niche d'informations. Dans notre contexte il s'agirait de qualifier l'interaction, lors d'une observation entre 2 individus de même espèce ou nom.

L'interaction peut aussi, par exemple, être intéressante à relever entre un invertébré et son hôte.

La notion d'interaction entre individus étant générique nous créons donc une table permettant la qualification d'une interaction entre 2 entrées de la table `cor_counting_occtax`.

<!-- 
Rajouter :
Détail des champs 
-->

*Shéma de liaison entre les tables t_interaction_occtax et cor_counting_occtax* :

![Schéma t_interaction_occtax](./images/interaction.png)

### Echantillons

Des échantillons peuvent être collectés sur le terrain dans différents contextes :

- Lors de la capture d'un individu (CMR), la prise d'échantillons est faite sous forme de prise de sang par exemple
- Lors de l'observation d'indices de présence sur le terrain, des échantillons peuvent être de même prélevés afin d'être analysés en laboratoire (génétique).
- Lors d'un relevé botanique et/ou entomologique, des échantillons peuvent être récoltés afin de réaliser la détermination des espèces au microscope.

Notre modèle doit satisfaire tout ces cas d'usage. A la lecture du travail porté par le CBNA (issue [#3603](https://github.com/PnX-SI/GeoNature/issues/3603)), nous repartirons de leurs réflexions pour implémenter notre besoin. Ce modèle permet d’associer un échantillon `gn_common.t_collection_sample` à tout type d'objet via les champs `id_table_location` et `uuid_attached_row`.

*Extrait du cahier des charges 'Relevés floristiques et phytosociologiques' du CBNA'* :

![Schéma t_samples](./images/cdc_cbna_echantillons_mcd.png)
  
Nous renommerons par contre la table `t_collection_sample` en `t_samples` car son usage se fera au dela de la notion de collections.

<!-- 
Rajouter :
Détail des champs 
-->

*Shéma de la table t_samples* :

![Schéma t_samples](./images/echantillons.png)

#### Analyse des échantillons

Aujourd'hui, au Parc national de la Vanoise, les résultats d'analyses sont, pour la plus part, compilés dans un fichier xsl. Dans d'autres structures, ces fiches sont très souvant classées sous forme papier et/ou numérisées en format pdf.

Le projet est de faciliter l'exploitation des données en enregistrant ces fiches dans une table unique dont la plupart des champs seront configurables via un champ de type JSON `additional_data` de la table `gn_commons.t_sample_analysis`.

<!-- 
Rajouter :
Détail des champs 
-->

*Shémas de liaison entre les tables t_samples et t_samples_analysis* :

![Schéma t_sample_analysis](./images/analyses_des_echantillons.png) -->

### Captures et équipement d'individus

La notion de capture ne concerne que les individus. Nous souhaitons dissocier les informations liées directement à la capture, des informations concernant la mise en place d'équipement sur les individus.

Depuis la version 2.16.0 de GeoNature, il existe une table `gn_monitoring.t_marking_events` qui permet le stockage d’évènements de marquage pour le monitoring 

*Ancien shémas de liaison entre les tables t_individuals et t_marking_events* :

![Ancien schéma de t_individuals](./images/t_individual_old.png)

Nous partirons sur un nouveau modèle de données pour la gestion des captures car la table `gn_monitoring.t_marking_events` ne répond aux besoins fonctionnels suivant :

- de définir plusieurs marquages ou balises par individu. Nous passerons alors par les nouvelles tables `t_individual_deployments` et `bib_tracking_device`. Son modèle permet d'accuillir la nouvelle génération de collier GPS faisant office de marquage et de balise.
- d'associer plusieurs individus à un même évènement de capture. Nous passerons alors par la nouvelle table `t_captures`.
- d'associer plusieurs opérateurs à une capture. Nous réaliserons cela via la nouvelle table de correspondance `cor_role_captures`.

<!-- 
Rajouter :
Détail des champs 
-->

*Schéma des tables associées à un évènement de capture* :

![Schéma t_captures, t_individual_deployments et autres](./images/deploiements.png) -->

### Bibliothèque de matériel

La bibiothèque `gn_monitoring.bib_tracking_material` permet de recenser les différents matériels de suivi : pièges photos, colliers GPS ...

Cette table permet d'associer une balise lors de l'équipement d'un individu, ou bien de définir un piège photo spécifique ou une balise spécifique comme role pour un relevé.  

<!-- 
Rajouter :
Détail des champs 
-->

*Shéma de la table bib_tracking_device* :

![Schéma bib_tracking_device](./images/materiel.png)

### Types de sujet d’observation

Au regard de notre souhait de stocker toutes nos données d'observation dans GeoNature, nous devons avoir la possibliter d'enregistrée toutes les "observations" réalisées par des émetteurs type GPS ou par des capteurs de type piège photo.

Nous avons fait le choix avec l'équipe des mainteneurs de Geonature de ne pas toucher à la gestion des rôles de GeoNature. Nous créérons un unique rôle de type "machine" qui sera le rôle associé aux relevés de ce type.

Afin de pouvoir identifier quel est le capteur ou émetteur qui a "produit" la donnée, nous ajouterons un champ additionnel "id_tracking_device" dans le champ `additional_fields` de la table `pr_occtax.t_releves_occtax`. Parallèlement, ces relevés seront associés à des jeux de données spécifiques.

*Shéma de la table t_releves_occtax* :

![Schéma t_releves_occtax](./images/releves_occtax.png)

<!-- 
Rajouter :
Détail des champs 
-->

### Modèle de données complet

Le modèle de données, ci-dessous, ne reprends pas l'ensemble du modèle de Géonature. Il ne présente que les nouvelles tables créées pour le projet (en orange) ainsi que les tables du modèle actuel qui leur sont liées (en vert) et sont nécessaires à la compréhension du modèle. Les champs créés dans des tables existantes sont surlignés en orange. Les tables en violet appartiennent à une autre BDD.

<!-- Mettre à jour -->

![Schéma complet](./images/mcd.png)

## Mise en relation avec le besoin initial

Via les tableaux de correspondance suivant, nous validons que l'ensemble des données (des champs) listées dans le paragraphe [Données concernées par le projet](#données-concernées-par-le-projet) trouvent leur emplacement dans le modèle de données proposé ci-dessus.

### Données de capture

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Nom de/des personnes ayant capturé | pr_occtax.t_releves_occtax | observers_txt | |
| Géolocalisation | gn_individual.t_captures | geom_local, geom_4326 | |
| Lieu-dit | gn_individual.t_captures | additional_data | |
| Date de capture | gn_individual.t_captures | date | |
| Type de capture | gn_individual.t_captures | id_nomenclature_capture_protocol | |
| Température | gn_individual.t_individual_deployments | additional_data | `{[...],"temperature": "000"}` |
| Poids | gn_individual.t_individual_deployments | additional_data | `{[...],"weight": "000"}` |
| Rythme cardiaque | gn_individual.t_individual_deployments | additional_data | `{[...],"heart_rate": "000"}` |
| Echographie | gn_individual.t_individual_deployments | additional_data | `{[...],"pregnant": "yes/no"}` |
| Anesthésie : Nombre de tirs | gn_individual.t_individual_deployments | comment | |
| Anesthésie : Distance tir | gn_individual.t_individual_deployments | comment | |
| Anesthésie injection : Heure, localisation, nom produit, posologie | gn_individual.t_individual_deployments | additional_data | `{[...],"anesthesia_injection":{"hour": "000","location": "xxx","product": "xxx","dosage": "xxx"}}` |
| Anesthésie réactions (x n): Type, unité, valeur | gn_individual.t_individual_deployments | additional_data | `{[...],"anesthesia_reaction":{"1":{"type": "xxx","delai": "000"},"2":{"type": "xxx","delai": "000"}}}` |
| Antidote : Heure injection, produit, posologie | gn_individual.t_individual_deployments | additional_data | `{[...],"antidote_injection":{"hour": "000","location": "xxx","product": "xxx","dosage": "xxx"}}` |
| Anesthésie : Observations | gn_individual.t_individual_deployments | comment | |

### Données de prélèvements d’échantillons

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Type de prélèvement | gn_common.t_samples | id_nomenclature_sample_type | |
| Date de prélèvement | pr_occtax_t_releves_occtax | date_min | |
| Identifiant | gn_common.t_samples | id_sample | |

### Données sur les individus

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Nom | gn_monitoring.t_individuals | individual_name | |
| Identifiant unique | gn_monitoring.t_individuals | id_individual | |
| Espèce | gn_monitoring.t_individuals | cd_nom | |
| Année de naissance | gn_monitoring.t_individuals | additional_data | `{[...],"birth_year": "000"}` |
| Sexe | gn_monitoring.t_individuals | id_nomenclature_sex | |
| Population / sous-population | gn_monitoring.t_individuals | additional_data | `{[...],"population": "xxx","subpopulation": "xxx"}` |

### Données de marquages

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Type de marquage | gn_individual.t_individual_deployments | id_nomenclature_deployment_type | Le marquage fait partie des équipements déployés sur l'individu |
| Caractéristiques du marquage | gn_individual.t_individual_deployments | marking_code | |
| Localisation du marquage sur l’animal | gn_individual.t_individual_deployments | id_nomenclature_deployment_location | |
| Remarques | gn_individual.t_individual_deployments | comment | |
  
### Données sur les émetteurs/balises

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Type d’émetteur | gn_individual.bib_tracking_device | id_nomenclature_device_type | Les émetteurs font parties du matériel de suivi des individus |
| Informations techniques : manufacturer, model, serial_number | gn_individual.bib_tracking_device | comment | |
| Date de pose | gn_individual.t_captures | date | Date de la capture associée au déploiement du matériel |
| Géolocalisation lors de la pose | gn_individual.t_captures | geom_local, geom_4326 | Géolocalisation de la capture associée au déploiement du matériel |
| Date de retrait | gn_individual.t_individual_deployments | removal_date |  |
| Géolocalisation du retrait | pr_occtax.t_releves_occtax | date_min | Géolocalisation de la dernière donnée |
  
### Données de biométrie

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Date des mesures | pr_occtax.t_releves_occtax | date_min |  |
| Mesures : Localisation sur l’animal, mesure, unité de mesure | gn_individual.t_individual_deployments | additional_data | `{[...],"measures":{"m1": {"value": "000","unit": "xxx"},"m2": {"value": "000","unit": "xxx"}, [...]}}` |

### Données sur les résultats d'analyses d'échantillons effectuées en laboratoire

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Type d’analyse | gn_individual.t_sample_analysis | id_nomenclature_analysis_type | |
| Date de réception au laboratoire | gn_individual.t_sample_analysis | labo_receipt_date | |
| Nom du laboratoire | gn_individual.t_sample_analysis.t_sample_analysis | id_nomenclature_labo_name | |
| Référence dues résultats transmis par le laboratoire | gn_individual.t_sample_analysis.t_sample_analysis | labo_analysis_ref | |
| Mode de conservation de l’échantillon | gn_common.t_samples | comment | |
| Remarques | gn_individual.t_sample_analysis | comment | |

Les résultats d'analyses à proprement parlé seront stockés dans le champ `additional_data` de la table `gn_individual.t_sample_analysis`.

Exemple de structure du champ pour une analyse de type **Sérologie** :

```json
{
  "searched_virus": {
    "1": {   
      "name": "xxx",
      "result": "xxx",
    },
    "2": {
      "name": "xxx",
      "result": "xxx",
    },
    [...]
  }
}
```

Exemple de structure du champ pour une analyse de type **Test gestationnel** :

```json
{
  "gestational_test": {
    "1": {   
      "dosage_type": "xxx",
      "value": "xxx",
    },
    "2": {
      "dosage_type": "xxx",
      "value": "xxx",
    },
    [...]
  }
}
```

Pour les analyses de type **Génétique**, nous n'avons pas d'exemple à proposer.

Exemple de structure du champ pour une analyse de type **Autopsie** :

```json
{
  "autopsy": {
    "presumed_death_date": "000",
    "corpse_condition": "xxx",
    "physilogical_state": "xxx",
    "reproductive_status": "xxx",
    "lesion_synthesis": "xxx",
    "affection_virus_disease": {
     "1": { "type": "xxx","result": "xxx"},
     [...]
    },
    "death_cause": "xxx",
    "terminal_evolutions": "xxx",
    [...]
  }
}
```

### Données d'observations humaines d'individus marqués

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Géolocalisation | pr_occtax.t_releves_occtax | geom_local, geom_4326 | |
| Identifiant observateur | pr_occtax.t_releves_occtax | observateur_txt | |
| Etat physiologique | pr_occtax.t_occurrences_occtax | id_nomenclature_bio_condition | |
| Femelle suitée | pr_occtax.t_interaction_occtax | ensemble des champs | |
| Identifiants d’autres individus marqués observés ensembles | pr_occtax.t_counting_occtax | id_individual | Les enregistrements de chaque individu feront référence au même id_occurence_occtax |
| Nombre d’individus du groupe observé (hors marqués) distingués par sexe, classe d’âge et nombre | pr_occtax.t_counting_occtax | id_nomenclature_life_stage, id_nomenclature_sex, id_nomenclature_type_count | Les enregistrements de chaque groupe feront référence au même id_occurence_occtax |
| Caractérisation de l’interaction entre 2 individus  | pr_occtax.t_interaction_occtax | ensemble des champs |  |
| Observations sanitaires : Type observation et valeur  | pr_occtax.t_counting_occtax | additional_fields | `{[...],"health_onservations":{"1":{"type": "xxx","value": "xxx"},"2":{"type": "xxx","value": "xxx"},[...]}}` |

### Données d'observations via émetteur type GPS

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Identifiant de l'émetteur ou de la balise | pr_occtax.t_releves_occtax | additional_fields | `{"id_tracking_device": "000"}` |
| Identifiant de l'émetteur ou de la balise | pr_occtax.cor_role_releves_occtax | id_role | Un role unique appelé "matériel" sera systématiquement associé à ces observations qui seront elles, associées à un jeu de données spécifique |
| Individu | pr_occtax.cor_counting_occtax | id_individual | |
| Géolocalisation (point) | pr_occtax.t_releves_occtax | geom_local, geom_4326 | |
| Date + heure | pr_occtax.t_releves_occtax | date_min, hour_min | |
| Température contre l'animal | pr_occtax.t_releves_occtax | comment | |
| Autres informations dépendantes des émetteurs | pr_occtax.t_releves_occtax | comment | |

### Données d'observation via piège photo

Les pièges photos ne remonteront pas seulement des informations sur les individus marqués mais sur toute espèce.

| Donnée initiale | Schéma / table | Champ | Explication |
| :---- | :---- | :---- | :---- |
| Identifiant du piège photo | pr_occtax.t_releves_occtax | additional_fields | `{"id_tracking_device": "000"}` |
| Espèce | pr_occtax.t_releves_occtax | cd_nom | |
| Individu | pr_occtax.cor_counting_occtax | id_individual | |
| Dénombrement | pr_occtax.cor_counting_occtax | tous les champs | |
| Géolocalisation | pr_occtax.t_releves_occtax | geom_local, geom_4326 | |
| Date + heure | pr_occtax.t_releves_occtax | date_min, hour_min | |
| Méthode de détermination (humain ou algorithme) | pr_occtax.t_occurences | id_nomenclature_determination_method | A renseigner différement si les photos ont été analysées par l'oeil humain ou via un algorithme |
| Autres informations d'observation | pr_occtax.t_releves_occtax | comment | |
