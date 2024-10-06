-- https://cloud.google.com/bigquery/docs/bi-engine-reserve-capacity
-- check biengine capacities

SELECT  *
FROM  `<PROJECT_ID>.region-<REGION>.INFORMATION_SCHEMA.BI_CAPACITIES`;

-- example : SELECT  * FROM `mytestingenv-355509.region-me-west1.INFORMATION_SCHEMA.BI_CAPACITIES`;


-- Create a reservation
ALTER BI_CAPACITY `<PROJECT_ID>.region-<REGION>.default`
SET OPTIONS (
  size_gb = VALUE,
  preferred_tables = <ARRAY<STRING>>);


-- update a reservation to 100g
ALTER BI_CAPACITY `<PROJECT_ID>.region-<REGION>.default`
SET OPTIONS ( size_gb = 100);


-- Delete a reservation
ALTER BI_CAPACITY `<PROJECT_ID>.region-<REGION>.default`
SET OPTIONS ( size_gb = 0);