import sqlite3
from pathlib import Path

# ==========================
#  Configuration de la base
# ==========================
DB_PATH = Path("data/oil_production.db")

def get_connection():
    """Ouvre une connexion SQLite avec les contraintes FK activées."""
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn



# ------------------- lister un site -------------------

def get_sites():
    """Retourne la liste de tous les sites."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM sites")
    rows = cursor.fetchall()
    conn.close()
    return rows


# ------------------- Ajouter un site -------------------
def add_site(name, location=None, description=None):
    """Ajoute un nouveau site et retourne son ID."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO sites (name, location, description) VALUES (?, ?, ?)",
        (name, location, description),
    )
    conn.commit()
    site_id = cursor.lastrowid
    conn.close()
    print(f"✅ Site ajouté avec ID {site_id}")
    return site_id


# ------------------- Update un site par non/ local -------------------
def update_site(identifier, name=None, location=None, description=None):
    """
    Met à jour un site existant en utilisant soit le nom, soit la localisation.
    - identifier : nom ou localisation du site à modifier (str)
    - name, location, description : champs à mettre à jour (optionnels)
    """
    conn = get_connection()
    cursor = conn.cursor()

    # Vérifie si la table utilise bien 'id' comme clé primaire
    cursor.execute("SELECT id, name, location FROM sites WHERE name = ? OR location = ?", (identifier, identifier))
    result = cursor.fetchone()

    if not result:
        print(f"⚠️ Aucun site trouvé avec le nom ou la localisation '{identifier}'.")
        conn.close()
        return

    site_id = result[0]
    old_name = result[1]
    old_location = result[2]

    # Construire la requête UPDATE dynamiquement
    fields = []
    values = []

    if name is not None:
        fields.append("name = ?")
        values.append(name)
    if location is not None:
        fields.append("location = ?")
        values.append(location)
    if description is not None:
        fields.append("description = ?")
        values.append(description)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        conn.close()
        return

    query = f"UPDATE sites SET {', '.join(fields)} WHERE id = ?"
    values.append(site_id)

    cursor.execute(query, values)
    conn.commit()
    conn.close()

    print(f"✅ Site '{old_name}' ({old_location}) mis à jour avec succès.")

# ------------------- Supp un site par id seulement -------------------
def delete_site(site_id):
    """Supprime un site selon son ID."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM sites WHERE id = ?", (site_id,))
    conn.commit()
    conn.close()
    print(f"🗑️ Site {site_id} supprimé avec succès.")

    
    
    
    # ------------------- Update un site par iiiddddd -------------------
def update(site_id, name=None, location=None, description=None):
    """Met à jour un site existant (champs optionnels)."""
    conn = get_connection()
    cursor = conn.cursor()

    # On construit dynamiquement la requête selon les champs fournis
    fields = []
    values = []

    if name is not None:
        fields.append("name = ?")
        values.append(name)
    if location is not None:
        fields.append("location = ?")
        values.append(location)
    if description is not None:
        fields.append("description = ?")
        values.append(description)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        conn.close()
        return

    query = f"UPDATE sites SET {', '.join(fields)} WHERE id = ?"
    values.append(site_id)
    cursor.execute(query, values)
    conn.commit()
    conn.close()
    print(f"🔁 Site {site_id} mis à jour avec succès.")

