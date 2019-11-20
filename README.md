# Brief projet Give Me Some Credit (classification Kaggle)

Participez au Challenge Kaggle [Give Me Some Credit](http://kaggle.com/c/GiveMeSomeCredit/data). Les activités proposées ci-dessous vous nous aider à obtenir les meilleurs résultats possibles. Pour chaque activité / tâche, expliquez où se trouve ce que vous avez fait, et mettez un lien.

TODO Formateur: compétences visées, grille d'évaluation...

## Démarrer l'environnement de développement Jupyter

Nous utiliserons un environnement Jupyter fourni par un conteneur Docker. L'image utilisée est définie par le [Dockerfile](docker/Dockerfile) fourni. Celui-ci est basé sur [handson-ml2](https://github.com/ageron/handson-ml2/tree/master/docker) et il installe les packages Python listés dans [requirements.txt](requirements.txt). Ces fichiers sont à customiser au besoin.

1. Créez un fichier `docker/auth.env` basé sur `docker/auth-sample.env`, qui contiendra vos noms d'utilisateur et clés d'API pour [BigML](https://bigml.com) et Kaggle.
2. A partir du dossier `docker/`, exécutez la commande shell:

    ```bash
    docker-compose up
    ```

3. Ouvrez votre navigateur à l'adresse qui s'affiche suite à l'exécution de la commande précédente, puis cliquez sur [Intro-Jupyter.ipynb](Intro-Jupyter.ipynb) dans la liste.

## Exploration des données

* Nombre de features. Nombre de lignes dans train ("train full") et test.
* Inspectez (sous-ensemble des) données d'apprentissage en les parcourant dans un tableur et via la visualisation en histogrammes (sous Kaggle, BigML web, ou avec pandas profiling). Que remarquez-vous? (Mentionnez noms de features et ids d'inputs notables.)
* Partage de train full en train et validation.
* Inspection du train set (histogrammes, statistiques des distributions).

## Préparation des données de train, val et test (avec [Pandas](http://pandas.pydata.org))

* Remplacement valeurs manquantes / erronées / aberrantes
* Ajouts de features

Note: vous pouvez utiliser le notebook [Intro-Pandas.ipynb](Intro-Pandas.ipynb) pour vous familiariser avec la librairie Pandas.

## Création et sélection de modèle (avec [BigML Python](http://bigml.readthedocs.io))

* Comparer AUC de `ensemble` et de `deepnet` sur les données préparées (apprentissage sur train, evaluation sur val), et choisissez la meilleure des deux techniques pour la suite.

## Analyse de modèle

### Comportement global

* Créer modèle sur train
* Regarder feature importances
* Regarder Partial Dependence Plots (via interface graphique BigML pour l'instant; plus tard: avec matplotlib ou plotly)

### Erreurs sur val set

* Téléchargement des probabilités de classe faites par le modèle, sur le dataset de validation
* Ajout de colonne d'erreur
* Calcul mesures agrégées de performance: implémenter chaque métrique en Python, puis vérifier valeurs calculées en comparant avec ce que donne BigML.
  * Métriques qui sont fonction du seuil: matrice confusion et accuracy
  * Métrique indépendante du seuil: AUC
* Export des lignes avec les 100 plus importantes erreurs
  * Inspection dans tableur. N'hésitez pas à rajouter une colonne de commentaires dans votre tableur.
  * Interprétations à noter dans le notebook (mentionner l'id de l'objet, et votre interprétation, par ex: valeurs de features anormales, etc.)
* Proposez des idées pour améliorer la préparation des données, en vous basant sur l'analyse des erreurs

## Optimisation du seuil de classification

Trouver seuil qui optimise le gain total sur le validation set, pour la matrice de gains/coûts suivante:

  | Actual / Predicted | 0 | 1 |
  |--------------------|---|---|
  | 0 | $500 | -$500 |
  | 1 | -$2500 | $0 |

## Envoi de prédictions à Kaggle

* Création d'un modèle à partir de train full
* Création des probabilités de classe sur le test set
* Envoi des prédictions à Kaggle [via Python](https://github.com/kaggle/kaggle-api)
* Essayez d'obtenir le meilleur résultat possible!

## Bonus: learning curves

* Comparez performance de “ensemble” et de “deepnet” sur val set, pour afficher des courbes (learning curves) comme à la page 11 de Machine Learning Yearning: en abscisse, pourcentage de données de train utilisées pour créer un modèle; en ordonnée, AUC du modèle créé, sur le val set.
* Afficher également la performance sur train set.

## Bonus: scikit-learn et XGBoost

* Parcourez le notebook [Intro-sklearn-xgboost.ipynb](Intro-sklearn-xgboost.ipynb) et adaptez votre code pour créer des modèles sans avoir à utiliser BigML

## Copyright

[Louis Dorard](https://www.louisdorard.com/) © 2019 - Tous droits réservés

Suivez-moi sur Twitter [@louisdorard](https://twitter.com/louisdorard)
