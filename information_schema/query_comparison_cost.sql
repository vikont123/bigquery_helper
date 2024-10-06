
WITH
  src AS (
  SELECT
    project_id AS project_id,
    job_type,
    query,
    start_time AS start_time,
    end_time AS end_time,
    TIMESTAMP_DIFF(end_time, start_time, MILLISECOND) AS execution_time_ms,
    total_slot_ms AS total_slot_ms,
    ROUND(SAFE_DIVIDE(total_slot_ms, TIMESTAMP_DIFF(end_time, start_time, MILLISECOND)), 2) AS avg_slot_count,
    ROUND(COALESCE(total_bytes_billed,0), 2) AS total_bytes_billed,
    --ROUND(COALESCE(total_bytes_billed,0) / POW(1024, 2), 2) AS total_megabytes_billed,
    --ROUND(COALESCE(total_bytes_billed,0) / POW(1024, 3), 2) AS total_gigabytes_billed,
    ROUND(COALESCE(total_bytes_billed,0) / POW(1024, 4), 2) AS total_terabytes_billed,
  FROM `mytestingenv-355509`.`region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
  WHERE creation_time BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 14 DAY)
    AND CURRENT_TIMESTAMP()
    AND total_slot_ms IS NOT NULL
    AND state = "DONE"
    AND job_type = "QUERY"
  ),
  rounded AS (
    SELECT
      *,
      -- Rounds up to the nearest 100 slots
      floor((CEIL(avg_slot_count) + 99) / 100) * 100 AS rounded_to_100_slots,
      -- If query ran in under 1 minute (60 seconds * 1000 ms) then round up to 1 minute
      IF(execution_time_ms < 1000*60, 1000*60, execution_time_ms) AS billed_duration_ms,
      -- Calculates the duration in hours for calculating slot/hours used
      -- Formula: (Execution Time in ms)/(1000 ms * 60 seconds * 60 minutes)
      IF(execution_time_ms < 1000*60, 1000*60, execution_time_ms)/(1000*60*60) AS billed_duration_hour
    FROM src
  )  ,
  costs AS (
    SELECT *,
      total_terabytes_billed * 6.25 AS onDemand_cost,
      billed_duration_hour * 0.04 AS standard_edition_cost,
      billed_duration_hour * 0.06 AS enterprise_edition_cost,
      billed_duration_hour * 0.048 AS enterprise_edition_1y_cost,
      billed_duration_hour * 0.036 AS enterprise_Edition_3y_cost,
      billed_duration_hour * 0.1 AS enterprisePlus_edition_cost,
      billed_duration_hour * 0.08 AS enterprisePlus_edition_1y_cost,
      billed_duration_hour * 0.06 AS enterprisePlus_edition_3y_cost
    FROM
      rounded
  )
SELECT
  * ,
  IF(onDemand_cost - standard_edition_cost < 0, 'On-demand', 'Standard Edition') AS standardEditionRecommendation,
  IF(onDemand_cost - enterprise_edition_cost < 0, 'On-demand', 'Enterprise Edition') AS enterpriseEditionRecommendation,
  IF(onDemand_cost - enterprise_edition_1y_cost < 0, 'On-demand', 'Enterprise Edition 1 Year Commit') AS enterpriseEdition1YearRecommendation,
  IF(onDemand_cost - enterprise_edition_3y_cost < 0, 'On-demand', 'Enterprise Edition 3 Year Commit') AS enterpriseEdition3YearRecommendation
FROM costs
ORDER BY  start_time
  
 
