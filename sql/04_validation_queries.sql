SELECT *
FROM public.vw_customer_analytics
LIMIT 10;
SELECT
    COUNT(*) AS total_customers,

    COUNT(DISTINCT client_num) AS unique_customers,

    SUM(attrited_flag) AS attrited_customers,

    ROUND(
        AVG(attrited_flag)::numeric * 100,
        2
    ) AS attrition_rate

FROM public.vw_customer_analytics;

SELECT *
FROM public.vw_attrition_by_inactivity;