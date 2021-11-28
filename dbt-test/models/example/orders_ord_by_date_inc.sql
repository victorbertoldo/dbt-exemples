{{ config(materialized='incremental', unique_key='id') }}

select ROW_NUMBER() OVER (Order by o_orderpriority || '|' || l_shipmode) as id
,* from (
select    
    o.o_orderpriority,
    i.l_shipmode,
    sum(i.l_tax) as taxes
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" o
inner join "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."LINEITEM" i
on o.o_orderkey = i.l_orderkey
group by 
    o.o_orderpriority,
    i.l_shipmode)

{% if is_incremental() %}
    and id> (select max(id) from {{ this}})
{% endif %}    