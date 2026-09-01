CREATE OR REPLACE TABLE
    `de-gcp-medallion-lab.silver.orders`
AS

SELECT
    order_id,
    user_id,
    UPPER(TRIM(status)) AS status,
    UPPER(TRIM(gender)) AS gender,
    created_at,
    shipped_at,
    delivered_at,
    returned_at,
    num_of_item,
    DATE(created_at) AS order_date,
    CURRENT_TIMESTAMP() AS processed_at

FROM
    `de-gcp-medallion-lab.bronze.orders`

WHERE
    order_id IS NOT NULL
    AND user_id IS NOT NULL
    AND created_at IS NOT NULL;
