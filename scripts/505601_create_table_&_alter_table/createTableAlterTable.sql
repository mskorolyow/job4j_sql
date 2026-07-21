/*
Требования к колонкам:

id - BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
name - обязательный текст
email - обязательный и уникальный
created_at - время создания, по умолчанию NOW()
==============================================================
users
==============================================================
*/

CREATE TABLE users
(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL,
email TEXT NOT NULL UNIQUE,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW() 
);

/*
- Таблица products должна хранить товары и содержит колонки:

Требования к колонкам:

id - primary key
name - обязательный текст
price - точная сумма, например NUMERIC(12, 2)
price должен быть больше 0
is_active - boolean, по умолчанию true
created_at - время создания
==============================================================
products
==============================================================
*/

CREATE TABLE products
(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL,
price numeric(12,2) CHECK (price >0),
is_active BOOLEAN NOT NULL DEFAULT true,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW() 
);

/*
- Таблица orders должна хранить заказы и содержит колонки:
Требования к колонкам:

id - primary key
user_id - внешний ключ на users(id)
status - обязательный текст
created_at - время создания

==============================================================
orders
==============================================================
Требования к колонкам:

id - primary key
user_id - внешний ключ на users(id)
status - обязательный текст
created_at - время создания

*/

CREATE TABLE orders
(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
user_id INTEGER REFERENCES users(id), 
status TEXT NOT NULL,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW() 
);

/*

Требования к колонкам:

id - primary key
order_id - внешний ключ на orders(id)
product_id - внешний ключ на products(id)
quantity - обязательное целое число больше 0
unit_price - цена товара на момент заказа, NUMERIC(12, 2), больше 0

==============================================================
order_items
==============================================================
*/

CREATE TABLE order_items
(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
order_id BIGINT REFERENCES orders(id),
product_id BIGINT REFERENCES products(id),
quantity INTEGER NOT NULL CHECK (quantity >0),
unit_price numeric(12,2) NOT NULL CHECK (unit_price >0)
);
