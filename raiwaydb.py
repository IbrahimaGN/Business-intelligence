from dotenv import load_dotenv
import os
import psycopg2

# Charger les variables d'environnement depuis le fichier .env
load_dotenv()

# Obtenir l'URL de connexion depuis les variables d'environnement
# Connexion à la base de données PostgreSQL via Railway
DATABASE_URL = "postgresql://postgres:NUWcRQbJqIFGSiTWomQEFreETILLrQGW@autorack.proxy.rlwy.net:56515/railway"

# Connexion à PostgreSQL
conn = psycopg2.connect(DATABASE_URL, sslmode='require')
cur = conn.cursor()
conn = None
cur = None

try:
    # Connexion à la base de données PostgreSQL
    conn = psycopg2.connect(DATABASE_URL, sslmode='require')
    cur = conn.cursor()

    # Création des tables
    create_tables_query = """
    CREATE TABLE IF NOT EXISTS vendeur (
        vendeur_id SERIAL PRIMARY KEY,
        prenom VARCHAR(50) NOT NULL,
        nom VARCHAR(50) NOT NULL,
        telephone VARCHAR(15) NOT NULL,
        sexe CHAR(1) CHECK (sexe IN ('M', 'F'))
    );

    CREATE TABLE IF NOT EXISTS produit (
        produit_id SERIAL PRIMARY KEY,
        designation VARCHAR(100) NOT NULL,
        prix_unitaire DECIMAL(10, 2) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS client (
        client_id SERIAL PRIMARY KEY,
        prenom VARCHAR(50) NOT NULL,
        nom VARCHAR(50) NOT NULL,
        telephone VARCHAR(15) NOT NULL,
        sexe CHAR(1) CHECK (sexe IN ('M', 'F')),
        type_client CHAR(1) CHECK (type_client IN ('A', 'B', 'C'))
    );

    CREATE TABLE IF NOT EXISTS commande (
        commande_id SERIAL PRIMARY KEY,
        client_id INT REFERENCES client(client_id),
        vendeur_id INT REFERENCES vendeur(vendeur_id),
        date_commande DATE NOT NULL,
        montant_total DECIMAL(10, 2) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS commande_produit (
        commande_produit_id SERIAL PRIMARY KEY,
        commande_id INT REFERENCES commande(commande_id),
        produit_id INT REFERENCES produit(produit_id),
        quantite INT NOT NULL
    );

    TRUNCATE client, commande, produit, commande_produit, vendeur RESTART IDENTITY CASCADE;
    """

    # Exécution des requêtes de création de tables
    cur.execute(create_tables_query)

    # Valider les modifications
    conn.commit()

    print("Tables créées avec succès.")

except psycopg2.OperationalError as e:
    print(f"Erreur de connexion à la base de données : {e}")
except psycopg2.Error as e:
    print(f"Erreur lors de la création des tables : {e}")
finally:
    # Fermer le curseur et la connexion
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()
