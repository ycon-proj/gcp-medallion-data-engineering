-- Validação de volume Bronze x Silver

SELECT
    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.bronze.orders`) AS bronze_count,

    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.silver.orders`) AS silver_count,

    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.bronze.orders`)
    -
    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.silver.orders`) AS difference;


-- Validação de unicidade da chave

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicated_orders
FROM
    `de-gcp-medallion-lab.silver.orders`;
