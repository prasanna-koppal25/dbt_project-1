SELECT *
FROM {{ ref('modified_asset') }}
WHERE account_status NOT IN ('APPROVED', 'REJECTED', 'PENDING')