from src.db import get_connection

# ------------------- Production totale par site -------------------
def production_totale_par_site():
    conn = get_connection()
    cursor = conn.cursor()

    query = """
    SELECT s.name,
           COALESCE(SUM(p.quantity_produced), 0) AS total_production
    FROM sites s
    LEFT JOIN wells w ON s.id = w.site_id
    LEFT JOIN production p ON w.id = p.well_id
    GROUP BY s.id
    ORDER BY total_production DESC
    """

    cursor.execute(query)
    results = cursor.fetchall()
    conn.close()
    return results



# ------------------- Taux de disponibilité des puits-------------------

def taux_disponibilite_puits():
    """
    Calcule le taux de disponibilité de chaque puits :
    nombre de jours avec production / nombre total de jours enregistrés.
    """
    conn = get_connection()
    cursor = conn.cursor()

    query = """
    SELECT 
        w.name AS well,
        COUNT(p.id) AS jours_prod,
        (SELECT COUNT(DISTINCT date(timestamp)) FROM production) AS total_jours,
        ROUND(COUNT(p.id) * 100.0 /
             (SELECT COUNT(DISTINCT date(timestamp)) FROM production), 2) AS taux
    FROM wells w
    LEFT JOIN production p ON p.well_id = w.id
    GROUP BY w.id
    ORDER BY taux DESC
    """
    cursor.execute(query)
    results = cursor.fetchall()
    conn.close()
    return results



def rendement_par_equipe():
    """
    Calcule la durée totale d'intervention par équipe.
    """
    conn = get_connection()
    cursor = conn.cursor()

    query = """
    SELECT t.name AS team,
           COALESCE(
               SUM(strftime('%s', i.end_time) - strftime('%s', i.start_time)) / 3600.0,
               0
           ) AS heures_intervention
    FROM teams t
    LEFT JOIN interventions i ON i.team_id = t.id
    GROUP BY t.id
    ORDER BY heures_intervention DESC
    """

    cursor.execute(query)
    results = cursor.fetchall()
    conn.close()
    return results













