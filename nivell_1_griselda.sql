-- 1. Llistat dels països amb vendes
SELECT DISTINCT c.country
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0;

-- 2. Nombre de països amb vendes
SELECT COUNT(DISTINCT c.country) AS total_paises
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0;

-- 3. Companyia amb major mitjana de vendes
SELECT c.company_name, AVG(t.amount) AS media_ventas
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0
GROUP BY c.company_name
ORDER BY media_ventas DESC
LIMIT 1;

-- 4. Transaccions d’Alemanya
-- 		Mostra totes les transaccions realitzades per empreses d'Alemanya.
SELECT *
FROM transactions.transaction t
WHERE t.company_id IN (
    SELECT c.id
    FROM transactions.company c
    WHERE c.country = 'Germany'
);


-- 5. Empreses amb transaccions superiors a la mitjana
SELECT company_name
FROM transactions.company c
WHERE c.id IN (
    SELECT t.company_id
    FROM transactions.transaction t
    WHERE t.amount > (
        SELECT AVG(amount)
        FROM transactions.transaction
    )
);

-- Eliminaran del sistema les empreses que no tenen transaccions registrades, 
-- entrega el llistat d'aquestes empreses.
SELECT company_name
FROM transactions.company c
WHERE c.id NOT IN (
    SELECT t.company_id
    FROM transactions.transaction t
    
);



-- 7. 5 dies amb més ingressos
SELECT DATE(t.timestamp) AS fecha, SUM(t.amount) AS total_ventas
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE t.declined = 0
GROUP BY DATE(t.timestamp)
ORDER BY total_ventas DESC
LIMIT 5;

-- 8. Mitjana de vendes per país
SELECT c.country, AVG(t.amount) AS media_ventas
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0
GROUP BY c.country
ORDER BY media_ventas DESC;

-- 9. Transaccions del mateix país que "Non Institute" (amb JOIN)
SELECT t.*
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE c.country = (
    SELECT country
    FROM company
    WHERE company_name = 'Non Institute'
);
SELECT *
FROM transactions.transaction t
WHERE t.company_id IN (
    SELECT c.id
    FROM transactions.company c
    WHERE c.country = (
        SELECT country
        FROM transactions.company
        WHERE company_name = 'Non Institute'
    )
);

-- 10. Transaccions entre 350 i 400 euros i dates concretes
SELECT c.company_name, c.phone, c.country, DATE(t.timestamp) AS fecha, t.amount
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.amount BETWEEN 350 AND 400
  AND DATE(t.timestamp) IN ('2015-04-29', '2018-07-20', '2024-03-13')
ORDER BY t.amount DESC;

-- 11. Comptatge de transaccions per empresa amb indicador de >400
SELECT c.company_name,
       COUNT(t.id) AS total_transacciones,
       CASE 
           WHEN COUNT(t.id) > 400 THEN 'Més de 400'
           ELSE 'Menys de 400'
       END AS categoria_transacciones
FROM company c
LEFT JOIN transaction t ON c.id = t.company_id
GROUP BY c.company_name
ORDER BY total_transacciones DESC;
