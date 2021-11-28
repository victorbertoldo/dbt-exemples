{{ config(materialized='table') }}

select
    o.o_orderpriority,
    i.l_shipmode,
    sum(i.l_tax) as taxes
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" o
inner join "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."LINEITEM" i
on o.o_orderkey = i.l_orderkey
group by 
    o.o_orderpriority,
    i.l_shipmode