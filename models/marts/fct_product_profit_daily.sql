with sales_lines as (

    select * from {{ ref('int_sales_lines') }}

),

aggregated as (

    select
        order_date,
        sku,
        sum(units_sold) as units_sold,
        sum(unit_revenue) as revenue,
        sum(unit_supply_cost) as modeled_supply_cost,
        sum(modeled_gross_profit) as modeled_gross_profit,
        round(
            safe_divide(sum(modeled_gross_profit), sum(unit_revenue)) * 100,
            1
        ) as modeled_gross_margin_pct

    from sales_lines
    group by order_date, sku

)

select * from aggregated
