CREATE DATABASE traffic_emergency_db;
USE traffic_emergency_db;
CREATE TABLE traffic_incidents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp DATETIME,
    Hour INT,
    Day_of_Week VARCHAR(20),
    Holiday_Indicator VARCHAR(10),
    Weather VARCHAR(50),
    Road_Surface VARCHAR(50),
    Visibility_Distance FLOAT,
    Environmental_Degradation VARCHAR(50),
    Area_Type VARCHAR(50),
    Road_Classification VARCHAR(50),
    Speed_Limit INT,
    Recorded_Speed_kmh FLOAT,
    Congestion_Index FLOAT,
    Vehicle_Type VARCHAR(50),
    Driver_Age INT,
    Driving_Experience INT,
    Collision_Type VARCHAR(50),
    Accident_Severity VARCHAR(50),
    Dispatch_Priority VARCHAR(50),
    Expected_Response_Time FLOAT,
    Actual_Response_Time FLOAT
);

DROP TABLE IF EXISTS traffic_incidents;

CREATE TABLE traffic_incidents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Record_ID VARCHAR(50),
    Timestamp DATETIME,
    Date DATE,
    Hour INT,
    Month INT,
    Day_of_Week VARCHAR(20),
    Time_of_Day VARCHAR(50),
    Is_Holiday INT,
    Area_Type VARCHAR(50),
    Road_Classification VARCHAR(50),
    Speed_Limit INT,
    Recorded_Speed_kmh FLOAT,
    Congestion_Index VARCHAR(50),
    Weather VARCHAR(50),
    Road_Surface VARCHAR(50),
    Visibility_Distance FLOAT,
    Environmental_Degradation VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Driver_Age INT,
    Driving_Experience INT,
    Collision_Type VARCHAR(50),
    Accident_Severity VARCHAR(50),
    Dispatch_Priority VARCHAR(50),
    Expected_Response_Time FLOAT,
    Actual_Response_Time FLOAT,
    Response_Delay FLOAT,
    Severity_Score INT,
    Risk_Factor_Index FLOAT
);

DROP TABLE IF EXISTS traffic_incidents;

SELECT * FROM traffic_emergency_db.synthetic_traffic_benchmark_200k LIMIT 10;

-- Exploración General y Volumetría:
-- 1. Total de registros e incidentes en la base de datos
SELECT 
    COUNT(*) AS total_incidentes,
    COUNT(DISTINCT Record_ID) AS total_registros_unicos
FROM traffic_emergency_db.synthetic_traffic_benchmark_200k;

-- 2. Distribución de incidentes por tipo de área
SELECT 
    Area_Type,
    COUNT(*) AS total_incidentes,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM synthetic_traffic_benchmark_200k), 2) AS porcentaje
FROM synthetic_traffic_benchmark_200k
GROUP BY Area_Type
ORDER BY total_incidentes DESC;

-- Análisis Temporal y Ambiental:
-- 3. Análisis de incidentes según el momento del día
SELECT 
    Time_of_Day,
    COUNT(*) AS total_incidentes
FROM synthetic_traffic_benchmark_200k
GROUP BY Time_of_Day
ORDER BY total_incidentes DESC;

-- 4. Impacto de las condiciones climáticas en los incidentes
SELECT 
    Weather,
    COUNT(*) AS total_incidentes
FROM synthetic_traffic_benchmark_200k
GROUP BY Weather
ORDER BY total_incidentes DESC;



-- Análisis de Severidad y Factores de Riesgo:
-- 5. Distribución de incidentes por nivel de severidad
SELECT 
    Accident_Severity,
    COUNT(*) AS total_incidentes,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM synthetic_traffic_benchmark_200k), 2) AS porcentaje
FROM synthetic_traffic_benchmark_200k
GROUP BY Accident_Severity
ORDER BY total_incidentes DESC;

-- 6. Tiempos de respuesta promedio vs esperado por prioridad de despacho
SELECT 
    Dispatch_Priority,
    COUNT(*) AS total_incidentes,
    ROUND(AVG(Baseline_Expected_Response_Time_min), 2) AS tiempo_esperado_promedio,
    ROUND(AVG(Actual_Response_Time_min), 2) AS tiempo_real_promedio
FROM synthetic_traffic_benchmark_200k
GROUP BY Dispatch_Priority
ORDER BY tiempo_real_promedio DESC;

-- Indicadores de Emergencia y Tiempos de Respuesta:
-- 1. Crear Vista de Resumen por Área y Severidad
CREATE OR REPLACE VIEW vista_resumen_incidentes_area AS
SELECT 
    Area_Type,
    Accident_Severity,
    COUNT(*) AS total_incidentes,
    ROUND(AVG(Actual_Response_Time_min), 2) AS promedio_tiempo_respuesta
FROM synthetic_traffic_benchmark_200k
GROUP BY Area_Type, Accident_Severity;

SELECT * FROM vista_resumen_incidentes_area;

-- 2. Crear Vista de Eficiencia en Tiempos de Respuesta
CREATE OR REPLACE VIEW vista_eficiencia_respuestas AS
SELECT 
    Dispatch_Priority,
    COUNT(*) AS total_incidentes,
    ROUND(AVG(Baseline_Expected_Response_Time_min), 2) AS tiempo_esperado_promedio,
    ROUND(AVG(Actual_Response_Time_min), 2) AS tiempo_real_promedio
FROM synthetic_traffic_benchmark_200k
WHERE Dispatch_Priority != 'N/A'
GROUP BY Dispatch_Priority;

SELECT * FROM vista_eficiencia_respuestas;