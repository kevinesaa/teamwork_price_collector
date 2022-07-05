
CREATE TABLE currencies (
                currency_id INT AUTO_INCREMENT NOT NULL,
                name VARCHAR(64) NOT NULL,
                code VARCHAR(3) NOT NULL,
                simbol VARCHAR(2) NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (currency_id)
);


CREATE UNIQUE INDEX currency_code
 ON currencies
 ( code );

CREATE TABLE stores (
                store_id INT AUTO_INCREMENT NOT NULL,
                name VARCHAR(256) NOT NULL,
                physical_address VARCHAR(512),
                reference_point VARCHAR(512),
                web_site VARCHAR(512),
                lat_long VARCHAR,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (store_id)
);


CREATE UNIQUE INDEX stores_names
 ON stores
 ( name );

CREATE TABLE emails (
                email_id BIGINT AUTO_INCREMENT NOT NULL,
                store_id INT NOT NULL,
                email VARCHAR(128) NOT NULL,
                main_email BOOLEAN DEFAULT false NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (email_id)
);


CREATE UNIQUE INDEX emails_idx
 ON emails
 ( store_id, email );

CREATE TABLE phones (
                phone_id BIGINT AUTO_INCREMENT NOT NULL,
                store_id INT NOT NULL,
                phone VARCHAR(16) NOT NULL,
                main_phone BOOLEAN DEFAULT false NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (phone_id)
);


CREATE UNIQUE INDEX phones_idx
 ON phones
 ( store_id, phone );

CREATE TABLE packing (
                packing_id INT AUTO_INCREMENT NOT NULL,
                description VARCHAR(128) NOT NULL,
                updated_at DATETIME NOT NULL,
                created_at DATETIME NOT NULL,
                PRIMARY KEY (packing_id)
);


CREATE UNIQUE INDEX packing_name
 ON packing
 ( description );

CREATE TABLE categories (
                category_id INT AUTO_INCREMENT NOT NULL,
                name VARCHAR(128) NOT NULL,
                description VARCHAR(512),
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (category_id)
);


CREATE UNIQUE INDEX categories_name
 ON categories
 ( name );

CREATE TABLE items (
                item_id INT AUTO_INCREMENT NOT NULL,
                category_id INT,
                name VARCHAR(128) NOT NULL,
                description VARCHAR(512),
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (item_id)
);


CREATE UNIQUE INDEX items_name
 ON items
 ( name );

CREATE TABLE item_packing (
                item_packing_id BIGINT AUTO_INCREMENT NOT NULL,
                item_id INT NOT NULL,
                packing_id INT NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (item_packing_id)
);


CREATE UNIQUE INDEX item_packing_idx
 ON item_packing
 ( item_id, packing_id );

CREATE TABLE prices (
                price_id BIGINT AUTO_INCREMENT NOT NULL,
                currency_id INT NOT NULL,
                store_id INT NOT NULL,
                item_packing_id BIGINT NOT NULL,
                checking_date DATETIME NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (price_id)
);


CREATE UNIQUE INDEX prices_idx
 ON prices
 ( currency_id, store_id, item_packing_id );

ALTER TABLE prices ADD CONSTRAINT currencies_prices_fk
FOREIGN KEY (currency_id)
REFERENCES currencies (currency_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE prices ADD CONSTRAINT stores_prices_fk
FOREIGN KEY (store_id)
REFERENCES stores (store_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE phones ADD CONSTRAINT stores_phones_fk
FOREIGN KEY (store_id)
REFERENCES stores (store_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE emails ADD CONSTRAINT stores_emails_fk
FOREIGN KEY (store_id)
REFERENCES stores (store_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE item_packing ADD CONSTRAINT packing_item_packing_fk
FOREIGN KEY (packing_id)
REFERENCES packing (packing_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE items ADD CONSTRAINT categories_items_fk
FOREIGN KEY (category_id)
REFERENCES categories (category_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE item_packing ADD CONSTRAINT items_item_packing_fk
FOREIGN KEY (item_id)
REFERENCES items (item_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE prices ADD CONSTRAINT item_packing_prices_fk
FOREIGN KEY (item_packing_id)
REFERENCES item_packing (item_packing_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
