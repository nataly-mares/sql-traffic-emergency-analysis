# 🚦 Análisis de Tráfico, Incidentes y Eficiencia en Tiempos de Respuesta (SQL)

## 📌 Descripción del Proyecto
Este proyecto de análisis de datos simula la evaluación operativa de un sistema de gestión de tráfico y emergencias, utilizando una base de datos de aproximadamente **191,000 registros** (`synthetic_traffic_benchmark_200k`). El objetivo principal fue analizar los factores ambientales, temporales y de severidad asociados a los incidentes viales, así como evaluar la eficiencia operativa de los servicios de emergencia midiendo la desviación entre los tiempos de respuesta esperados y los reales.

## 🛠️ Tecnologías y Herramientas Utilizadas
* **Base de Datos:** MySQL / MySQL Workbench
* **Lenguaje:** SQL (Consultas avanzadas, Agregaciones, Funciones de Ventana/Matemáticas, Vistas)
* **Control de Versiones:** Git & GitHub

---

## 🔍 Estructura del Análisis (Bloques SQL)

El proyecto se desarrolló mediante un enfoque analítico estructurado en bloques:

### 1. Exploración Inicial y Distribución Geográfica / Zonas
* Análisis del volumen total de registros y distribución de incidentes según el tipo de área (`Area_Type`: Urbana, Suburbana, Rural) y el tipo de vía (`Road_Type`).
* **Evidencia:** `01_total_incidentes.png`, `02_incidentes_por_area.png`

### 2. Análisis Temporal y Ambiental
* Evaluación de los incidentes según el momento del día (`Time_of_Day`: Morning Peak, Midday, Evening Peak, Night) y el impacto de las condiciones meteorológicas (`Weather`: Clear, Rain, Snow, Fog).
* **Evidencia:** `03_incidentes_por_momento_dia.png`, `04_impacto_clima.png`

### 3. Severidad y Factores de Riesgo
* Desglose porcentual del nivel de severidad de los accidentes (`Accident_Severity`: No Accident, Minor, Moderate, Severe, Fatal).
* **Evidencia:** `05_severidad_accidentes.png`

### 4. Indicadores de Emergencia y Tiempos de Respuesta
* Comparativa operativa entre el tiempo de respuesta esperado (`Baseline_Expected_Response_Time_min`) y el tiempo real (`Actual_Response_Time_min`) segmentado por la prioridad de despacho (`Dispatch_Priority`).
* **Evidencia:** `06_tiempos_respuesta_emergencia.png`

---

## 👁️ Vistas SQL Reutilizables (Views)
Para optimizar consultas recurrentes y estructurar la base de datos para futuros tableros de BI, se crearon las siguientes vistas:

1. **`vista_resumen_incidentes_area`**: Consolida el total de incidentes y el tiempo promedio de respuesta cruzando el tipo de área y la severidad del accidente.
   * **Evidencia:** `07_vista_resumen_incidentes.png`
2. **`vista_eficiencia_respuestas`**: Agrupa el rendimiento operativo por prioridad de despacho para auditar desviaciones en los tiempos de atención.
   * **Evidencia:** `08_vista_eficiencia_respuestas.png`

---

## 📂 Estructura del Repositorio
```text
├── traffic_emergency_analysis.sql   # Script completo con todas las consultas y vistas
├── README.md                        # Documentación del proyecto
└── screenshots/                     # Capturas de evidencia de ejecución
    ├── 01_total_incidentes.png
    ├── 02_incidentes_por_area.png
    ├── 03_incidentes_por_momento_dia.png
    ├── 04_impacto_clima.png
    ├── 05_severidad_accidentes.png
    ├── 06_tiempos_respuesta_emergencia.png
    ├── 07_vista_resumen_incidentes.png
    └── 08_vista_eficiencia_respuestas.png
