 
PRAGMA foreign_keys = ON;

-- ============================================
-- TABLE 1: SITES (Oil Fields / Locations)
-- ============================================
CREATE TABLE IF NOT EXISTS sites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    location TEXT,
    description TEXT
);

INSERT INTO sites (name, location, description) VALUES
('Permian Basin', 'Texas, USA', 'Largest US oilfield with extensive operations'),
('Marcellus Shale', 'Pennsylvania, USA', 'Major gas-producing shale formation'),
('Kern River', 'California, USA', 'Historical oilfield, mature production'),
('Eagle Ford Shale', 'Texas, USA', 'Major shale play with high production'),
('Bakken Formation', 'North Dakota, USA', 'Tight oil formation, significant reserves'),
('Niobrara Shale', 'Colorado, USA', 'Emerging shale play with growth potential'),
('Haynesville Shale', 'Louisiana, USA', 'Gas-rich shale formation'),
('Vaca Muerta', 'Argentina', 'Second largest shale reserves globally'),
('Troll Field', 'North Sea, Norway', 'Major offshore field'),
('Ghawar Field', 'Saudi Arabia', 'World''s largest conventional oil field'),
('Safaniyah Field', 'Saudi Arabia', 'Largest offshore oilfield'),
('Kashagan', 'Caspian Sea, Kazakhstan', 'Major offshore discovery');

-- ============================================
-- TABLE 2: WELLS
-- ============================================
CREATE TABLE IF NOT EXISTS wells (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    site_id INTEGER,
    name TEXT,
    depth REAL,
    status TEXT,
    FOREIGN KEY(site_id) REFERENCES sites(id) ON DELETE CASCADE
);

INSERT INTO wells (site_id, name, depth, status) VALUES
(1, 'API-42131456780001', 9800.5, 'Active'),
(1, 'API-42131456780002', 10120.0, 'Inactive'),
(1, 'API-42131456780003', 8950.25, 'Active'),
(1, 'API-42131456780004', 11200.0, 'Maintenance'),
(2, 'API-37100123450001', 8900.75, 'Active'),
(2, 'API-37100123450002', 9100.0, 'Active'),
(3, 'API-06007123450001', 6500.0, 'Active'),
(3, 'API-06007123450002', 6750.5, 'Inactive'),
(4, 'API-48205987650001', 12300.0, 'Active'),
(4, 'API-48205987650002', 11800.75, 'Active'),
(5, 'API-33025456780001', 10500.0, 'Active'),
(5, 'API-33025456780002', 10800.25, 'Maintenance'),
(6, 'API-08001234567001', 7800.0, 'Active'),
(7, 'API-22015789012001', 9200.5, 'Active'),
(9, 'API-TROLL-001', 1680.0, 'Active'),
(10, 'API-GHAWAR-001', 14000.0, 'Active');

-- ============================================
-- TABLE 3: TEAMS
-- ============================================
CREATE TABLE IF NOT EXISTS teams (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    contact TEXT
);

INSERT INTO teams (name, contact) VALUES
('Alpha Operations', 'ops.alpha@oilco.com'),
('Well Servicing East', 'service.east@oilco.com'),
('West Drillers', 'west.dril@oilco.com'),
('Delta Maintenance', 'maint.delta@oilco.com'),
('Echo Intervention Team', 'interv.echo@oilco.com'),
('Foxtrot Production', 'prod.foxtrot@oilco.com'),
('Golf Offshore Services', 'offshore.golf@oilco.com'),
('Hotel Wireline Services', 'wireline.hotel@oilco.com'),
('India Safety Response', 'safety.india@oilco.com'),
('Juliet Completion Team', 'completion.juliet@oilco.com'),
('Kilo Emergency Response', 'emergency.kilo@oilco.com'),
('Lima Technical Support', 'tech.lima@oilco.com');

-- ============================================
-- TABLE 4: INTERVENTIONS
-- ============================================
CREATE TABLE IF NOT EXISTS interventions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    well_id INTEGER,
    team_id INTEGER,
    start_time TEXT,
    end_time TEXT,
    operation TEXT,
    notes TEXT,
    FOREIGN KEY(well_id) REFERENCES wells(id) ON DELETE CASCADE,
    FOREIGN KEY(team_id) REFERENCES teams(id) ON DELETE CASCADE
);

INSERT INTO interventions (well_id, team_id, start_time, end_time, operation, notes) VALUES
(1, 1, '2025-04-01 07:30', '2025-04-01 09:30', 'Wireline Logging', 'Routine operation, no issues observed.'),
(2, 2, '2025-05-15 08:00', '2025-05-15 13:00', 'Snubbing Operation', 'High pressure snubbing, Class 2, success.'),
(1, 3, '2025-04-20 06:00', '2025-04-20 06:45', 'Workover', 'Minor maintenance, resolved valve issue.'),
(3, 4, '2025-03-10 10:00', '2025-03-10 16:00', 'Well Stimulation', 'Acid treatment completed successfully.'),
(5, 5, '2025-02-28 09:15', '2025-02-28 12:30', 'Tubing Replacement', 'Full tubing run, no complications.'),
(6, 6, '2025-06-05 07:00', '2025-06-05 14:00', 'Production Optimization', 'Choke adjustment and flow optimization.'),
(4, 7, '2025-01-15 08:30', '2025-01-15 11:00', 'Safety Inspection', 'BOP inspection and pressure test.'),
(7, 8, '2025-05-22 06:00', '2025-05-22 18:00', 'Well Logging', 'Comprehensive logging suite completed.'),
(8, 9, '2025-03-05 12:00', '2025-03-05 14:00', 'Emergency Response', 'Pressure relief valve replacement.'),
(9, 10, '2025-04-10 08:00', '2025-04-10 20:00', 'Well Completion', 'Perforations and screen installation.'),
(10, 11, '2025-02-14 09:00', '2025-02-14 17:00', 'Downhole Tools Repair', 'Tool retrieval and maintenance.'),
(11, 12, '2025-06-20 07:30', '2025-06-20 10:15', 'Pressure Test', 'Formation integrity test passed.'),
(12, 1, '2025-05-01 08:00', '2025-05-01 12:00', 'Sand Control', 'Screen installation and testing.'),
(3, 2, '2025-04-25 09:30', '2025-04-25 11:45', 'Flow Line Check', 'Pipeline inspection completed.'),
(5, 3, '2025-06-10 10:00', '2025-06-10 15:30', 'Corrosion Monitoring', 'Corrosion probe installed and baseline set.');

-- ============================================
-- TABLE 5: PRODUCTION
-- ============================================
CREATE TABLE IF NOT EXISTS production (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    well_id INTEGER,
    timestamp TEXT,
    flow_rate REAL,
    pressure REAL,
    temperature REAL,
    quantity_produced REAL,
    FOREIGN KEY(well_id) REFERENCES wells(id) ON DELETE CASCADE
);

INSERT INTO production (well_id, timestamp, flow_rate, pressure, temperature, quantity_produced) VALUES
(1, '2025-01-01', 350.5, 2400, 88.5, 120.0),
(1, '2025-02-01', 355.0, 2490, 91.2, 123.5),
(1, '2025-03-01', 348.25, 2380, 87.8, 118.5),
(1, '2025-04-01', 360.75, 2510, 92.1, 125.2),
(1, '2025-05-01', 365.0, 2550, 93.5, 128.0),
(1, '2025-06-01', 358.5, 2420, 90.2, 122.5),
(2, '2025-01-01', 290.0, 2350, 82.0, 100.0),
(2, '2025-02-01', 295.5, 2390, 84.5, 105.5),
(2, '2025-03-01', 285.75, 2310, 80.8, 98.0),
(2, '2025-04-01', 298.0, 2420, 86.2, 108.0),
(2, '2025-05-01', 302.5, 2450, 87.9, 110.5),
(2, '2025-06-01', 288.0, 2360, 81.5, 102.0),
(3, '2025-01-01', 420.0, 2800, 95.0, 145.0),
(3, '2025-02-01', 425.5, 2850, 97.2, 148.5),
(3, '2025-03-01', 415.25, 2780, 94.1, 142.0),
(3, '2025-04-01', 430.0, 2900, 98.5, 152.0),
(4, '2025-01-01', 275.0, 2200, 78.5, 95.0),
(4, '2025-02-01', 278.5, 2240, 80.0, 97.5),
(5, '2025-01-01', 385.0, 2650, 89.5, 132.0),
(6, '2025-01-01', 320.0, 2550, 91.0, 110.0),
(6, '2025-02-01', 325.5, 2600, 92.5, 114.0),
(7, '2025-01-01', 410.0, 2750, 94.0, 140.0),
(9, '2025-01-01', 750.0, 3200, 105.0, 250.0),
(10, '2025-01-01', 1200.0, 3500, 110.0, 380.0),
(11, '2025-01-01', 550.0, 3000, 100.5, 185.0);

-- ============================================
-- TABLE 6: INCIDENTS
-- ============================================
CREATE TABLE IF NOT EXISTS incidents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    well_id INTEGER,
    incident_type TEXT,
    severity TEXT,
    date TEXT,
    description TEXT,
    resolved INTEGER DEFAULT 0,
    FOREIGN KEY(well_id) REFERENCES wells(id) ON DELETE CASCADE
);

INSERT INTO incidents (well_id, incident_type, severity, date, description, resolved) VALUES
(1, 'Blowout', 'High', '2024-12-21', 'Pressurization exceeded control threshold. Contained, no injuries.', 1),
(2, 'Leak', 'Medium', '2024-11-12', 'Detected small tubing leak, repaired during workover.', 1),
(1, 'Valve Failure', 'Low', '2025-01-18', 'Valve replacement required due to slow response.', 1),
(3, 'Equipment Failure', 'Medium', '2025-02-05', 'Pump failure, replaced with backup unit.', 1),
(4, 'Pressure Spike', 'High', '2025-03-12', 'Unexpected pressure surge, safety vented, investigated.', 1),
(5, 'Corrosion Issue', 'Medium', '2025-01-25', 'Tubing corrosion detected, inhibitor treatment applied.', 1),
(6, 'Gas Leak', 'Low', '2025-02-14', 'Minor gas release at surface, sealed with patch.', 1),
(7, 'Fire Incident', 'High', '2024-10-08', 'Small fire at wellhead, extinguished, investigation ongoing.', 1),
(8, 'Production Loss', 'Medium', '2025-04-03', 'Unexpected production drop, choke adjusted.', 1),
(9, 'Temperature Anomaly', 'Low', '2025-03-20', 'Abnormal temperature reading, sensor calibrated.', 1),
(10, 'Sand Production', 'Medium', '2025-05-10', 'Sand entry detected, screen installed to prevent further production.', 1),
(11, 'Plug Failure', 'High', '2025-06-01', 'Cement plug failed, re-plugging initiated.', 0),
(12, 'Fluid Loss', 'Medium', '2025-05-15', 'Lost circulation during drilling, addressed with lost circulation material.', 1),
(3, 'Fatigue Crack', 'Medium', '2025-04-22', 'Minor crack in casing detected via imaging, monitoring ongoing.', 0),
(1, 'Scale Buildup', 'Low', '2025-06-05', 'Mineral scale buildup reduced flow, chemical treatment applied.', 1);


INSERT INTO sites (name, location, description) VALUES
('Prudhoe Bay', 'Alaska, USA', 'Largest oil field in North America'),
('Burgan Field', 'Kuwait', 'Second largest oil field worldwide'),
('Safaniyah', 'Saudi Arabia', 'Largest offshore oil field'),
('Cantarell Field', 'Mexico', 'Major Gulf of Mexico field'),
('Statfjord Field', 'North Sea, Norway', 'Historic offshore oil field'),
('Ekofisk Field', 'North Sea, Norway', 'Pioneer of offshore drilling'),
('Brent Field', 'North Sea, UK', 'Benchmark oil field'),
('Forties Field', 'North Sea, UK', 'Mature North Sea field'),
('Marlim Field', 'Brazil', 'Deep-water offshore giant'),
('Lula Field', 'Brazil', 'Pre-salt deep-water discovery'),
('Sakhalin Island', 'Russia', 'Far East oil and gas'),
('Tengiz Field', 'Kazakhstan', 'Super-giant oil field'),
('Athabasca Oil Sands', 'Canada', 'Vast oil sands deposit'),
('Orinoco Belt', 'Venezuela', 'Heavy oil reserves'),
('Jubilee Field', 'Ghana', 'West African discovery'),
('Leviathan Field', 'Eastern Mediterranean', 'Gas field discovery'),
('Groningen Field', 'Netherlands', 'Historic gas field'),
('Johan Sverdrup', 'North Sea, Norway', 'Recent mega field'),
('Yamal Peninsula', 'Russia', 'Arctic oil and gas region'),
('Campos Basin', 'Brazil', 'Prolific offshore region');

-- ============================================
-- ADDITIONAL WELLS (30 more records)
-- ============================================
INSERT INTO wells (site_id, name, depth, status) VALUES
(13, 'API-02103189870001', 9500.0, 'Active'),
(13, 'API-02103189870002', 10200.5, 'Active'),
(13, 'API-02103189870003', 9850.75, 'Maintenance'),
(14, 'API-25100234560001', 8500.0, 'Active'),
(14, 'API-25100234560002', 8700.25, 'Inactive'),
(15, 'API-31001567890001', 11500.0, 'Active'),
(16, 'API-16700456789001', 12800.0, 'Active'),
(17, 'API-22200789012001', 9200.0, 'Active'),
(18, 'API-15100345678001', 7800.5, 'Active'),
(19, 'API-30400123456001', 8900.0, 'Active'),
(20, 'API-30400123456002', 9100.25, 'Maintenance'),
(21, 'API-09700567890001', 14200.0, 'Active'),
(22, 'API-35500123456001', 10500.0, 'Active'),
(23, 'API-23800456789001', 11800.75, 'Active'),
(24, 'API-41000789012001', 8200.0, 'Active'),
(25, 'API-27100345678001', 13500.0, 'Maintenance'),
(26, 'API-26400123456001', 9700.5, 'Active'),
(27, 'API-52000234567001', 10900.0, 'Active'),
(28, 'API-40900567890001', 12100.25, 'Active'),
(29, 'API-14100789012001', 8400.0, 'Inactive'),
(13, 'API-02103189870004', 9750.0, 'Active'),
(14, 'API-25100234560003', 8600.75, 'Active'),
(15, 'API-31001567890002', 11600.5, 'Maintenance'),
(16, 'API-16700456789002', 12900.0, 'Active'),
(17, 'API-22200789012002', 9300.25, 'Active'),
(18, 'API-15100345678002', 7900.0, 'Active'),
(19, 'API-30400123456003', 9000.5, 'Active'),
(20, 'API-30400123456004', 9200.0, 'Active'),
(21, 'API-09700567890002', 14300.75, 'Active'),
(22, 'API-35500123456002', 10600.0, 'Maintenance');

-- ============================================
-- ADDITIONAL TEAMS (18 more records)
-- ============================================
INSERT INTO teams (name, contact) VALUES
('Mike Offshore Specialists', 'offshore.mike@oilco.com'),
('November Field Operations', 'fieldops.november@oilco.com'),
('Oscar Well Testing', 'testing.oscar@oilco.com'),
('Papa Drilling Services', 'drilling.papa@oilco.com'),
('Quebec Pressure Control', 'pressure.quebec@oilco.com'),
('Romeo Completion Services', 'completion.romeo@oilco.com'),
('Sierra Intervention Team', 'intervention.sierra@oilco.com'),
('Tango Production Team', 'production.tango@oilco.com'),
('Uniform Maintenance Crew', 'maintenance.uniform@oilco.com'),
('Victor Safety Team', 'safety.victor@oilco.com'),
('Whiskey Emergency Response', 'emergency.whiskey@oilco.com'),
('X-ray Technical Support', 'tech.xray@oilco.com'),
('Yankee Operations', 'ops.yankee@oilco.com'),
('Zulu Drilling Experts', 'drilling.zulu@oilco.com'),
('Aurora Subsurface Team', 'subsurface.aurora@oilco.com'),
('Bravo Reservoir Engineering', 'reservoir.bravo@oilco.com'),
('Charlie Production Optimization', 'optimization.charlie@oilco.com'),
('Delta Downhole Tools', 'tools.delta@oilco.com');

-- ============================================
-- ADDITIONAL INTERVENTIONS (35 more records)
-- ============================================
INSERT INTO interventions (well_id, team_id, start_time, end_time, operation, notes) VALUES
(13, 1, '2025-01-05 08:00', '2025-01-05 10:30', 'Well Inspection', 'Routine inspection completed without issues.'),
(14, 2, '2025-01-10 07:00', '2025-01-10 14:00', 'Sand Cleanout', 'Sand removal and screen installation.'),
(15, 3, '2025-01-15 09:00', '2025-01-15 11:00', 'Pressure Maintenance', 'Pressure test and gauge calibration.'),
(16, 4, '2025-01-20 08:30', '2025-01-20 12:00', 'Subsurface Inspection', 'Downhole pressure survey completed.'),
(17, 5, '2025-01-25 07:30', '2025-01-25 09:45', 'Tubing Inspection', 'Visual inspection, minor corrosion noted.'),
(18, 6, '2025-02-01 08:00', '2025-02-01 16:00', 'Workover Operation', 'Complete tubing replacement, success.'),
(19, 7, '2025-02-05 10:00', '2025-02-05 12:30', 'Safety Check', 'BOP system test passed all criteria.'),
(20, 8, '2025-02-10 06:00', '2025-02-10 18:00', 'Well Completion', 'Perforations installed, tested successfully.'),
(21, 9, '2025-02-15 09:00', '2025-02-15 13:00', 'Maintenance Run', 'Preventive maintenance completed.'),
(22, 10, '2025-02-20 08:00', '2025-02-20 15:00', 'Stimulation Job', 'Acid job completed, production increased.'),
(23, 11, '2025-02-25 07:00', '2025-02-25 11:00', 'Emergency Repair', 'Valve replacement under high pressure.'),
(24, 12, '2025-03-01 08:30', '2025-03-01 10:15', 'Flow Test', 'Production flow test successful.'),
(25, 13, '2025-03-05 09:00', '2025-03-05 17:00', 'Sidetrack Drilling', 'Sidetrack completed, in zone.'),
(26, 14, '2025-03-10 07:30', '2025-03-10 09:00', 'Log Run', 'Wireline logging completed.'),
(27, 15, '2025-03-15 08:00', '2025-03-15 14:00', 'Cement Plug', 'Cement plugs set correctly.'),
(28, 16, '2025-03-20 10:00', '2025-03-20 12:00', 'Formation Test', 'Drill stem test completed successfully.'),
(29, 17, '2025-03-25 06:00', '2025-03-25 18:00', 'Completion Assembly', 'Downhole assembly installed.'),
(30, 18, '2025-04-01 09:00', '2025-04-01 11:30', 'Pressure Relief', 'Pressure relief system installed.'),
(4, 1, '2025-04-05 08:00', '2025-04-05 10:00', 'Routine Maintenance', 'Regular maintenance completed.'),
(6, 2, '2025-04-10 07:30', '2025-04-10 13:30', 'Production Enhancement', 'Choke adjustment improved production.'),
(8, 3, '2025-04-15 09:00', '2025-04-15 11:00', 'Inspection Run', 'Well condition checked, all normal.'),
(10, 4, '2025-04-20 08:00', '2025-04-20 16:00', 'Workover', 'Well rejuvenation job completed.'),
(12, 5, '2025-04-25 07:00', '2025-04-25 09:00', 'Gauge Run', 'Downhole gauges installed successfully.'),
(13, 6, '2025-05-01 08:30', '2025-05-01 12:00', 'Drilling Continuation', 'Drilling resumed after maintenance.'),
(14, 7, '2025-05-05 10:00', '2025-05-05 14:00', 'Testing Operation', 'Well testing completed successfully.'),
(15, 8, '2025-05-10 06:00', '2025-05-10 12:00', 'Completion Work', 'Screen and gravel pack installed.'),
(16, 9, '2025-05-15 09:00', '2025-05-15 11:00', 'Final Inspection', 'Completion inspection passed.'),
(17, 10, '2025-05-20 08:00', '2025-05-20 10:30', 'Flow Line Check', 'Surface facilities inspection done.'),
(18, 11, '2025-05-25 07:30', '2025-05-25 09:30', 'Valve Maintenance', 'All valves serviced and tested.'),
(19, 12, '2025-06-01 08:00', '2025-06-01 16:00', 'Major Intervention', 'Major workover completed on schedule.'),
(20, 13, '2025-06-05 09:00', '2025-06-05 11:00', 'Production Monitoring', 'Production rates monitored and recorded.'),
(21, 14, '2025-06-10 07:00', '2025-06-10 13:00', 'Drilling Support', 'Support for drilling operations provided.'),
(22, 15, '2025-06-15 08:30', '2025-06-15 10:30', 'Well Abandonment Prep', 'Abandonment procedures initiated.'),
(23, 16, '2025-06-20 09:00', '2025-06-20 15:00', 'Final Test', 'Final well testing and certification.'),
(24, 17, '2025-06-25 06:00', '2025-06-25 14:00', 'Commissioning', 'Well commissioned for production.');

-- ============================================
-- ADDITIONAL PRODUCTION RECORDS (40+ more records)
-- ============================================
INSERT INTO production (well_id, timestamp, flow_rate, pressure, temperature, quantity_produced) VALUES
(13, '2025-01-01', 380.0, 2650, 92.0, 130.0),
(13, '2025-02-01', 385.5, 2700, 94.5, 135.0),
(13, '2025-03-01', 378.25, 2630, 91.2, 128.5),
(13, '2025-04-01', 390.0, 2750, 95.8, 138.0),
(13, '2025-05-01', 395.5, 2800, 97.2, 142.0),
(14, '2025-01-01', 310.0, 2500, 85.0, 108.0),
(14, '2025-02-01', 315.5, 2550, 87.5, 112.0),
(14, '2025-03-01', 305.25, 2480, 83.8, 104.5),
(14, '2025-04-01', 320.0, 2600, 89.2, 115.0),
(14, '2025-05-01', 325.5, 2650, 91.0, 118.0),
(15, '2025-01-01', 440.0, 2950, 98.0, 155.0),
(15, '2025-02-01', 445.5, 3000, 100.5, 159.0),
(15, '2025-03-01', 435.25, 2920, 97.2, 152.0),
(15, '2025-04-01', 450.0, 3050, 101.8, 162.0),
(15, '2025-05-01', 455.5, 3100, 103.2, 166.0),
(16, '2025-01-01', 520.0, 3200, 105.5, 185.0),
(16, '2025-02-01', 525.5, 3250, 107.0, 188.0),
(16, '2025-03-01', 515.25, 3170, 104.2, 182.0),
(16, '2025-04-01', 530.0, 3300, 108.8, 192.0),
(16, '2025-05-01', 535.5, 3350, 110.2, 196.0),
(17, '2025-01-01', 400.0, 2800, 93.0, 140.0),
(17, '2025-02-01', 405.5, 2850, 95.5, 144.0),
(17, '2025-03-01', 395.25, 2770, 91.8, 137.0),
(17, '2025-04-01', 410.0, 2900, 96.2, 147.0),
(17, '2025-05-01', 415.5, 2950, 98.0, 151.0),
(18, '2025-01-01', 460.0, 3100, 102.0, 168.0),
(18, '2025-02-01', 465.5, 3150, 104.5, 172.0),
(18, '2025-03-01', 455.25, 3070, 101.2, 165.0),
(18, '2025-04-01', 470.0, 3200, 105.8, 175.0),
(18, '2025-05-01', 475.5, 3250, 107.2, 179.0),
(19, '2025-01-01', 340.0, 2650, 89.0, 120.0),
(19, '2025-02-01', 345.5, 2700, 91.5, 124.0),
(19, '2025-03-01', 335.25, 2620, 87.8, 116.0),
(19, '2025-04-01', 350.0, 2750, 93.2, 128.0),
(19, '2025-05-01', 355.5, 2800, 95.0, 132.0),
(20, '2025-01-01', 380.0, 2750, 91.5, 135.0),
(20, '2025-02-01', 385.5, 2800, 94.0, 139.0),
(20, '2025-03-01', 375.25, 2720, 90.2, 131.5),
(20, '2025-04-01', 390.0, 2850, 95.8, 142.0),
(20, '2025-05-01', 395.5, 2900, 97.2, 146.0),
(21, '2025-01-01', 620.0, 3400, 112.0, 215.0),
(21, '2025-02-01', 625.5, 3450, 114.5, 220.0),
(21, '2025-03-01', 615.25, 3370, 111.2, 212.0),
(21, '2025-04-01', 630.0, 3500, 116.8, 225.0),
(21, '2025-05-01', 635.5, 3550, 118.2, 230.0);

-- ============================================
-- ADDITIONAL INCIDENTS (25+ more records)
-- ============================================
INSERT INTO incidents (well_id, incident_type, severity, date, description, resolved) VALUES
(13, 'Pressure Build-up', 'Medium', '2025-01-12', 'Pressure accumulated in annulus, bled off safely.', 1),
(14, 'Flow Restriction', 'Low', '2025-01-18', 'Partial blockage detected, cleared with pig run.', 1),
(15, 'Equipment Malfunction', 'Medium', '2025-02-03', 'Surface pump failed, replaced with backup.', 1),
(16, 'Sensor Failure', 'Low', '2025-02-08', 'Pressure sensor malfunction, recalibrated.', 1),
(17, 'Gas Intrusion', 'High', '2025-02-14', 'Unexpected gas influx, controlled and managed.', 1),
(18, 'Tubing Wear', 'Medium', '2025-02-22', 'Accelerated tubing wear detected, replacement scheduled.', 0),
(19, 'Scale Deposit', 'Low', '2025-03-05', 'Scale buildup in production line, chemical treatment applied.', 1),
(20, 'Emulsion Problem', 'Medium', '2025-03-11', 'Water-oil emulsion issue, resolved with demulsifier.', 1),
(21, 'Loss of Circulation', 'High', '2025-03-18', 'Circulation lost during operations, regained after intervention.', 1),
(22, 'Thermal Issue', 'Low', '2025-03-25', 'Temperature spike detected, heat exchanger cleaned.', 1),
(23, 'Mechanical Failure', 'High', '2025-04-02', 'Downhole tool failure, tool fishing operation initiated.', 0),
(24, 'Micro-seismic Activity', 'Low', '2025-04-09', 'Induced seismicity detected during stimulation, activity ceased.', 1),
(25, 'Pipeline Corrosion', 'Medium', '2025-04-16', 'Localized corrosion found, patch applied as temporary fix.', 1),
(26, 'Power Supply Issue', 'Medium', '2025-04-23', 'Electrical power failure at wellhead, backup generator engaged.', 1),
(27, 'Water Ingress', 'High', '2025-05-01', 'Unexpected water production, investigation ongoing.', 0),
(28, 'Perforation Damage', 'Medium', '2025-05-08', 'Perforation zone damage detected, remediation planned.', 0),
(29, 'Compressor Failure', 'High', '2025-05-15', 'Surface compressor failed, entire system affected.', 1),
(30, 'Casing Deformation', 'High', '2025-05-22', 'Casing deformation observed, reinforcement initiated.', 0),
(4, 'Minor Leak', 'Low', '2025-06-01', 'Small leak at connection, retightened and monitored.', 1),
(6, 'Production Anomaly', 'Medium', '2025-06-08', 'Unexpected production drop, choke adjustment corrected it.', 1),
(8, 'Pipe Fatigue', 'Medium', '2025-06-15', 'Fatigue crack detected in piping, pipe section replaced.', 1),
(10, 'System Shutdown', 'High', '2025-06-22', 'Unplanned system shutdown due to safety alarm, resolved.', 1),
(12, 'Instrumentation Drift', 'Low', '2025-06-29', 'Instrument reading drift detected, recalibration performed.', 1),
(1, 'Annular Pressure', 'Medium', '2025-01-30', 'Annular pressure increase detected and monitored.', 1),
(2, 'Mud Gas Ratio Change', 'Low', '2025-02-20', 'Unexpected mud gas ratio change, formation change suspected.', 1);
