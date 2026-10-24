SELECT COUNT(*) AS total_customers
FROM bank_churners;
SELECT
    "CLIENTNUM",
    COUNT(*) AS record_count
FROM bank_churners
GROUP BY "CLIENTNUM"
HAVING COUNT(*) > 1;
SELECT
    "Attrition_Flag",
    COUNT(*) AS customers,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_customers
FROM bank_churners
GROUP BY "Attrition_Flag"
ORDER BY customers DESC;
SELECT
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE "Attrition_Flag" = 'Attrited Customer'
    ) AS attrited_customers,

    COUNT(*) FILTER (
        WHERE "Attrition_Flag" = 'Existing Customer'
    ) AS existing_customers,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE "Attrition_Flag" = 'Attrited Customer'
            ) / COUNT(*)
        )::numeric,
        2
    ) AS attrition_rate,

    ROUND(AVG("Customer_Age")::numeric, 2) AS avg_customer_age,

    ROUND(AVG("Credit_Limit")::numeric, 2) AS avg_credit_limit,

    ROUND(AVG("Total_Trans_Amt")::numeric, 2) AS avg_transaction_amount,

    ROUND(AVG("Total_Trans_Ct")::numeric, 2) AS avg_transaction_count,

    ROUND(AVG("Avg_Utilization_Ratio")::numeric, 4) AS avg_utilization_ratio

FROM bank_churners;
SELECT
    "Attrition_Flag",

    COUNT(*) AS customers,

    ROUND(AVG("Customer_Age")::numeric, 2) AS avg_age,

    ROUND(AVG("Months_on_book")::numeric, 2) AS avg_months_on_book,

    ROUND(AVG("Total_Relationship_Count")::numeric, 2) AS avg_relationship_count,

    ROUND(AVG("Months_Inactive_12_mon")::numeric, 2) AS avg_inactive_months,

    ROUND(AVG("Contacts_Count_12_mon")::numeric, 2) AS avg_contacts,

    ROUND(AVG("Credit_Limit")::numeric, 2) AS avg_credit_limit,

    ROUND(AVG("Total_Revolving_Bal")::numeric, 2) AS avg_revolving_balance,

    ROUND(AVG("Avg_Open_To_Buy")::numeric, 2) AS avg_open_to_buy,

    ROUND(AVG("Total_Trans_Amt")::numeric, 2) AS avg_transaction_amount,

    ROUND(AVG("Total_Trans_Ct")::numeric, 2) AS avg_transaction_count,

    ROUND(AVG("Avg_Utilization_Ratio")::numeric, 4) AS avg_utilization

FROM bank_churners

GROUP BY "Attrition_Flag"

ORDER BY "Attrition_Flag";
SELECT
    "Months_Inactive_12_mon" AS inactive_months,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE "Attrition_Flag" = 'Attrited Customer'
    ) AS attrited_customers,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE "Attrition_Flag" = 'Attrited Customer'
            ) / COUNT(*)
        )::numeric,
        2
    ) AS attrition_rate

FROM bank_churners

GROUP BY "Months_Inactive_12_mon"

ORDER BY inactive_months;
SELECT
    "Attrition_Flag",

    COUNT(*) AS customers,

    ROUND(AVG("Total_Trans_Ct")::numeric, 2)
        AS avg_transaction_count,

    ROUND(AVG("Total_Trans_Amt")::numeric, 2)
        AS avg_transaction_amount,

    ROUND(AVG("Total_Ct_Chng_Q4_Q1")::numeric, 4)
        AS avg_transaction_count_change,

    ROUND(AVG("Total_Amt_Chng_Q4_Q1")::numeric, 4)
        AS avg_transaction_amount_change

FROM bank_churners

GROUP BY "Attrition_Flag";
SELECT
    "Total_Relationship_Count" AS relationship_count,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE "Attrition_Flag" = 'Attrited Customer'
    ) AS attrited_customers,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE "Attrition_Flag" = 'Attrited Customer'
            ) / COUNT(*)
        )::numeric,
        2
    ) AS attrition_rate

FROM bank_churners

GROUP BY "Total_Relationship_Count"

ORDER BY relationship_count;
SELECT
    "Attrition_Flag",

    COUNT(*) AS customers,

    ROUND(AVG("Avg_Utilization_Ratio")::numeric, 4)
        AS avg_utilization,

    ROUND(
        MIN("Avg_Utilization_Ratio")::numeric,
        4
    ) AS min_utilization,

    ROUND(
        MAX("Avg_Utilization_Ratio")::numeric,
        4
    ) AS max_utilization

FROM bank_churners

GROUP BY "Attrition_Flag";


