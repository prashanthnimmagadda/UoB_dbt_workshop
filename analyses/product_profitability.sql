-- Reproduces the evidence used in the README and presentation.

with product_performance as (

    select
        fact.sku,
        product.product_name,
        product.product_type,
        product.unit_price,
        product.unit_supply_cost,
        product.modeled_unit_gross_margin_pct,
        sum(fact.units_sold) as units_sold,
        sum(fact.revenue) as revenue,
        sum(fact.modeled_supply_cost) as modeled_supply_cost,
        sum(fact.modeled_gross_profit) as modeled_gross_profit

    from {{ ref('fct_product_profit_daily') }} as fact
    inner join {{ ref('dim_product') }} as product using (sku)
    group by
        fact.sku,
        product.product_name,
        product.product_type,
        product.unit_price,
        product.unit_supply_cost,
        product.modeled_unit_gross_margin_pct

)

select
    *,
    round(
        safe_divide(
            modeled_gross_profit,
            sum(modeled_gross_profit) over ()
        ) * 100,
        1
    ) as gross_profit_share_pct

from product_performance
order by modeled_gross_profit desc
