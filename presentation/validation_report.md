# Product Profitability Mart Validation

Validated on 10 July 2026 from branch `workshop/product-profit-mart` against BigQuery project `dbt-labs-501712` and dataset `uob_dbt_workshop`.

## dbt checks

| Check | Result |
|---|---|
| `dbt debug` | Passed, including the BigQuery connection |
| `dbt deps` | Installed `dbt-labs/codegen` 0.14.1 and `dbt-labs/dbt_utils` 1.4.1 |
| `dbt parse` | Passed |
| `dbt build` | Passed 38 of 38 nodes: 10 models, 22 tests, and 6 seeds |
| Focused mart and business tests | Passed 7 of 7 |
| `dbt show --select dim_product` | Passed |
| `dbt show --select fct_product_profit_daily` | Passed |
| `dbt compile --select product_profitability` | Passed |

## BigQuery checks

| Relation or measure | Verified result |
|---|---:|
| `dim_product` rows | 10 |
| Distinct `dim_product.sku` values | 10 |
| `fct_product_profit_daily` rows | 152 |
| Distinct `order_date + sku` values | 152 |
| Units sold | 997 |
| Item revenue | $6,818.00 |
| Modeled supply cost | $1,405.72 |
| Modeled gross profit | $5,412.28 |
| Reconciled order subtotals | 686 of 686 |

The four new BigQuery relations are views. The final fact grain is exactly one row per `order_date + sku`, and the dimension grain is exactly one row per SKU.

## Evidence used in the presentation

- BEV-004 sold 168 units and generated $1,038.24 of modeled gross profit, equal to 19.2% of the total.
- Beverage products generated 66.9% of modeled gross profit at an 80.2% modeled gross margin.
- JAF-001 had the highest unit gross margin at 89.0% but sold 37 units.
- The analysis period is 1 to 16 September 2016.

## Lineage and presentation QA

Cursor lineage shows the relevant raw sources, six staging models, both intermediate models, the final fact model, and the saved analysis. The PowerPoint passed the automated overflow check. The four-slide PDF was rendered and visually reviewed page by page.

## Known limitations

- Modeled gross profit subtracts component supply costs only. It excludes labour, rent, discounts, overhead, tax, and other operating costs.
- The data covers 16 days and should not be treated as a long-term trend.
- The data contains one store, so store comparison is not supported.
- Each row in `raw_items` is treated as one unit sold.
