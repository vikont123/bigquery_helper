SELECT
  dataset_id,
  table_id,
  -- convert bytes to GB
  ROUND(size_bytes/pow(10,9),2) as size_gb,
  row_count,
  -- Convert UNIX EPOCH to a timestamp.
  TIMESTAMP_MILLIS(creation_time) AS creation_time,
  TIMESTAMP_MILLIS(last_modified_time) as last_modified_time,
  CASE
    WHEN type = 1 THEN 'table'
    WHEN type = 2 THEN 'view'
  ELSE NULL
  END AS type
FROM
  -- XXX: replace bigquery-public-data.github_repos with myproject.mydataset
  `bigquery-public-data.github_repos.__TABLES__`
ORDER BY
  size_gb DESC;