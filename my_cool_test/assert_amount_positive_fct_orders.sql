select 
    count(*)
from {{ref("fct_orders")}}
where amount <= 0