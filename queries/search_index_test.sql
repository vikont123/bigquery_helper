-- https://cloud.google.com/bigquery/docs/search

CREATE TABLE search_ds.Logs (Level STRING, Source STRING, Message STRING)
AS (
  SELECT 'INFO' as Level, '65.177.8.234' as Source, 'Entry Foo-Bar created' as Message
  UNION ALL
  SELECT 'WARNING', '132.249.240.10', 'Entry Foo-Bar already exists, created by 65.177.8.234'
  UNION ALL
  SELECT 'INFO', '94.60.64.181', 'Entry Foo-Bar deleted'
  UNION ALL
  SELECT 'SEVERE', '4.113.82.10', 'Entry Foo-Bar does not exist, deleted by 94.60.64.181'
  UNION ALL
  SELECT 'INFO', '181.94.60.64', 'Entry Foo-Baz created'
);

select * from search_ds.Logs;

CREATE SEARCH INDEX my_index ON search_ds.Logs(ALL COLUMNS);

SELECT * FROM search_ds.Logs WHERE SEARCH(Logs, 'bar');

SELECT * FROM search_ds.Logs WHERE SEARCH(Logs, '94.60.64.181');

SELECT * FROM search_ds.Logs WHERE SEARCH(Logs, '`94.60.64.181`');  -- an exact search

SELECT * FROM search_ds.Logs WHERE SEARCH(Message, '`94.60.64.181`');

SELECT * FROM search_ds.Logs WHERE SEARCH((Source, Message), '`94.60.64.181`');
