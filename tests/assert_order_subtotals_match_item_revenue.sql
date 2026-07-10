with item_subtotals as (

    select
        order_id,
        sum(unit_revenue) as calculated_order_subtotal

    from {{ ref('int_sales_lines') }}
    group by order_id

),

orders as (

    select
        order_id,
        order_subtotal

    from {{ ref('stg_jaffle_shop__orders') }}

)

select
    coalesce(orders.order_id, item_subtotals.order_id) as order_id,
    orders.order_subtotal,
    item_subtotals.calculated_order_subtotal

from orders
full outer join item_subtotals using (order_id)
where
    orders.order_id is null
    or item_subtotals.order_id is null
    or orders.order_subtotal != item_subtotals.calculated_order_subtotal
