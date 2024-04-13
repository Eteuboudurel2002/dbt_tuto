with orders as (
    select * from {{ref("stg_orders")}}
),
payments as (
    select * from {{ref("stg_payments")}}
),
amount_orders as (
    select 
        order_id,
        sum(case when payment_status = 'success' then payment_amount end) as amount
    from {{ref("stg_payments")}}
    group by 1

),

final as (
    select 
        orders.order_id,
        orders.customer_id,
        coalesce (amount_orders.amount, 0) as amount
    from orders
    left join amount_orders using(order_id)

)

select * from final