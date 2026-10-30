-- SQL-пакет для приложения ShoeShop (MySQL 8+)
USE shoe_shop_db;

-- 1. Вход: имя пользователя и пароль (в реальном приложении хранить хеши паролей)
SELECT u.user_id, u.full_name, u.username, r.role_name
FROM Users u JOIN UserRoles r ON r.role_id=u.role_id
WHERE u.username = ? AND u.user_password = ?;

-- 2. Каталог товаров
SELECT p.product_id, p.article_code, p.product_name, c.category_name,
       m.manufacturer_name, s.supplier_name, p.price, p.discount_percent,
       p.quantity_in_stock, p.unit_name, p.image_path
FROM Products p JOIN Categories c ON c.category_id=p.category_id
JOIN Manufacturers m ON m.manufacturer_id=p.manufacturer_id
JOIN Suppliers s ON s.supplier_id=p.supplier_id
ORDER BY p.product_name;

-- 3. Поиск по названию/артикулу
SELECT product_id, article_code, product_name, price, discount_percent, quantity_in_stock
FROM Products WHERE product_name LIKE CONCAT('%', ?, '%') OR article_code LIKE CONCAT('%', ?, '%');

-- 4. Фильтр по категории и сортировка по цене
SELECT p.product_id, p.product_name, p.price, c.category_name
FROM Products p JOIN Categories c ON c.category_id=p.category_id
WHERE (? IS NULL OR p.category_id=?)
ORDER BY p.price ASC;

-- 5. Добавление товара
INSERT INTO Products (article_code, product_name, unit_name, price, discount_percent,
 quantity_in_stock, product_description, image_path, category_id, manufacturer_id, supplier_id)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- 6. Редактирование товара
UPDATE Products SET product_name=?, price=?, discount_percent=?, quantity_in_stock=?,
 category_id=?, manufacturer_id=?, supplier_id=? WHERE product_id=?;

-- 7. Удаление товара
DELETE FROM Products WHERE product_id=?;

-- 8. Заказы с деталями
SELECT o.order_id, o.created_at, os.status_name, u.full_name, p.product_name, oi.quantity
FROM Orders o JOIN OrderStatuses os ON os.status_id=o.status_id
JOIN Users u ON u.user_id=o.user_id JOIN OrderItems oi ON oi.order_id=o.order_id
JOIN Products p ON p.product_id=oi.product_id ORDER BY o.created_at DESC;
