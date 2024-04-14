{{config(
    severity = 'warn',
    warn_if = '>30',
    store_failures = true)}}
-- new comment to test CI with dbt
select 
    order_id,
    count(*) as number
from {{ref("stg_payments")}}
group by order_id
having sum(payment_amount) <= 0 