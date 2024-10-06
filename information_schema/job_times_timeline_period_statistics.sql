
  SELECT
  period_start,
  DIV(UNIX_MILLIS(period_start), 3600000 * 1) * 3600000 * 1 AS time_ms,
  SUM(period_slot_ms) AS total_slot_ms,
  SUM(IF(state = "PENDING", 1, 0)) as PENDING,
  SUM(IF(state = "RUNNING", 1, 0)) as RUNNING, 
  SUM(IF(state = "DONE", 1, 0)) as DONE,
  SUM(IF(state = "CANCELLED", 1, 0)) as CANCELLED,
  SUM(IF(state = "FAILED", 1, 0)) as FAILED  
FROM `region-us`.INFORMATION_SCHEMA.JOBS_TIMELINE
WHERE -- period_start BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY) AND CURRENT_TIMESTAMP() and 
 project_id = 'mytestingenv-355509' and job_id = '0481ceee-f37d-46bc-b9d7-39d41ffd77da'
GROUP BY  1,2
ORDER BY period_start DESC;