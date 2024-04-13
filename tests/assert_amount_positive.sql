{{config(
    severity = 'warn')}}
select 
    order_id,
     count(*)
from {{ref("stg_payments")}}
group by order_id
having sum(payment_amount) <= 0 