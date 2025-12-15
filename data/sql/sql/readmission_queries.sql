/* 
Project: Healthcare Readmission Risk Analysis
File: readmission_queries.sql

Goal (humanized):
I’m using SQL to explore and summarize readmission outcomes and key clinical/operational factors.
This is the “question answering” layer that a hospital analyst would use for reporting and decision support.
*/


/* ----------------------------------------------------------
   1) Sanity check: how many rows and unique patients?
   Why: In healthcare encounter datasets, one patient can have
   multiple encounters. This tells us the dataset scale and
   whether repeat encounters exist (they do in real hospitals).
----------------------------------------------------------- */

-- Total encounters (each row is a hospital encounter)
SELECT COUNT(*) AS total_encounters
FROM diabetic_data;

-- Unique patients (patient_nbr is de-identified patient ID)
SELECT COUNT(DISTINCT patient_nbr) AS unique_patients
FROM diabetic_data;


/* ----------------------------------------------------------
   2) Readmission distribution
   Why: readmitted is the target/outcome. We want to see how
   many encounters fall into each category:
   - <30  : readmitted within 30 days (high priority)
   - >30  : readmitted after 30 days
   - NO   : not readmitted
----------------------------------------------------------- */

SELECT
  readmitted,
  COUNT(*) AS encounter_count,
  ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM diabetic_data), 2) AS pct_of_total
FROM diabetic_data
GROUP BY readmitted
ORDER BY encounter_count DESC;


/* ----------------------------------------------------------
   3) 30-day readmission rate (main KPI)
   Why: Hospitals often track “30-day readmission rate” because
   it is tied to quality metrics and financial penalties.
   We convert readmitted into a yes/no flag for <30.
----------------------------------------------------------- */

SELECT
  ROUND(
    100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS readmission_rate_30day_pct
FROM diabetic_data;


/* ----------------------------------------------------------
   4) Readmission rate by age group
   Why: Older patients often have higher complexity and risk.
   This helps identify age bands needing extra follow-up.
----------------------------------------------------------- */

SELECT
  age,
  COUNT(*) AS encounters,
  ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*), 2) AS readmit_30day_pct
FROM diabetic_data
GROUP BY age
ORDER BY age;


/* ----------------------------------------------------------
   5) Readmission rate by time in hospital (length of stay)
   Why: Longer stays can reflect severity/complications, which
   may increase readmission risk.
----------------------------------------------------------- */

SELECT
  time_in_hospital,
  COUNT(*) AS encounters,
  ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*), 2) AS readmit_30day_pct
FROM diabetic_data
GROUP BY time_in_hospital
ORDER BY time_in_hospital;


/* ----------------------------------------------------------
   6) Readmission rate by number of medications (simple grouping)
   Why: More medications often means more complexity, potential
   drug interactions, and adherence challenges after discharge.
   We bucket medication counts to make results easier to read.
----------------------------------------------------------- */

SELECT
  CASE
    WHEN num_medications BETWEEN 0 AND 5 THEN '0-5'
    WHEN num_medications BETWEEN 6 AND 10 THEN '6-10'
    WHEN num_medications BETWEEN 11 AND 15 THEN '11-15'
    WHEN num_medications BETWEEN 16 AND 20 THEN '16-20'
    ELSE '21+'
  END AS medication_bucket,
  COUNT(*) AS encounters,
  ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*), 2) AS readmit_30day_pct
FROM diabetic_data
GROUP BY medication_bucket
ORDER BY encounters DESC;


/* ----------------------------------------------------------
   7) Missingness check for key variables
   Why: In real-world healthcare data, missing demographic data
   is common. We quickly estimate “unknown/?” patterns.
   Note: In this dataset, missing often appears as '?'.
----------------------------------------------------------- */

SELECT
  SUM(CASE WHEN race = '?' THEN 1 ELSE 0 END) AS race_missing,
  SUM(CASE WHEN gender IN ('Unknown/Invalid') THEN 1 ELSE 0 END) AS gender_missing,
  COUNT(*) AS total_rows
FROM diabetic_data;
