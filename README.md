# Projet MERISE — Télédiffusion audiovisuelle



## 1. Prompt final utilisé



Tu travailles dans le domaine de la télédiffusion audiovisuelle.

Ton entreprise a comme activité de diffuser des programmes de télévision auprès du public, en assurant la programmation, la gestion des contenus audiovisuels, des chaînes, des créneaux de diffusion et des différentes modalités de distribution des programmes.

C’est une entreprise du secteur audiovisuel comme TF1, France Télévisions, M6 ou Canal+.

Les données ont été collectées à partir des informations concernant les chaînes de télévision, les programmes diffusés, les émissions, les contenus audiovisuels, les horaires et créneaux de diffusion, les catégories de programmes, les présentateurs et intervenants, les producteurs, les audiences et les supports ou modes de diffusion.

Inspire-toi des sites web officiels et des informations publiques suivants : TF1, France Télévisions, M6 et Canal+.

Ton entreprise veut appliquer MERISE pour concevoir un système d’information.

Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet. Tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et de développement de la base de données.

D’abord, établis les règles de gestion des données de ton entreprise, sous la forme d’une liste à puces.

Les règles de gestion doivent correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information. Elles ne doivent donc pas contenir de notions techniques de modélisation telles que les clés primaires, les clés étrangères, les tables ou les relations.

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau :
- signification de la donnée ;
- type ;
- taille en nombre de caractères ou de chiffres.

Il doit y avoir entre 25 et 35 données.

Le dictionnaire doit fournir des informations supplémentaires sur chaque donnée, notamment son type et sa taille, mais sans a priori sur la manière dont les données seront modélisées ensuite.

Fournis donc :
1. les règles de gestion ;
2. le dictionnaire de données brutes.













## 2. Règles métier


### Gestion des chaînes et des programmes

- L'entreprise gère plusieurs chaînes de télévision.
- Chaque chaîne possède un nom et une description.
- Une chaîne peut diffuser plusieurs programmes.
- Chaque programme possède un titre, une description, une durée en minutes et une année de production.
- Chaque programme appartient à une seule catégorie.
- Une catégorie peut regrouper plusieurs programmes.
- Les catégories comprennent notamment le sport, l'information, le divertissement, les documentaires et les fictions.
- Un programme représente un contenu éditorial pouvant être diffusé, comme un film, un documentaire, un match ou un épisode d'émission.

### Gestion des émissions et des épisodes

- Une émission est un programme récurrent qui peut comporter plusieurs épisodes.
- Chaque émission possède un nom.
- Une émission peut comporter plusieurs épisodes.
- Chaque épisode appartient obligatoirement à une seule émission.
- Chaque épisode possède un numéro unique au sein de son émission.
- Deux émissions différentes peuvent avoir des épisodes portant le même numéro.
- Chaque épisode correspond à un seul programme pouvant être diffusé.
- Un programme peut correspondre à un épisode d'émission ou être indépendant de toute émission.

### Gestion des diffusions et des horaires

- Un même programme peut être diffusé plusieurs fois.
- Chaque diffusion concerne un seul programme et une seule chaîne.
- Chaque diffusion possède une date et une heure de début ainsi qu'une date et une heure de fin.
- Une diffusion peut commencer un jour et se terminer le lendemain.
- L'heure et la date de fin d'une diffusion doivent être postérieures à son début.
- Sur une même chaîne, deux diffusions ne peuvent pas avoir des créneaux horaires qui se chevauchent.
- Plusieurs chaînes peuvent diffuser des programmes simultanément.
- Les dates et horaires permettent à l'entreprise de préparer et de consulter sa grille de programmation.

### Gestion des producteurs et des intervenants

- Un programme peut être produit par un ou plusieurs producteurs.
- Un producteur peut participer à la production de plusieurs programmes.
- Chaque producteur possède un nom et un prénom.
- Une émission peut faire intervenir plusieurs présentateurs ou intervenants.
- Un présentateur ou intervenant peut participer à plusieurs émissions.
- Chaque présentateur ou intervenant possède un nom, un prénom et une fonction.

### Gestion des contenus audiovisuels

- L'entreprise conserve les informations relatives aux contenus audiovisuels qu'elle utilise.
- Chaque contenu audiovisuel possède un titre, un type et une durée.
- Les contenus peuvent correspondre à des reportages, des vidéos, des interviews ou des extraits.
- Un programme peut utiliser plusieurs contenus audiovisuels.
- Un même contenu audiovisuel peut être utilisé dans plusieurs programmes.
- Un contenu audiovisuel peut être créé à partir d'un autre contenu existant, par exemple un extrait réalisé à partir d'une vidéo complète.
- Un contenu dérivé provient au maximum d'un seul contenu d'origine.
- Un contenu d'origine peut servir à créer plusieurs contenus dérivés.
- Un contenu audiovisuel ne peut pas être directement ou indirectement dérivé de lui-même.

### Gestion des modes de diffusion

- L'entreprise propose plusieurs modes de diffusion.
- Les programmes peuvent être distribués par la télévision, le streaming ou le replay.
- Un programme peut être disponible sur plusieurs modes de diffusion.
- Un même mode de diffusion peut être utilisé par plusieurs programmes.

### Gestion des audiences

- L'entreprise suit les audiences des programmes diffusés.
- Une diffusion peut disposer d'une mesure d'audience après sa réalisation.
- Chaque mesure d'audience concerne une seule diffusion.
- Une diffusion possède au maximum une mesure d'audience globale.
- L'audience comprend le nombre de téléspectateurs et la part d'audience.
- La part d'audience est exprimée en pourcentage, entre 0 et 100.
- Le nombre de téléspectateurs ne peut pas être négatif.








## 3. Dictionnaire de données brutes

Ce dictionnaire présente les données utilisées par notre
entreprise de télédiffusion audiovisuelle, ainsi que leur
type et leur taille.

| N° | Signification de la donnée | Type | Taille |
|---|---|---|---|
| 1 | Identifiant de la chaîne | INT | 5 chiffres |
| 2 | Nom de la chaîne | VARCHAR | 50 caractères |
| 3 | Description de la chaîne | VARCHAR | 255 caractères |
| 4 | Identifiant du programme | INT | 6 chiffres |
| 5 | Titre du programme | VARCHAR | 100 caractères |
| 6 | Description du programme | VARCHAR | 500 caractères |
| 7 | Durée du programme en minutes | INT | 4 chiffres |
| 8 | Année de production | CHAR | 4 caractères |
| 9 | Identifiant de la catégorie | INT | 4 chiffres |
| 10 | Nom de la catégorie | VARCHAR | 50 caractères |
| 11 | Identifiant du producteur | INT | 6 chiffres |
| 12 | Nom du producteur | VARCHAR | 100 caractères |
| 13 | Prénom du producteur | VARCHAR | 50 caractères |
| 14 | Identifiant du présentateur/intervenant | INT | 6 chiffres |
| 15 | Nom du présentateur/intervenant | VARCHAR | 50 caractères |
| 16 | Prénom du présentateur/intervenant | VARCHAR | 50 caractères |
| 17 | Fonction du présentateur/intervenant | VARCHAR | 50 caractères |
| 18 | Identifiant de la diffusion | INT | 7 chiffres |
| 19 | Date de début de diffusion | DATE | 10 caractères |
| 20 | Heure de début de diffusion | TIME | 8 caractères |
| 21 | Heure de fin de diffusion | TIME | 8 caractères |
| 22 | Identifiant de l'émission | INT | 6 chiffres |
| 23 | Nom de l'émission | VARCHAR | 100 caractères |
| 24 | Identifiant de l'audience | INT | 8 chiffres |
| 25 | Nombre de téléspectateurs | BIGINT | 10 chiffres |
| 26 | Part d'audience | DECIMAL | 5 chiffres dont 2 décimales |
| 27 | Identifiant du mode de diffusion | INT | 4 chiffres |
| 28 | Nom du mode de diffusion | VARCHAR | 50 caractères |
| 29 | Type de contenu audiovisuel | VARCHAR | 50 caractères |
| 30 | Identifiant du contenu audiovisuel | INT | 6 chiffres |
| 31 | Titre du contenu audiovisuel | VARCHAR | 100 caractères |
| 32 | Durée du contenu audiovisuel en minutes | INT | 4 chiffres |
| 33 | Numéro de l'épisode | INT | 4 chiffres |
| 34 | Date de fin de diffusion | DATE | 10 caractères |





