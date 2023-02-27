-- this query will verify the percentage of null values on a field table


SELECT
    sum(case when id is null then 1 else 0 end) / count(*) as total_nulls
FROM {{ref('test_first_dbt_model')}}
having sum(case when id is null then 1 else 0 end) / count(*) <= 0.1