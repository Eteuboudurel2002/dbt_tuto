{{config(
    severity = 'error',
    store_failures = true)}}
-- comment
select 
    order_id,
    count(*) as number
from {{ref("stg_payments")}}
group by order_id
having sum(payment_amount) <= 0 