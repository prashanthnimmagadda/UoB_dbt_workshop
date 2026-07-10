# University Workshop: Product Profitability

This dbt project models Jaffle Shop sales on BigQuery and answers one question:

> Which products generate the most modeled gross profit, and is that result driven by sales volume, unit margin, or both?

The project was built from the [University Workshop Starter](https://github.com/atrivedi-dbtlabs/university_workshop_starter).

## Findings

The analysis covers 997 sold items from 1 to 16 September 2016.

- Item revenue: **$6,818.00**
- Modeled gross profit: **$5,412.28**
- Top product: **BEV-004, for richer or pourover**
- BEV-004 modeled gross profit: **$1,038.24**, or **19.2%** of the total
- Beverage gross profit share: **66.9%**, with an **80.2%** modeled gross margin

BEV-004 wins through both volume and unit economics. It sold 168 units and retained an 88.3% modeled gross margin. JAF-001 has the highest modeled unit margin at 89.0%, but sold only 37 units.

## Recommendation

Protect BEV-004 availability because it is the largest modeled gross-profit contributor. Run a controlled promotion for JAF-001 to test whether its high unit margin can support more volume without reducing sales of stronger products.

## Metric definitions

- One row in `raw_items` represents one unit sold.
- Item revenue equals the product price.
- Unit supply cost equals the sum of all component supply costs assigned to the SKU.
- Modeled gross profit equals revenue minus modeled supply cost.
- Modeled gross margin percentage equals modeled gross profit divided by revenue.

These are modeled gross-profit measures, not net profit. The source data does not include labour, rent, discounts, overhead, or other operating costs.

## Model design

| Layer | Model | Grain | Purpose |
|---|---|---|---|
| Staging | `stg_jaffle_shop__*` | One row per source record | Rename fields, cast types, and convert cents to dollars |
| Intermediate | `int_product_supply_costs` | One row per SKU | Aggregate component supply costs into a modeled unit cost |
| Intermediate | `int_sales_lines` | One row per sold item | Join sales and product data and calculate unit economics |
| Mart | `dim_product` | One row per SKU | Publish product attributes and unit economics |
| Mart | `fct_product_profit_daily` | One row per date and SKU | Publish daily units, revenue, cost, gross profit, and margin |

All model dependencies use `ref()`, so dbt can build and display the full lineage from sources to marts.

## Data quality

The project includes:

- Primary-key `unique` and `not_null` tests
- A composite-grain test for `order_date + sku`
- A business test that reconciles all 686 order subtotals to item revenue
- A business test that checks gross-profit and margin calculations

The subtotal reconciliation currently has zero failures.

## Run the project

The `university_workshop` profile must point to the intended BigQuery project and development dataset.

```bash
dbt debug
dbt deps
dbt parse
dbt build
dbt show --select dim_product --limit 20
dbt show --select fct_product_profit_daily --limit 20
```

The reproducible evidence query is stored in `analyses/product_profitability.sql`. Compile it with dbt, then run the compiled SQL in BigQuery.

## Limitations

- The source contains one store, so store comparisons are not meaningful.
- The analysis covers 16 days and should not be treated as a long-term trend.
- Each item row is treated as one unit because the source has no quantity field.
- Supply costs are modeled as the sum of component costs for each SKU.

## Presentation

The `presentation/` folder contains the editable deck, PDF export, analytical chart, and final Cursor lineage image.
