CREATE OR REPLACE VIEW public.vw_customer_analytics AS

SELECT
    "CLIENTNUM" AS client_num,

    "Attrition_Flag" AS attrition_status,

    CASE
        WHEN "Attrition_Flag" = 'Attrited Customer' THEN 1
        ELSE 0
    END AS attrited_flag,

    "Customer_Age" AS customer_age,

    "Gender" AS gender,

    "Dependent_count" AS dependent_count,

    "Education_Level" AS education_level,

    "Marital_Status" AS marital_status,

    "Income_Category" AS income_category,

    "Card_Category" AS card_category,

    "Months_on_book" AS months_on_book,

    "Total_Relationship_Count" AS relationship_count,

    "Months_Inactive_12_mon" AS inactive_months,

    "Contacts_Count_12_mon" AS contacts_count,

    "Credit_Limit" AS credit_limit,

    "Total_Revolving_Bal" AS revolving_balance,

    "Avg_Open_To_Buy" AS avg_open_to_buy,

    "Total_Amt_Chng_Q4_Q1" AS transaction_amount_change,

    "Total_Trans_Amt" AS total_transaction_amount,

    "Total_Trans_Ct" AS total_transaction_count,

    "Total_Ct_Chng_Q4_Q1" AS transaction_count_change,

    "Avg_Utilization_Ratio" AS utilization_ratio

FROM public.bank_churners;