with supplies as (

    select * from {{ ref('stg_jaffle_shop__supplies') }}

),

aggregated as (

    select
        sku,
        count(*) as supply_component_count,
        sum(supply_cost) as unit_supply_cost,
        countif(is_perishable) > 0 as has_perishable_supply,
        countif(not is_perishable) > 0 as has_nonperishable_supply

    from supplies
    group by sku

)

select * from aggregated
