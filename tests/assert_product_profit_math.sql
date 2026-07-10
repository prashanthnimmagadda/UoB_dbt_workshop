select
    order_date,
    sku,
    units_sold,
    revenue,
    modeled_supply_cost,
    modeled_gross_profit,
    modeled_gross_margin_pct

from {{ ref('fct_product_profit_daily') }}
where
    units_sold <= 0
    or revenue < 0
    or modeled_supply_cost < 0
    or modeled_gross_profit != round(revenue - modeled_supply_cost, 2)
    or modeled_gross_margin_pct != round(
        safe_divide(modeled_gross_profit, revenue) * 100,
        1
    )
