/*Создаем таблицу: roles - роли пользователей*/
--
CREATE TABLE roles (

id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL UNIQUE,
description TEXT
    
);
/*Создаем таблицу: users - пользователи*/
--
CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
	name TEXT NOT NULL,
	email TEXT UNIQUE,
	role_id BIGINT NOT NULL,
	created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE RESTRICT	
);

/*Создаем таблицу: rules - права ролей*/
--
CREATE TABLE rules  (

id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
role_id BIGINT NOT NULL,
rule_name TEXT NOT NULL,
UNIQUE(role_id, rule_name),
FOREIGN KEY(role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE
    
);

/*Создаем таблицу: categories - категории заявок*/
--
CREATE TABLE categories (
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
name TEXT NOT NULL UNIQUE 
);

/*Создаем таблицу: states - состояния заявок*/
--
CREATE TABLE states (

id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL UNIQUE    
);

/*Создаем таблицу: items  - заявки*/
--
CREATE TABLE items (

id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL,
description TEXT,
user_id BIGINT NOT NULL,
category_id BIGINT NOT NULL,
state_id BIGINT NOT NULL,
created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated TIMESTAMPTZ,

CONSTRAINT fk_items_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
		
CONSTRAINT fk_items_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,	
		
CONSTRAINT fk_items_state
        FOREIGN KEY (state_id)
        REFERENCES states(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT   
);
/*Создаем таблицу: comments - комментарии*/
--
CREATE TABLE comments (
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
item_id BIGINT NOT NULL,
user_id BIGINT NOT NULL,
text TEXT NOT NULL,
created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fk_comments_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
		
CONSTRAINT fk_comments_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

    
);
/*Создаем таблицу: attachs - прикрепленные файлы*/
--
CREATE TABLE attachs (
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
item_id BIGINT NOT NULL,
file_name TEXT NOT NULL,  
file_path TEXT NOT NULL,
file_size BIGINT NOT NULL,
uploaded TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
CHECK (file_size >= 0),

CONSTRAINT fk_attachs_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE

);









