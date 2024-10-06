from faker import Faker
import psycopg2
import random

# Connexion à la base de données PostgreSQL via Railway
DATABASE_URL = "postgresql://postgres:NUWcRQbJqIFGSiTWomQEFreETILLrQGW@autorack.proxy.rlwy.net:56515/railway"

# Connexion à PostgreSQL
conn = psycopg2.connect(DATABASE_URL, sslmode='require')
cur = conn.cursor()

# Initialiser Faker
fake = Faker()

# Fonction pour nettoyer le numéro de téléphone
def nettoyer_telephone(telephone):
    return ''.join(filter(str.isdigit, telephone))

# Génération des données pour les Vendeurs
def generer_vendeurs(n):
    for _ in range(n):
        prenom = fake.first_name()
        nom = fake.last_name()
        telephone = nettoyer_telephone(fake.phone_number())
        sexe = random.choice(['M', 'F'])
        cur.execute("INSERT INTO vendeur (prenom, nom, telephone, sexe) VALUES (%s, %s, %s, %s)", 
                    (prenom, nom, telephone, sexe))
    conn.commit()

# Génération des données pour les Produits
def generer_produits(n):
    products = [
        "T-shirt", 
        "Jeans", 
        "Chaussures de sport", 
        "Veste en cuir", 
        "Écharpe", 
        "Robe d'été", 
        "Pantalon de costume", 
        "Pull en laine", 
        "Blouson en jean", 
        "Manteau en laine", 
        "Short de sport", 
        "Chaussettes en coton", 
        "Casquette", 
        "Gants en cuir", 
        "Chemise à manches longues", 
        "Pyjama", 
        "Jupe crayon", 
        "Ceinture en cuir", 
        "Bonnet", 
        "Maillot de bain", 
        "Salopette", 
        "Cardigan", 
        "Polo", 
        "Bottes en cuir", 
        "Sandales"
    ]

    for _ in range(n):
        # Choix aléatoire d'une désignation depuis la liste de produits
        designation = random.choice(products)
        prix_unitaire = round(random.uniform(10.0, 100.0), 2)  # Prix entre 10 et 100
        
        # Insérer dans la base de données
        cur.execute("INSERT INTO produit (designation, prix_unitaire) VALUES (%s, %s)", 
                    (designation, prix_unitaire))
    
    # Valider les modifications
    conn.commit()



# Génération des données pour les Clients
def generer_clients(n):
    for _ in range(n):
        prenom = fake.first_name()
        nom = fake.last_name()
        telephone = nettoyer_telephone(fake.phone_number())
        sexe = random.choice(['M', 'F'])
        type_client = random.choice(['A', 'B', 'C'])  # Trois types différents
        try:
            cur.execute("INSERT INTO client (prenom, nom, telephone, sexe, type_client) VALUES (%s, %s, %s, %s, %s)", 
                        (prenom, nom, telephone, sexe, type_client))
        except psycopg2.Error as e:
            print(f"Erreur lors de l'insertion du client : {e}")
    conn.commit()

# Génération des données pour les Commandes
def generer_commandes(n):
    for _ in range(n):
        client_id = random.randint(1, 100)  # 100 clients
        vendeur_id = random.randint(1, 5)   # 5 vendeurs
        date_commande = fake.date_this_year()

        # Initialisation du montant total de la commande
        montant_total = 0

        try:
            # Insérer la commande
            cur.execute("INSERT INTO commande (client_id, vendeur_id, date_commande, montant_total) VALUES (%s, %s, %s, %s) RETURNING commande_id", 
                        (client_id, vendeur_id, date_commande, montant_total))
            commande_id = cur.fetchone()[0]

            # Générer des produits pour chaque commande
            produits_ajoutes = set()  # Ensemble pour suivre les produits déjà ajoutés
            for _ in range(random.randint(1, 5)):  # 1 à 5 produits
                produit_id = random.randint(1, 20)  # 20 produits

                # Vérifier si ce produit a déjà été ajouté pour cette commande
                if produit_id in produits_ajoutes:
                    continue  # Passer au prochain produit s'il existe déjà

                quantite = random.randint(1, 10)
                
                # Vérifier si le produit existe
                cur.execute("SELECT prix_unitaire FROM produit WHERE produit_id = %s", (produit_id,))
                result = cur.fetchone()

                if result is not None:
                    prix_unitaire = result[0]
                    
                    # Calculer le montant total de cette ligne
                    montant_total += prix_unitaire * quantite
                    
                    # Insérer la ligne dans commande_produit
                    cur.execute("INSERT INTO commande_produit (commande_id, produit_id, quantite) VALUES (%s, %s, %s)", 
                                (commande_id, produit_id, quantite))

                    # Ajouter le produit à l'ensemble des produits déjà traités
                    produits_ajoutes.add(produit_id)
                else:
                    print(f"Produit avec ID {produit_id} n'existe pas.")
            
            # Mettre à jour le montant total dans la commande
            cur.execute("UPDATE commande SET montant_total = %s WHERE commande_id = %s", 
                        (montant_total, commande_id))

        except psycopg2.Error as e:
            print(f"Erreur lors de l'insertion de la commande : {e}")
    
    # Valider les transactions
    conn.commit()

# Appel des fonctions pour générer les données
generer_vendeurs(5)
generer_produits(20)
generer_clients(100)
generer_commandes(1500)

# Fermer la connexion
cur.close()
conn.close()
