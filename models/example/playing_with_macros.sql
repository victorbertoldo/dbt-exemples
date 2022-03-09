select 
    c_custkey, 
    c_mktsegment,
    {{ renaming_segments('c_mktsegment') }} mkt_segment_ajusted
from {{ source('example_source', 'customer') }}