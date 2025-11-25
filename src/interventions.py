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


def add_intervention(well_id, team_id, start_time, end_time, operation, notes):
    """Ajoute une nouvelle intervention"""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO interventions (well_id, team_id, start_time, end_time, operation, notes)
        VALUES (?, ?, ?, ?, ?, ?)
    """, (well_id, team_id, start_time, end_time, operation, notes))
    conn.commit()
    conn.close()
    print("✅ Intervention ajoutée avec succès.")

def get_intervention(order_by="id"):
    """
    Retourne la liste des interventions avec les infos sur le puits et l'équipe,
    triées par ID (par défaut).
    """
    conn = get_connection()
    cursor = conn.cursor()

    query = f"""
    SELECT i.id, w.name AS well_name, t.name AS team_name,
           i.start_time, i.end_time, i.operation, i.notes
    FROM interventions i
    JOIN wells w ON i.well_id = w.id
    JOIN teams t ON i.team_id = t.id
    ORDER BY i.{order_by} ASC
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    conn.close()
    return rows



def update_intervention(intervention_id, team_id=None, operation=None, notes=None, end_time=None):
    """Met à jour une intervention existante"""
    conn = get_connection()
    cursor = conn.cursor()
    fields = []
    values = []

    if team_id:
        fields.append("team_id = ?")
        values.append(team_id)
    if operation:
        fields.append("operation = ?")
        values.append(operation)
    if notes:
        fields.append("notes = ?")
        values.append(notes)
    if end_time:
        fields.append("end_time = ?")
        values.append(end_time)

    if not fields:
        print("⚠️ Aucun champ à mettre à jour.")
        return

    query = f"UPDATE interventions SET {', '.join(fields)} WHERE id = ?"
    values.append(intervention_id)
    cursor.execute(query, values)
    conn.commit()
    conn.close()
    print(f"🔁 Intervention {intervention_id} mise à jour avec succès.")


def delete_intervention(intervention_id):
    """Supprime une intervention"""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM interventions WHERE id = ?", (intervention_id,))
    conn.commit()
    conn.close()
    print(f"🗑️ Intervention {intervention_id} supprimée avec succès.")
