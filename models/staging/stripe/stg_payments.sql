with payments as (
    select * from {{source("stripe","payment")}}
)
select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status as payment_status,
    {{cent_to_dollars('amount')}} as payment_amount,
    created

from payments

