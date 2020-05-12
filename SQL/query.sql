--Master Transactions df
CREATE VIEW master_transactions AS
SELECT ch.card_holder_id,
    ch.card_holder_name,
    cc.card_number,
    mc.merchant_category_id,
    mc.merchant_category_name,
    m.merchant_id,
    m.merchant_name,
    t.transaction_date,
    t.transaction_id,
    t.transaction_amount
FROM merchant c
     JOIN transaction t ON c.merchant_id = t.merchant_id
     JOIN merchant_category mc ON mc.merchant_category_id = c.merchant_category_id
     JOIN merchant m ON m.merchant_id = t.merchant_id
     JOIN credit_card cc ON cc.card_number::text = t.card_number::text
     JOIN card_holder ch ON ch.card_holder_id = cc.card_holder_id
ORDER BY ch.card_holder_id;

-- Query customer revenue view


--Morning Transactions df
CREATE VIEW morning_transactions AS
SELECT ch.card_holder_id,
    ch.card_holder_name,
    cc.card_number,
    mc.merchant_category_id,
    mc.merchant_category_name,
    m.merchant_id,
    m.merchant_name,
    t.transaction_date,
    t.transaction_id,
    t.transaction_amount
FROM merchant c
     JOIN transaction t ON c.merchant_id = t.merchant_id
     JOIN merchant_category mc ON mc.merchant_category_id = c.merchant_category_id
     JOIN merchant m ON m.merchant_id = t.merchant_id
     JOIN credit_card cc ON cc.card_number::text = t.card_number::text
     JOIN card_holder ch ON ch.card_holder_id = cc.card_holder_id
WHERE date_part('hour'::text, t.transaction_date) >= 7::double precision AND date_part('hour'::text, t.transaction_date) <= 9::double precision
ORDER BY t.transaction_amount DESC;

-- Query customer revenue view



--Small Transactions df
CREATE VIEW small_transactions AS
SELECT ch.card_holder_id,
    ch.card_holder_name,
    cc.card_number,
    mc.merchant_category_id,
    mc.merchant_category_name,
    m.merchant_id,
    m.merchant_name,
    t.transaction_date,
    t.transaction_id,
    t.transaction_amount
FROM merchant c
     JOIN transaction t ON c.merchant_id = t.merchant_id
     JOIN merchant_category mc ON mc.merchant_category_id = c.merchant_category_id
     JOIN merchant m ON m.merchant_id = t.merchant_id
     JOIN credit_card cc ON cc.card_number::text = t.card_number::text
     JOIN card_holder ch ON ch.card_holder_id = cc.card_holder_id
WHERE t.transaction_amount < 2.00;

-- Query customer revenue view