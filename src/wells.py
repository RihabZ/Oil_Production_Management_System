from pathlib import Path
import sqlite3
# ==========================
#  Configuration de la base
# ==========================
DB_PATH = Path("data/oil_production.db")

def get_connection():
    """Ouvre une connexion SQLite avec les contraintes FK activées."""
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn


# ------------------- Ajouter un well -------------------

def create_well(site_id, name, depth, status):
    """Ajoute un nouveau puits."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO wells (site_id, name, depth, status) VALUES (?, ?, ?, ?)",
        (site_id, name, depth, status)
    )
    conn.commit()
    conn.close()
    print(f"✅ Puits '{name}' ajouté avec succès.")

    
# ------------------- lister un well -------------------


def get_wells():
    """Récupère la liste de tous les puits."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT wells.id, wells.name, wells.depth, wells.status, sites.name AS site_name
        FROM wells
        JOIN sites ON wells.site_id = sites.id
    """)
    results = cursor.fetchall()
    conn.close()
    return results


# ------------------- update un champ d' un puit -------------------

def update_well(well_id, name=None, depth=None, status=None):
    """Met à jour un puits existant (champs optionnels)."""
    conn = get_connection()
    cursor = conn.cursor()

    fields = []
    values = []

    if name is not None:
        fields.append("name = ?")
        values.append(name)
    if depth is not None:
        fields.append("depth = ?")
        values.append(depth)
    if status is not None:
        fields.append("status = ?")
        values.append(status)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        conn.close()
        return

    query = f"UPDATE wells SET {', '.join(fields)} WHERE id = ?"
    values.append(well_id)

    cursor.execute(query, values)
    conn.commit()
    conn.close()
    print(f"🔁 Puits {well_id} mis à jour avec succès.")

    
    
# ------------------- delete un well par id seumlement  -------------------

def delete_well(well_id):
    """Supprime un puits existant."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM wells WHERE id = ?", (well_id,))
    conn.commit()
    conn.close()
    print(f"🗑️ Puits {well_id} supprimé avec succès.")
    
    # ------------------- update le site d'un puit -------------------
    
def update (well_id, name=None, depth=None, status=None, site_id=None):
    """
    Met à jour les informations d'un puits existant.
    Tous les champs sont optionnels.
    """
    conn = get_connection()
    cursor = conn.cursor()

    fields = []
    values = []

    if name is not None:
        fields.append("name = ?")
        values.append(name)
    if depth is not None:
        fields.append("depth = ?")
        values.append(depth)
    if status is not None:
        fields.append("status = ?")
        values.append(status)
    if site_id is not None:
        # Vérifie que le site existe avant de modifier
        cursor.execute("SELECT id FROM sites WHERE id = ?", (site_id,))
        if cursor.fetchone() is None:
            print(f"❌ Aucun site trouvé avec l’ID {site_id}")
            conn.close()
            return
        fields.append("site_id = ?")
        values.append(site_id)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        conn.close()
        return

    query = f"UPDATE wells SET {', '.join(fields)} WHERE id = ?"
    values.append(well_id)

    cursor.execute(query, values)
    conn.commit()
    conn.close()

    print(f"🔁 Puits {well_id} mis à jour avec succès.")

