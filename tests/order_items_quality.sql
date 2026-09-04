-- 1. Reconciliação de volume Bronze x Silver

SELECT
    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.bronze.order_items`) AS bronze_count,

    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.silver.order_items`) AS silver_count,

    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.bronze.order_items`)
    -
    (SELECT COUNT(*)
     FROM `de-gcp-medallion-lab.silver.order_items`) AS difference;


-- 2. Unicidade da chave

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS unique_ids,
    COUNT(*) - COUNT(DISTINCT id) AS duplicated_ids
FROM
    `de-gcp-medallion-lab.silver.order_items`;


-- 3. Integridade com orders

SELECT
    COUNT(*) AS orphan_order_items
FROM
    `de-gcp-medallion-lab.silver.order_items` oi

LEFT JOIN
    `de-gcp-medallion-lab.silver.orders` o
    ON oi.order_id = o.order_id

WHERE
    o.order_id IS NULL;


-- 4. Preços inválidos

SELECT
    COUNTIF(sale_price < 0) AS invalid_prices
FROM
    `de-gcp-medallion-lab.silver.order_items`;


-- 5. Reconciliação financeira

SELECT
    ROUND(
        (SELECT SUM(CAST(sale_price AS NUMERIC))
         FROM `de-gcp-medallion-lab.bronze.order_items`),
        2
    ) AS bronze_sales,

    ROUND(
        (SELECT SUM(sale_price)
         FROM `de-gcp-medallion-lab.silver.order_items`),
        2
    ) AS silver_sales;
