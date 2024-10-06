-- https://cloud.google.com/bigquery/docs/reference/standard-sql/aead_encryption_functions
-- https://cloud.google.com/bigquery/docs/aead-encryption-concepts
-- https://cloud.google.com/bigquery/docs/column-key-encrypt

CREATE or replace TABLE aead_encryp.RawCustomerData AS
SELECT
  1 AS customer_id,
  b'jaguar' AS b_favorite_animal,
  'jaguar' AS favorite_animal
UNION ALL
SELECT
  2 AS customer_id,
  b'zebra' AS favorite_animal,
  'zebra' AS b_favorite_animal
UNION ALL
SELECT
  3 AS customer_id,
  b'zebra' AS b_favorite_animal,
  'zebra' AS favorite_animal;

  ----
  select * from aead_encryp.RawCustomerData;
  --

-- gcloud kms keyrings create "mytestkeyrings" --location "us"
-- gcloud kms keys create "mytestkey"  --location "us"  --keyring "mytestkeyrings" --purpose "encryption"
-- gcloud kms keys list  --location "us"  --keyring "mytestkeyrings"
-- -->>> projects/mytestingenv-355509/locations/us/keyRings/mytestkeyrings/cryptoKeys/mytestkey

SELECT KEYS.NEW_WRAPPED_KEYSET("gcp-kms://projects/mytestingenv-355509/locations/us/keyRings/mytestkeyrings/cryptoKeys/mytestkey", "AEAD_AES_GCM_256");
-- 1	CiQAydOFOqkvBuoRhL/2uStkxGGnpGLJMNXExzgq1ERbvT76Ma0SlQEAQoDhdQVa5lmZpVIbUnaTE7ECRxJXy9nkKx1fGg4KbRr37jS8MxoMHQHDiyw4u8Ei8HXM9CzNvBoY8pgeiB2Xdzv1jjMJcjbG5WGfzHZeT8HGI5ME/7qXiGKbIGG0VH/rl+TgxFSWsCeh4Z1mq6HFdhBb8gZFSsrf7A0r3hu7+rDOkej001ilyz0TF+euXB28ghagvA==

DECLARE kms_resource_name STRING;
DECLARE KEY BYTES;
SET kms_resource_name = 'gcp-kms://projects/mytestingenv-355509/locations/us/keyRings/mytestkeyrings/cryptoKeys/mytestkey';
SET KEY = (SELECT FROM_BASE64("CiQAydOFOqkvBuoRhL/2uStkxGGnpGLJMNXExzgq1ERbvT76Ma0SlQEAQoDhdQVa5lmZpVIbUnaTE7ECRxJXy9nkKx1fGg4KbRr37jS8MxoMHQHDiyw4u8Ei8HXM9CzNvBoY8pgeiB2Xdzv1jjMJcjbG5WGfzHZeT8HGI5ME/7qXiGKbIGG0VH/rl+TgxFSWsCeh4Z1mq6HFdhBb8gZFSsrf7A0r3hu7+rDOkej001ilyz0TF+euXB28ghagvA=="));


CREATE TABLE aead_encryp.EncryptedCustomerData AS
SELECT
  customer_id,
  AEAD.ENCRYPT(
    KEYS.KEYSET_CHAIN(kms_resource_name, KEY),
    b_favorite_animal,
    CAST(CAST(customer_id AS STRING) AS BYTES)
  ) AS encrypted_animal
FROM
  aead_encryp.RawCustomerData;

select * from aead_encryp.EncryptedCustomerData 

-- The following query uses the first_level_keyset to decrypt data in the EncryptedCustomerData table.
DECLARE kms_resource_name STRING;
DECLARE KEY BYTES;
SET kms_resource_name = 'gcp-kms://projects/mytestingenv-355509/locations/us/keyRings/mytestkeyrings/cryptoKeys/mytestkey';
SET KEY = (SELECT FROM_BASE64("CiQAydOFOqkvBuoRhL/2uStkxGGnpGLJMNXExzgq1ERbvT76Ma0SlQEAQoDhdQVa5lmZpVIbUnaTE7ECRxJXy9nkKx1fGg4KbRr37jS8MxoMHQHDiyw4u8Ei8HXM9CzNvBoY8pgeiB2Xdzv1jjMJcjbG5WGfzHZeT8HGI5ME/7qXiGKbIGG0VH/rl+TgxFSWsCeh4Z1mq6HFdhBb8gZFSsrf7A0r3hu7+rDOkej001ilyz0TF+euXB28ghagvA=="));


SELECT
  customer_id,cast(
  AEAD.DECRYPT_BYTES(
    KEYS.KEYSET_CHAIN(kms_resource_name, KEY),
    encrypted_animal,
    CAST(CAST(customer_id AS STRING) AS BYTES)
  ) as string) AS favorite_animal
FROM aead_encryp.EncryptedCustomerData;
