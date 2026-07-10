# Product Profitability Presentation Script

## Slide 1

The question is: which products generate the most modeled gross profit, and is that driven by sales volume, unit margin, or both?

In this project, each item row is one unit sold. Revenue is the product price. Modeled gross profit is revenue minus the component supply costs assigned to the product. It does not include labour, rent, discounts, or overhead.

The data contains 997 items sold over sixteen days. Those items generated $6,818 in revenue and $5,412.28 in modeled gross profit.

## Slide 2

dbt turns the raw data into a clear, repeatable pipeline. The source function connects the project to the raw items, orders, products, and supplies tables. The staging models rename fields, cast data types, and standardise the source data.

The intermediate models then use ref to connect the cleaned models. One model calculates supply cost by SKU. The other joins each sold item to its order, product, and cost data. The final dimension gives one row per product, and the fact model gives one row per date and SKU.

Using source and ref lets dbt build the models in the correct order and creates the lineage shown here. It also makes each result traceable back to the raw tables.

## Slide 3

The mart output is used directly for this chart. The x-axis shows units sold, the y-axis shows modeled gross margin, and bubble size shows total modeled gross profit.

BEV-004 performs well on both volume and margin. It sold 168 units, had an 88.3 percent modeled margin, and generated $1,038.24 in modeled gross profit. That is 19.2 percent of the total.

JAF-001 has the highest modeled margin at 89 percent, but sold only 37 units. This gives us a product with strong unit economics but lower sales volume.

## Slide 4

The recommendation is to protect BEV-004 availability and run a controlled promotion for JAF-001. The fact model can then be rerun to measure whether the promotion increases units and modeled gross profit.

The dbt tests cover four areas. Unique and not-null tests check the primary keys. A composite uniqueness test checks that the fact table has only one row per date and SKU. One business test proves that order subtotals equal the sum of item revenue. Another checks that gross profit and margin are calculated consistently.

The full dbt build passed all 38 nodes, including 22 tests, and all 686 order subtotals reconciled. The main advantage is that the analysis is tested, documented, repeatable, and traceable. The limits are one store, sixteen days, and no operating-cost data.
