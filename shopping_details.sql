create table products(id int auto_increment primary key, product_name varchar(255), current_status bool, remaining int, bought_by int);

create table customers(id int auto_increment primary key, customer_name varchar(255), current_order_id int);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO products (product_name, current_status, remaining, bought_by) VALUES
    ('Laptop', TRUE, 20, 50),
    ('Smartphone', TRUE, 35, 100),
    ('Headphones', TRUE, 15, 75),
    ('Tablet', FALSE, 0, 200),
    ('Smartwatch', TRUE, 10, 150);

INSERT INTO customers (customer_name, current_order_id) VALUES
    ('Alice Johnson', 1),
    ('Bob Smith', 2),
    ('Charlie Davis', 3),
    ('Diana Green', 4),
    ('Evan Brown', NULL);

INSERT INTO orders (customer_id, product_id, order_date) VALUES
    (1, 1, '2024-11-01'),
    (2, 2, '2024-11-02'),
    (3, 3, '2024-11-03'),
    (4, 4, '2024-11-04'),
    (1, 5, '2024-11-05'),
    (2, 1, '2024-11-06'),
    (3, 2, '2024-11-07'),
    (4, 3, '2024-11-08');

INSERT INTO reviews (product_id, customer_id, rating, review_text) VALUES
    (1, 1, 5, 'Excellent laptop, very satisfied!'),
    (2, 2, 4, 'Good smartphone, but battery life could be better.'),
    (3, 3, 3, 'Decent headphones, sound quality is okay.'),
    (4, 4, 5, 'Amazing tablet, perfect for my needs.'),
    (5, 1, 4, 'Nice smartwatch, but a bit pricey.'),
    (1, 2, 4, 'Solid laptop for work.'),
    (2, 3, 5, 'Great phone, very smooth and fast.'),
    (3, 4, 2, 'Not impressed with these headphones.'),
    (5, 3, 3, 'Smartwatch is okay, does the job.');


SELECT 
    id AS product_id, 
    product_name, 
    current_status, 
    remaining, 
    bought_by 
FROM 
    products;
    
SELECT 
    customers.id AS customer_id,
    customers.customer_name,
    orders.order_id,
    orders.order_date,
    products.product_name
FROM 
    customers
JOIN 
    orders ON customers.id = orders.customer_id
JOIN 
    products ON orders.product_id = products.id
WHERE 
    customers.id = 1;

SELECT 
    product_id, 
    AVG(rating) AS average_rating
FROM 
    reviews
GROUP BY 
    product_id;

SELECT 
    products.id AS product_id,
    products.product_name,
    products.current_status,
    products.remaining,
    COALESCE(AVG(reviews.rating), 0) AS average_rating
FROM 
    products
LEFT JOIN 
    reviews ON products.id = reviews.product_id
GROUP BY 
    products.id;


