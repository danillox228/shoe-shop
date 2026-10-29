-- ShoeShop normalized CSV schema (SQLite-compatible)
PRAGMA foreign_keys = ON;

CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
CREATE TABLE manufacturers (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
CREATE TABLE suppliers (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
CREATE TABLE roles (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
CREATE TABLE orderstatus (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
CREATE TABLE pvz (
  id INTEGER PRIMARY KEY, postcode TEXT NOT NULL, city TEXT NOT NULL,
  street TEXT NOT NULL, house TEXT
);
CREATE TABLE users (
  id INTEGER PRIMARY KEY, full_name TEXT NOT NULL, login TEXT NOT NULL,
  password TEXT NOT NULL, role_id INTEGER NOT NULL REFERENCES roles(id)
);
CREATE TABLE products (
  id INTEGER PRIMARY KEY, article TEXT NOT NULL UNIQUE, name TEXT NOT NULL,
  unit TEXT NOT NULL, price NUMERIC NOT NULL, discount NUMERIC,
  stock_qty INTEGER, description TEXT, photo TEXT,
  category_id INTEGER NOT NULL REFERENCES categories(id),
  manufacturer_id INTEGER NOT NULL REFERENCES manufacturers(id),
  supplier_id INTEGER NOT NULL REFERENCES suppliers(id)
);
CREATE TABLE orders (
  id INTEGER PRIMARY KEY, order_date TEXT, delivery_date TEXT,
  pvz_id INTEGER NOT NULL REFERENCES pvz(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  receive_code TEXT, status_id INTEGER NOT NULL REFERENCES orderstatus(id)
);
CREATE TABLE prodorders (
  id INTEGER PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES orders(id),
  product_id INTEGER NOT NULL REFERENCES products(id), qty INTEGER NOT NULL CHECK(qty > 0)
);
