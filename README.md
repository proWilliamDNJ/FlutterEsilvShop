##William de NIJS

# ESILV Shop

Application mobile de e-commerce réalisée en **Flutter** dans le cadre du cours **Mobile Development** (ESILV, cycle ingénieur).

L'application affiche un catalogue de produits récupéré depuis l'API publique [Fake Store API](https://fakestoreapi.com), permet de consulter le détail d'un produit, de gérer un panier et de simuler un paiement.

## Contexte du projet

Le projet s'est construit en deux temps :

1. **Partie TP (encadrée en cours)** : socle de l'application, avec la liste des produits, la page de détail, la navigation et un premier panier.
2. **Partie autonome (rendu de projet)** : enrichissement du panier, de la page détail et ajout d'une page de paiement 

## Fonctionnalités

### Réalisées en TP

- Récupération du catalogue via HTTP (`GET /products`) et désérialisation JSON dans un modèle `Product`
- Liste des produits (image, titre, prix) avec ajout rapide au panier
- Page de détail d'un produit chargée par son identifiant (`GET /products/:id`), avec gestion du chargement et des erreurs
- Navigation déclarative avec `go_router` (routes `/`, `/product/:idProduct`, `/cart`)
- Gestion d'état du panier avec Riverpod et badge du nombre d'articles dans l'AppBar

### Réalisées en autonomie

- **Panier complet** : calcul et affichage du total, message lorsque le panier est vide, suppression d'un article, bouton « Commander »
- **Page détail enrichie** : note du produit affichée en étoiles (pleines, demi et vides), catégorie, indicateur « le produit est dans le panier »
- **Égalité des produits** par identifiant (`operator ==`) pour pouvoir détecter et retirer un produit du panier
- **Page de paiement** (route `/payment`) : choix du moyen de paiement (VISA, Mastercard, AMEX, PayPal, ApplePay), formulaire de carte (numéro, titulaire, expiration, CVV masqué) et confirmation par boîte de dialogue

> Le paiement est entièrement simulé : aucune donnée n'est envoyée ni enregistrée.

## Stack technique

| Élément | Usage |
|---|---|
| Flutter / Dart | Framework et langage |
| `go_router` | Navigation et routes paramétrées |
| `http` | Appels à la Fake Store API |
| `flutter_riverpod`, `riverpod_annotation` | Gestion d'état du panier |
| `riverpod_generator`, `build_runner` | Génération du provider (`cart.g.dart`) |
| Material 3 | Interface (thème généré à partir d'une couleur rouge) |

## Structure du projet

```
lib/
├── main.dart                     # Point d'entrée, ProviderScope
├── app.dart                      # MaterialApp, routes go_router, chargement d'un produit
├── model/
│   ├── product.dart              # Modèle Product (fromMap, toMap, prix formaté)
│   ├── cart.dart                 # Notifier Riverpod du panier (add, remove)
│   └── cart.g.dart               # Code généré par riverpod_generator
└── page/
    ├── list_product_page.dart    # Catalogue
    ├── detail_product_page.dart  # Détail d'un produit
    ├── cart_page.dart            # Panier
    └── payment_page.dart         # Paiement simulé
```

## Navigation

```
/                      Liste des produits
├── /product/:id       Détail d'un produit
├── /cart              Panier
└── /payment           Paiement
```

## Installation et lancement

Prérequis : Flutter SDK (Dart 3.x) et un émulateur ou un appareil connecté. Une connexion internet est nécessaire pour charger les produits.

```bash
git clone <url-du-depot>
cd esilv_shop_26-main
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # régénère cart.g.dart si besoin
flutter run
```

## Pistes d'amélioration

- Gérer les quantités d'un même produit dans le panier
- Vider le panier et revenir à l'accueil après un paiement confirmé
- Valider les champs du formulaire de paiement
- Retirer la dépendance `provider`, devenue inutile depuis le passage à Riverpod
- Remplacer le titre provisoire de la page d'accueil


William de Nijs, ESILV Nantes, cours Mobile Development.

