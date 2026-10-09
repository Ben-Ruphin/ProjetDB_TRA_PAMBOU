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













## 2. Règles métier / règles de gestion


Dans le cadre de notre entreprise de télédiffusion audiovisuelle, nous avons identifié les règles de gestion suivantes :

- L'entreprise gère plusieurs chaînes de télévision.
- Chaque chaîne de télévision possède un nom et une description.
- Une chaîne de télévision peut diffuser plusieurs programmes.
- Chaque programme possède un titre, une description et une durée.
- Chaque programme appartient à une catégorie (sport, information, divertissement, documentaire, fiction, etc.).
- Une catégorie peut regrouper plusieurs programmes.
- Un même programme peut être diffusé plusieurs fois à des dates et horaires différents.
- Chaque diffusion d'un programme est programmée sur une chaîne de télévision.
- Chaque diffusion possède une date, une heure de début et une heure de fin.
- Chaque créneau de diffusion correspond à une période pendant laquelle un programme est diffusé.
- L'entreprise gère différentes émissions de télévision.
- Chaque émission possède un nom.
- Une émission peut être présentée par un ou plusieurs présentateurs.
- Un présentateur peut participer à plusieurs émissions.
- Chaque présentateur ou intervenant possède un nom, un prénom et une fonction.
- Un programme peut être réalisé par un ou plusieurs producteurs.
- Un producteur peut participer à la production de plusieurs programmes.
- Chaque producteur possède un nom et un prénom.
- L'entreprise conserve les informations relatives aux contenus audiovisuels.
- Chaque contenu audiovisuel possède un type (vidéo, reportage, documentaire, etc.).
- Les programmes peuvent être diffusés sur différents supports, comme la télévision, les plateformes de streaming ou les services de replay.
- Un programme peut être disponible sur plusieurs modes de diffusion.
- L'entreprise suit les audiences des programmes diffusés.
- Pour chaque diffusion, l'entreprise peut enregistrer le nombre de téléspectateurs.
- La part d'audience permet de mesurer le pourcentage de téléspectateurs ayant regardé un programme.
- L'entreprise conserve les informations concernant les chaînes, les programmes, les émissions, les producteurs, les présentateurs, les horaires et les audiences afin d'assurer le suivi de ses activités.









## 3. Dictionnaire de données


Ce dictionnaire présente les 30 données utilisées par notre
entreprise de télédiffusion audiovisuelle, avec leur type
et leur taille.

| N° | Signification de la donnée | Type | Taille |
|---|---|---|---|
| 1 | Identifiant de la chaîne | INT | 5 chiffres |
| 2 | Nom de la chaîne | VARCHAR | 50 caractères |
| 3 | Description de la chaîne | VARCHAR | 255 caractères |
| 4 | Identifiant du programme | INT | 6 chiffres |
| 5 | Titre du programme | VARCHAR | 100 caractères |
| 6 | Description du programme | VARCHAR | 500 caractères |
| 7 | Durée du programme (minutes) | INT | 4 chiffres |
| 8 | Année de production du programme | CHAR | 4 caractères |
| 9 | Identifiant de la catégorie | INT | 4 chiffres |
| 10 | Nom de la catégorie | VARCHAR | 50 caractères |
| 11 | Identifiant du producteur | INT | 6 chiffres |
| 12 | Nom du producteur | VARCHAR | 100 caractères |
| 13 | Prénom du producteur | VARCHAR | 50 caractères |
| 14 | Identifiant du présentateur/intervenant | INT | 6 chiffres |
| 15 | Nom du présentateur/intervenant | VARCHAR | 50 caractères |
| 16 | Prénom du présentateur/intervenant | VARCHAR | 50 caractères |
| 17 | Fonction du présentateur/intervenant | VARCHAR | 50 caractères |
| 18 | Identifiant du créneau de diffusion | INT | 7 chiffres |
| 19 | Date de diffusion | DATE | 10 caractères |
| 20 | Heure de début de diffusion | TIME | 8 caractères |
| 21 | Heure de fin de diffusion | TIME | 8 caractères |
| 22 | Jour de la semaine de diffusion | VARCHAR | 10 caractères |
| 23 | Identifiant de l'émission | INT | 6 chiffres |
| 24 | Nom de l'émission | VARCHAR | 100 caractères |
| 25 | Identifiant de l'audience | INT | 8 chiffres |
| 26 | Nombre de téléspectateurs | INT | 10 chiffres |
| 27 | Part d'audience | DECIMAL | 5 chiffres (dont 2 décimales) |
| 28 | Identifiant du mode de diffusion | INT | 4 chiffres |
| 29 | Nom du mode de diffusion | VARCHAR | 50 caractères |
| 30 | Type de contenu audiovisuel | VARCHAR | 50 caractères |




