with
    payments as (select * from {{ ref("stg_stripe__payments") }}),
    orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),
    order_payment as (select
    orderid,
    sum(case when status = 'success' then amount end) as amount
    from {{ ref('stg_stripe__payments') }} group by 1),
final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (order_payment.amount, 0) as amount

    from orders
    left join order_payment on orders.order_id = order_payment.orderid
)

select * from final