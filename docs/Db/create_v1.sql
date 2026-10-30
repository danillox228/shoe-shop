-- ShoeShop: структура БД, подготовлена из docs/Db/schema.sql
CREATE DATABASE IF NOT EXISTS shoe_shop_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE shoe_shop_db;

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Manufacturers (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    manufacturer_name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE UserRoles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE OrderStatuses (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE PickupPoints (
    pickup_id INT AUTO_INCREMENT PRIMARY KEY,
    postal_code VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    street VARCHAR(150) NOT NULL,
    building VARCHAR(20)
);

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    username VARCHAR(100) NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id)
        REFERENCES UserRoles(role_id)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    article_code VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(200) NOT NULL,
    unit_name VARCHAR(30) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    quantity_in_stock INT DEFAULT 0,
    product_description TEXT,
    image_path VARCHAR(255),
    category_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    supplier_id INT NOT NULL,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id),
    CONSTRAINT fk_products_manufacturer
        FOREIGN KEY (manufacturer_id)
        REFERENCES Manufacturers(manufacturer_id),
    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATE,
    expected_delivery DATE,
    pickup_id INT NOT NULL,
    user_id INT NOT NULL,
    pickup_code VARCHAR(50),
    status_id INT NOT NULL,
    CONSTRAINT fk_orders_pickup
        FOREIGN KEY (pickup_id)
        REFERENCES PickupPoints(pickup_id),
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),
    CONSTRAINT fk_orders_status
        FOREIGN KEY (status_id)
        REFERENCES OrderStatuses(status_id)
);

CREATE TABLE OrderItems (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT chk_item_quantity
        CHECK (quantity > 0),
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);
