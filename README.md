# Submission_Data_SQL_TO_Dimagi

BID-FAES SUBMISSION DATA API PROJECT ROADMAP

Introduction	3
Le projet	3
Présentation	3
Objectifs	3
Contraintes	4
Etapes importantes	4
Etape 1 – Etat de l’art et recueil des données nécessaires	4
Période de FORMATION pour la passation de Stephano ou autres taches Data :  50% disponibilité	5
Etape 2 – Implémentation des différentes parties	5
Etape 3 - Rapports automatiques (Moyen terme)	6
Etape 4 – Flagger les données dont la soumission est échouée (Moyen terme)	6


Introduction
Dans ce document, nous allons présenter la feuille de route du projet BID-FAES SUBMISSION DATA API. Ce document est un plan stratégique qui décrit les étapes à suivre pour atteindre les résultats escomptés et les objectifs visés du projet. Avant d’aller plus loin, nous allons faire une présentation suivie d’un rappel de l'objectif du projet.

Le projet
Présentation
Comme le nom du projet l’indique, BID-FAES SUBMISSION DATA API, il s'agit de mettre en place à l’intérieur de notre écosystème un système de soumission robuste facilitant grandement l’intégration de l’ensemble des données récupérées sur notre base de données BIDFAES sur le serveur de Commcare (Dimagi) afin que ces dernières soient exploitables par notre partenaire FAES. Ce qui revient à implémenter un processus permettant de s’assurer que les données ont subi un tri adéquat afin de ne partager que les données de qualité. 
Ainsi, les données deviennent correctes, utiles et exploitables par tout un chacun. Le processus utilise des routines technologiques qui vérifient l’exactitude, la signification et la sécurité des données qui sont entrées dans le système web. Les soumissions peuvent être mises en œuvre via des fonctionnalités automatisées d’un dictionnaire de données ou par l’inclusion d'un logiciel doté d’une logique de soumission. 

Ce projet trouve sa justification dans les raisons suivantes :
	Le besoin pour les partenaires d’avoir une même idée de l’évolution du projet
	Le besoin de transparence entre les différentes parties prenantes du projet
	Pour une meilleure sécurité et disponibilité des données collectées
Objectifs
L’objectif général du projet sera de mettre en place un système de soumission robuste facilitant grandement l’intégration de l’ensemble des données collectées sur notre application web BIDFAES sur Commcare (Dimagi) sur toute la durée du projet.

Contraintes
Comme toute implémentation, le projet présente des contraintes assez considérables. On peut citer :
	Une méconnaissance du projet et plus précisément de la structure de la base de données déjà implémentée.
	La solution finale doit être compatible avec l’environnement actuel de Gheskio : .Net, C#, SQL Server...
	La solution doit pouvoir partager les données collectées de manière la plus utile que possible et sous une base régulière sans que cela nécessite l’intervention d’un IT Programmer ou d’un Data Manager.
	La solution doit être efficace. L’efficacité de la solution pourra être évaluée par un échantillon représentatif des utilisateurs finaux qui ont un intérêt dans la soumission des données.

Etapes importantes
Les différentes étapes importantes ou milestones du projet consistent en des points stratégiques permettant d’évaluer l’avancement du projet à des dates déterminées. Elles constituent le guide de toutes les parties prenantes dudit projet. A chaque milestone, nous définissons une liste de tâches de dimension moins considérables mais très importantes étant une maille de la chaine. Une étape importante ou milestone sera complète quand toutes les tâches qui s’y rattachent sont aussi complètes. 
Etape 1 – Etat de l’art et recueil des données nécessaires
Comment mesure-t-on ce milestone ?
           On attend un document d’architecture de système qui permettra la mise en place du système de soumission et un fichier succinct contenant toutes les données et les contraintes.

Date limite : 11/08/2022 16h

	Tâches	Commentaire	Rendu attendu	Durée	Responsable
0	Réalisation du Roadmap du projet		Roadmap	½ j	Fleurimond
1a	Brève Présentation du projet BID FAES	Voir les objectifs	Une bonne compréhension du projet	½ h	Stephano/Youry
1b	Présentation de l’architecture du projet BID FAES	Voir cote technique	Une bonne compréhension de l’application 	1h	Stephano/Mengual
1c	Définir le document d’architecture du Web API	Avoir une nette compréhension des différentes composantes du système, et comment elles se communiquent.	Un diagramme présentant les relations entre les différentes composantes du système	4h	Fleurimond
1d	Valider le document d’architecture du système	Valider le document défini en 1c	Réponse du validateur	1h	Stephano/Dorlus
1e	Discussions et Recueil des données à soumettre	Définir toutes les contraintes jugées importantes, les priorités, les plages de validations …	Document de synthèse des données à soumettre 	½ j	Fleurimond, Stephano, Mengual
Période de FORMATION pour la passation de Stephano ou autres taches Data :  50% disponibilité
 Etape 2 – Implémentation des différentes parties
Comment mesure-t-on ce milestone ?
          Créer la forme sur Commcare suivant le document de synthèse des données à soumettre, puis implémenter les logiques de soumission via un API puis préparer le journal de soumission.

Date limite : 23/08/2022



	Tâches	Commentaire	Rendu attendu	Durée	Responsable
2a	Créer la forme sur Commcare suivant le document de synthèse des données à soumettre		Nouveau formulaire sur le serveur Commcare	2j	Fleurimond
2b	Validation du formulaire			2h	Stephano
2c	Implémenter l’API de soumission		Les codes exécutés normalement	5j	Fleurimond
2d	Préparer le journal de soumission		Le journal de soumission – Jeux de test	1j	Fleurimond
2e	Testing		Résultat de test	½ j	M. Marcelin/Stephano


Etape 3 - Rapports automatiques (Moyen terme)
Comment mesure-t-on ce milestone ?
           Le rapport automatique devra joindre les concernés à la date voulue suivant le mode de communication défini dans l’architecture.


Date limite : 


	Tâches	Commentaire	Rendu attendu	Durée	Responsable
3a	Créer le rapport de soumission		L’exécutable du rapport		Fleurimond
3b	Intégrer le rapport dans le report server 		Le rapport correspondant		Fleurimond
3c	Automatiser l’envoi du rapport aux personnes concernées		Les personnes concernées reçoivent le rapport		Fleurimond





Etape 4 – Flagger les données dont la soumission est échouée (Moyen terme) 
	Comment mesure-t-on ce milestone ?
Dans le tableau de bord (Dashboard), identifier les bénéficiaires n’ayant pas réussi au moins une soumission de données sur Commcare. Ainsi que, dans le journal de validation.

Date limite : 

	Tâches	Commentaire	Rendu attendu	Durée	Responsable
4a	Créer une procédure donnant les détails de soumission des bénéficiaires		La procédure SP_DATA_SOUMISSION_DETAILS créée et testée		Fleurimond
4b	Mettre à jour l’interface graphique du tableau de bord des bénéficiaires	Ajouter flag et liens sur les bénéficiaires dont la soumission est échouée 	L’interface modifié et testée		Fleurimond



