{{ config(materialized='incremental', unique_key='id') }}

with aggr as (
select ROW_NUMBER() OVER (Order by a.id) as id,
    a.o_orderpriority,
    a.l_shipmode,
    a.taxes
from (
    select 
        (o.o_orderpriority || '|' ||  i.l_shipmode) as id,
        o.o_orderpriority,
        i.l_shipmode,
        sum(i.l_tax) as taxes
    from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" o
    inner join "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."LINEITEM" i
    on o.o_orderkey = i.l_orderkey
    group by 
        (o.o_orderpriority || '|' ||  i.l_shipmode),
        o.o_orderpriority,
        i.l_shipmode) a
    
)    
select *
from aggr

{% if is_incremental() %}
    where id > (select max(id) from {{ this}})
{% endif %}    