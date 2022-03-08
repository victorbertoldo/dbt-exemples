{{ config(materialized='table') }}


SELECT
    c.c_custkey,
    c.c_name,
    c.c_nationkey as nation,
    sum(o.o_totalprice) as total_order_price
from  {{ source('example_source', 'customer') }} c
LEFT JOIN {{ source('example_source', 'orders') }} o
ON c.c_custkey = o.o_custkey

{{group_by(3)}}