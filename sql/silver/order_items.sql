CREATE OR REPLACE TABLE
    `de-gcp-medallion-lab.silver.order_items`
AS

SELECT
    id,
    order_id,
    user_id,
    product_id,
    inventory_item_id,
    UPPER(TRIM(status)) AS status,
    DATE(created_at) AS order_date,
    created_at,
    shipped_at,
    delivered_at,
    returned_at,
    ROUND(CAST(sale_price AS NUMERIC), 2) AS sale_price,
    CURRENT_TIMESTAMP() AS processed_at,
    'THELOOK' AS source_system

FROM
    `de-gcp-medallion-lab.bronze.order_items`

WHERE
    id IS NOT NULL
    AND order_id IS NOT NULL
    AND user_id IS NOT NULL
    AND product_id IS NOT NULL
    AND sale_price >= 0;
