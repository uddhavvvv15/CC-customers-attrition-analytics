CREATE OR REPLACE VIEW public.vw_attrition_by_inactivity AS

SELECT
    inactive_months,

    COUNT(*) AS total_customers,

    SUM(attrited_flag) AS attrited_customers,

    COUNT(*) - SUM(attrited_flag) AS existing_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate

FROM public.vw_customer_analytics

GROUP BY inactive_months

ORDER BY inactive_months;

CREATE OR REPLACE VIEW public.vw_attrition_by_relationship AS

SELECT
    relationship_count,

    COUNT(*) AS total_customers,

    SUM(attrited_flag) AS attrited_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate

FROM public.vw_customer_analytics

GROUP BY relationship_count

ORDER BY relationship_count;


CREATE OR REPLACE VIEW public.vw_attrition_by_card AS

SELECT
    card_category,

    COUNT(*) AS total_customers,

    SUM(attrited_flag) AS attrited_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate,

    ROUND(
        AVG(credit_limit)::numeric,
        2
    ) AS avg_credit_limit,

    ROUND(
        AVG(total_transaction_count)::numeric,
        2
    ) AS avg_transaction_count

FROM public.vw_customer_analytics

GROUP BY card_category

ORDER BY attrition_rate DESC;


CREATE OR REPLACE VIEW public.vw_transaction_comparison AS

SELECT
    attrition_status,

    COUNT(*) AS customers,

    ROUND(
        AVG(total_transaction_count)::numeric,
        2
    ) AS avg_transaction_count,

    ROUND(
        AVG(total_transaction_amount)::numeric,
        2
    ) AS avg_transaction_amount,

    ROUND(
        AVG(transaction_count_change)::numeric,
        4
    ) AS avg_transaction_count_change,

    ROUND(
        AVG(transaction_amount_change)::numeric,
        4
    ) AS avg_transaction_amount_change,

    ROUND(
        AVG(inactive_months)::numeric,
        2
    ) AS avg_inactive_months,

    ROUND(
        AVG(utilization_ratio)::numeric,
        4
    ) AS avg_utilization

FROM public.vw_customer_analytics

GROUP BY attrition_status;


CREATE OR REPLACE VIEW public.vw_customer_engagement_segments AS

WITH customer_quartiles AS (

    SELECT
        *,

        NTILE(4) OVER (
            ORDER BY total_transaction_count
        ) AS activity_quartile

    FROM public.vw_customer_analytics
)

SELECT
    client_num,
    attrition_status,
    attrited_flag,

    customer_age,
    gender,
    income_category,
    card_category,

    inactive_months,
    relationship_count,

    total_transaction_count,
    total_transaction_amount,

    transaction_count_change,
    transaction_amount_change,

    utilization_ratio,
    credit_limit,

    CASE
        WHEN activity_quartile = 1 THEN 'Low Activity'
        WHEN activity_quartile = 2 THEN 'Lower-Mid Activity'
        WHEN activity_quartile = 3 THEN 'Upper-Mid Activity'
        WHEN activity_quartile = 4 THEN 'High Activity'
    END AS engagement_segment,

    CASE
        WHEN transaction_count_change < 1
            THEN 'Declining Activity'
        ELSE 'Stable or Increasing Activity'
    END AS activity_trend

FROM customer_quartiles;




CREATE OR REPLACE VIEW public.vw_segment_attrition_summary AS

SELECT
    engagement_segment,
    activity_trend,

    COUNT(*) AS total_customers,

    SUM(attrited_flag) AS attrited_customers,

    COUNT(*) - SUM(attrited_flag) AS existing_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate,

    ROUND(
        AVG(total_transaction_count)::numeric,
        2
    ) AS avg_transaction_count,

    ROUND(
        AVG(total_transaction_amount)::numeric,
        2
    ) AS avg_transaction_amount,

    ROUND(
        AVG(inactive_months)::numeric,
        2
    ) AS avg_inactive_months

FROM public.vw_customer_engagement_segments

GROUP BY
    engagement_segment,
    activity_trend;



SELECT
    engagement_segment,
    activity_trend,
    COUNT(*) AS customers,
    SUM(attrited_flag) AS attrited_customers,
    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate
FROM public.vw_customer_engagement_segments
GROUP BY
    engagement_segment,
    activity_trend
ORDER BY
    engagement_segment,
    activity_trend;


CREATE OR REPLACE VIEW public.vw_attrition_by_profile AS

SELECT
    card_category,
    income_category,

    COUNT(*) AS total_customers,

    SUM(attrited_flag) AS attrited_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate,

    ROUND(
        AVG(total_transaction_count)::numeric,
        2
    ) AS avg_transaction_count,

    ROUND(
        AVG(inactive_months)::numeric,
        2
    ) AS avg_inactive_months,

    ROUND(
        AVG(credit_limit)::numeric,
        2
    ) AS avg_credit_limit

FROM public.vw_customer_analytics

GROUP BY
    card_category,
    income_category;




CREATE OR REPLACE VIEW public.vw_powerbi_customer_dataset AS

SELECT
    c.*,

    s.engagement_segment,

    s.activity_trend

FROM public.vw_customer_analytics c

LEFT JOIN public.vw_customer_engagement_segments s

    ON c.client_num = s.client_num;
    
    
    
    
    SELECT
    COUNT(*) AS total_rows,

    COUNT(DISTINCT client_num) AS unique_customers,

    SUM(attrited_flag) AS attrited_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate

FROM public.vw_powerbi_customer_dataset;


SELECT *
FROM public.vw_powerbi_customer_dataset
LIMIT 10;


SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT client_num) AS unique_customers,
    SUM(attrited_flag) AS attrited_customers,
    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate
FROM public.vw_powerbi_customer_dataset;