with products as (

    select * from {{ ref('stg_jaffle_shop__products') }}

),

product_supply_costs as (

    select * from {{ ref('int_product_supply_costs') }}

),

final as (

    select
        products.sku,
        products.product_name,
        products.product_type,
        products.product_description,
        products.product_price as unit_price,
        product_supply_costs.unit_supply_cost,
        round(products.product_price - product_supply_costs.unit_supply_cost, 2)
            as modeled_unit_gross_profit,
        round(
            safe_divide(
                products.product_price - product_supply_costs.unit_supply_cost,
                products.product_price
            ) * 100,
            1
        ) as modeled_unit_gross_margin_pct,
        product_supply_costs.supply_component_count,
        product_supply_costs.has_perishable_supply,
        product_supply_costs.has_nonperishable_supply

    from products
    inner join product_supply_costs using (sku)

)

select * from final
