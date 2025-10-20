-- Exercici 1 / Creacio de taula
CREATE TABLE IF NOT EXISTS credit_card (
	id VARCHAR(10) PRIMARY KEY,
	iban CHAR(50),
	pan CHAR(50),
	pin CHAR(4),
	cvv CHAR(3),
	expiring_date VARCHAR(100)
);

-- Exercici 2
SELECT * FROM transactions.credit_card;

-- Ara comprovem que el compte amb ID 'CcU-2938' existeix
SELECT * FROM transactions.credit_card
WHERE ID = 'CcU-2938';

-- Modifiquem l'iban del compte 'Ccu-2938' : IBAN Original: TR301950312213576817638661 IBAN modificat: TR323456312213576817699999

UPDATE credit_card
SET iban = 'TR323456312213576817699999'
WHERE id = 'CcU-2938';

-- comprovem que ara el compte Ccu-2938 te l'IBAN actualitzat:

SELECT * FROM transactions.credit_card
WHERE ID = 'CcU-9999';

-- Exercici 3
USE transactions;

-- el company_id b-9999 no existeix, per tant primer l'hem d'introduir a la taula de company
INSERT INTO company (id)  
VALUES ('b-9999');

-- finalment introduim la nova fila
INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '2025-10-19 12:42:17', '111.11', '0');


-- comprovem que ara les dades es mostren correctament a la taula de transaction
SELECT *
FROM transactions.transaction
WHERE company_id = 'b-9999';

-- Exercici 4

-- Eliminem la columna 'pan'de la taula 'credit_card'
ALTER TABLE transactions.credit_card
DROP COLUMN pan;

-- comprovem que la columna 'pan' hagi sigut eliminada correctament
SELECT * 
FROM transactions.credit_card
LIMIT 10;

SELECT id FROM company WHERE id = 'b-9999';

-- Nivell 2
-- Exercici 1
SELECT * FROM transactions.transaction
WHERE ID = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD'
LIMIT 1;
DELETE FROM transactions.transaction
WHERE id = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD';

-- Nivell 2 Exercici 2

USE Transactions; -- para asegurarnos que usamos la DB transactions
DROP VIEW VistaMarketing; -- esto borra la view si existe

CREATE VIEW VistaMarketing AS  -- crea la vista
SELECT 
    c.company_name,
    c.phone,
    c.country,
    AVG(t.amount) AS avg_amount
FROM company c
INNER JOIN transaction t ON c.id = t.company_id
WHERE t.amount IS NOT NULL
GROUP BY c.company_name, c.phone, c.country
ORDER BY avg_amount DESC;


-- view test
SELECT * FROM transactions.vistamarketing;


SELECT *
FROM VistaMarketing
WHERE country = 'Germany'
ORDER BY avg_amount DESC;

-- Nivell 3

CREATE TABLE IF NOT EXISTS data_user (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    birth_date DATE,
    country VARCHAR(50),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    address VARCHAR(100)
);
SELECT * FROM data_user;