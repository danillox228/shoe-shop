# Db — ShoeShop CSV data

All tables are exported as UTF-8 CSV with a comma delimiter. Each table has an `id` column. Repeating values are normalized into reference tables and connected by IDs.

## Tables
- `products.csv` — products; references `categories`, `manufacturers`, `suppliers`
- `users.csv` — users; references `roles`
- `orders.csv` — orders; references `pvz`, `users`, `orderstatus`
- `prodorders.csv` — order line items; references `orders` and `products`
- `categories.csv`, `manufacturers.csv`, `suppliers.csv`, `roles.csv`, `orderstatus.csv` — reference tables
- `pvz.csv` — pickup points

## Data quality note
The source workbook contains an invalid order date `30.02.2025` for order 7. Since that calendar date does not exist, `orders.csv` leaves `order_date` blank for that record rather than inventing a corrected date. The source pickup point #19 has no house number; `house` is blank for that row.

`schema.sql` documents the relational structure and foreign-key constraints.
