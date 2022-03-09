{{ config(materialized='table') }}

select 
    distinct o_orderdate,
    sum(O_TOTALPRICE) over (order by o_orderdate asc) as total_sales
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"

{% if target.name == 'dev' %}
where year(o_orderdate) = 2018
{% endif %}


order by o_orderdate asc