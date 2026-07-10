# Product Profitability Presentation Script

## Slide 1

My question is: which products generate the most modeled gross profit, and is that result driven by sales volume, unit margin, or both?

I use the term modeled gross profit carefully. Each item row represents one unit sold. Revenue is the product price, and unit supply cost is the sum of the component costs assigned to that SKU. The model does not include labour, rent, discounts, or overhead.

The dataset contains 997 sold items across sixteen days. Those items generated $6,818 in revenue and $5,412.28 in modeled gross profit.

## Slide 2

The dbt lineage makes the calculation traceable. Raw items provide the sale lines. Raw orders provide the date and order context. Raw products provide prices and product attributes. Raw supplies provide the component costs.

The staging layer standardises those sources. The intermediate layer aggregates supply cost by SKU and calculates item-level economics. The final fact then publishes daily profitability by product. The saved analysis query sits directly downstream, so every presentation figure can be reproduced.

## Slide 3

The chart separates sales volume from unit margin. Bubble size represents total modeled gross profit.

BEV-004 is the strongest product because it performs well on both dimensions. It sold 168 units, retained an 88.3 percent modeled margin, and generated $1,038.24 in modeled gross profit. That is 19.2 percent of the total.

JAF-001 shows the opposite opportunity. It has the highest unit margin at 89 percent, but sold only 37 units. Its economics are strong, but its current volume is low.

## Slide 4

My recommendation has two parts. First, protect BEV-004 availability because it is the largest current contributor. Second, run a controlled promotion for JAF-001 and measure whether extra demand increases gross profit without displacing stronger products.

The result is supported by a clean dbt build. All 38 nodes passed, including 22 tests, and all 686 order subtotals reconciled to item revenue.

The limits are clear: one store, sixteen days of sales, and no operating-cost data. This is a product gross-profit model and a basis for a measured commercial test, not a long-term forecast.
