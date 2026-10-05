# ProjetDB_TRA_PAMBOU
" Projet en bases de données ING1 "

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







| N° | Signification de la donnée              | Type              |         Taille |
| -: | --------------------------------------- | ----------------- | -------------: |
|  1 | Identifiant de la chaîne                | Numérique entier  |     5 chiffres |
|  2 | Nom de la chaîne                        | Alphanumérique    |  50 caractères |
|  3 | Description de la chaîne                | Alphanumérique    | 255 caractères |
|  4 | Identifiant du programme                | Numérique entier  |     6 chiffres |
|  5 | Titre du programme                      | Alphanumérique    | 100 caractères |
|  6 | Description du programme                | Alphanumérique    | 500 caractères |
|  7 | Durée du programme                      | Numérique entier  |     4 chiffres |
|  8 | Année de production du programme        | Numérique entier  |     4 chiffres |
|  9 | Identifiant de la catégorie             | Numérique entier  |     4 chiffres |
| 10 | Nom de la catégorie                     | Alphanumérique    |  50 caractères |
| 11 | Identifiant du producteur               | Numérique entier  |     6 chiffres |
| 12 | Nom du producteur                       | Alphanumérique    | 100 caractères |
| 13 | Prénom du producteur                    | Alphabétique      |  50 caractères |
| 14 | Identifiant du présentateur/intervenant | Numérique entier  |     6 chiffres |
| 15 | Nom du présentateur/intervenant         | Alphanumérique    |  50 caractères |
| 16 | Prénom du présentateur/intervenant      | Alphabétique      |  50 caractères |
| 17 | Fonction du présentateur/intervenant    | Alphanumérique    |  50 caractères |
| 18 | Identifiant du créneau de diffusion     | Numérique entier  |     7 chiffres |
| 19 | Date de diffusion                       | Date              |  10 caractères |
| 20 | Heure de début de diffusion             | Heure             |   5 caractères |
| 21 | Heure de fin de diffusion               | Heure             |   5 caractères |
| 22 | Jour de la semaine de diffusion         | Alphanumérique    |  10 caractères |
| 23 | Identifiant de l’émission               | Numérique entier  |     6 chiffres |
| 24 | Nom de l’émission                       | Alphanumérique    | 100 caractères |
| 25 | Identifiant de l’audience               | Numérique entier  |     8 chiffres |
| 26 | Nombre de téléspectateurs               | Numérique entier  |    10 chiffres |
| 27 | Part d’audience                         | Numérique décimal |     5 chiffres |
| 28 | Identifiant du mode de diffusion        | Numérique entier  |     4 chiffres |
| 29 | Nom du mode de diffusion                | Alphanumérique    |  50 caractères |
| 30 | Type de contenu audiovisuel             | Alphanumérique    |  50 caractères |

