with items as (

    select * from {{ ref('stg_jaffle_shop__items') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

products as (

    select * from {{ ref('stg_jaffle_shop__products') }}

),

product_supply_costs as (

    select * from {{ ref('int_product_supply_costs') }}

),

joined as (

    select
        items.item_id,
        items.order_id,
        orders.customer_id,
        orders.store_id,
        orders.ordered_at,
        orders.order_date,
        items.sku,
        products.product_name,
        products.product_type,
        1 as units_sold,
        products.product_price as unit_revenue,
        product_supply_costs.unit_supply_cost,
        round(products.product_price - product_supply_costs.unit_supply_cost, 2)
            as modeled_gross_profit,
        round(
            safe_divide(
                products.product_price - product_supply_costs.unit_supply_cost,
                products.product_price
            ) * 100,
            1
        ) as modeled_gross_margin_pct

    from items
    inner join orders using (order_id)
    inner join products using (sku)
    inner join product_supply_costs using (sku)

)

select * from joined
