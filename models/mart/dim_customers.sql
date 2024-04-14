{{config(
    required_tests = None
)}}

with customers as (
    select * from {{ref("stg_customers")}}
),

orders as (
    select * from {{ref("stg_orders")}}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        count(*) as number_of_orders,
        sum(fct_orders.amount) as lifetime_value
    from {{ref("stg_orders")}} 
    left join {{ref("fct_orders")}} using(order_id)
    group by customer_id
),

final as (
    select 
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.last_order_date,
        coalesce(customer_orders.number_of_orders, 0) as numbers_of_orders,
        coalesce (customer_orders.lifetime_value, 0) as lifetime_value
    from customers 
    left join customer_orders using (customer_id)
)

select * from final

