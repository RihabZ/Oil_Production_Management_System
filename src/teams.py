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


def add_team(name, contact):
    """Ajoute une nouvelle équipe"""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO teams (name, contact) VALUES (?, ?)", (name, contact))
    conn.commit()
    conn.close()
    print(f"✅ Équipe '{name}' ajoutée avec succès.")


def get_teams():
    """Retourne la liste de toutes les équipes"""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM teams")
    teams = cursor.fetchall()
    conn.close()
    return teams


def update_team(team_id, name=None, contact=None):
    """Met à jour une équipe"""
    conn = get_connection()
    cursor = conn.cursor()
    fields = []
    values = []

    if name:
        fields.append("name = ?")
        values.append(name)
    if contact:
        fields.append("contact = ?")
        values.append(contact)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        return

    query = f"UPDATE teams SET {', '.join(fields)} WHERE id = ?"
    values.append(team_id)
    cursor.execute(query, values)
    conn.commit()
    conn.close()
    print(f"🔁 Équipe {team_id} mise à jour avec succès.")


def delete_team(team_id):
    """Supprime une équipe"""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM teams WHERE id = ?", (team_id,))
    conn.commit()
    conn.close()
    print(f"🗑️ Équipe {team_id} supprimée avec succès.")
    
    
def update(identifier, name=None, contact=None):
    """Met à jour une équipe selon son ID, nom ou contact """
    conn = get_connection()
    cursor = conn.cursor()

    # Déterminer le champ d'identification
    if isinstance(identifier, int):
        where_clause = "id = ?"
    else:
        # On cherche d'abord si c’est un nom ou un contact
        cursor.execute("SELECT id FROM teams WHERE name = ? OR contact = ?", (identifier, identifier))
        result = cursor.fetchone()
        if not result:
            print(f"❌ Aucune équipe trouvée avec '{identifier}'.")
            conn.close()
            return
        identifier = result[0]
        where_clause = "id = ?"

    # Construire la requête UPDATE
    fields = []
    values = []

    if name:
        fields.append("name = ?")
        values.append(name)
    if contact:
        fields.append("contact = ?")
        values.append(contact)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        conn.close()
        return

    query = f"UPDATE teams SET {', '.join(fields)} WHERE {where_clause}"
    values.append(identifier)

    cursor.execute(query, values)
    conn.commit()
    conn.close()

    print(f"✅ Équipe mise à jour avec succès (ID: {identifier}).")

