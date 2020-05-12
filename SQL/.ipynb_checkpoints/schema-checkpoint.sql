--Create schema tables
CREATE TABLE card_holder (
    card_holder_id INT NOT NULL PRIMARY KEY,
    card_holder_name VARCHAR (255) NOT NULL
);

CREATE TABLE credit_card (
    card_number VARCHAR(20) NOT NULL PRIMARY KEY,
    card_holder_id INT NOT NULL,
    FOREIGN KEY (card_holder_id) REFERENCES card_holder(card_holder_id)
);

CREATE TABLE merchant_category (
    merchant_category_id INT NOT NULL PRIMARY KEY,
    merchant_category_name VARCHAR (255)
    
);

CREATE TABLE merchant (
    merchant_id INT NOT NULL PRIMARY KEY,
    merchant_name VARCHAR (255),
    merchant_category_id INT NOT NULL,
    FOREIGN KEY (merchant_category_id) REFERENCES merchant_category(merchant_category_id)
);

CREATE TABLE transaction (
    transaction_id INT NOT NULL PRIMARY KEY,
    transaction_date timestamp without time zone,
    transaction_amount MONEY NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (card_number) REFERENCES credit_card(card_number),
    merchant_id INT NOT NULL,
    FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id)
);