prompt ====================Pablo Iglesias Rodrigo====================
prompt ====================P4====================

prompt

prompt ========================================
prompt -1:
SELECT emp.last_name AS apellido_empelado, cus.cust_last_name AS apellido_comprador
    FROM pr4_customers cus -- Cogemos los clientes.
        JOIN pr3_employees emp ON cus.account_mgr_id = emp.employee_id -- Lo unimos con empleados para saber su gestor de cuenta.
    WHERE cus.customer_id IN -- De aqui separamos los que han hecho un pedido online.
        (SELECT ord.customer_id
            FROM pr4_orders ord
            WHERE UPPER(ord.order_mode) = 'ONLINE')
    ORDER BY emp.last_name ASC, -- Con esto ordenamos.
        cus.cust_last_name ASC
;
prompt ========================================
prompt -2:
SELECT proInf.category_id AS categoria_producto, COUNT(*) AS n_obsoletos
    FROM pr4_product_information proInf
    WHERE UPPER(proInf.product_status) = 'OBSOLETE' -- Nos quedamos con lo que estan marcados como obsoletos.
    GROUP BY proInf.category_id -- Agrupamos por categoria porque nos piden las categorias con productos obsoletos, no solo los productos.
    HAVING COUNT(*) > 2 -- Mas de 2 productos obsoletos.
;
prompt ========================================
prompt -3:
SELECT proinf.product_name AS nombre_producto, SUM(ordite.quantity) AS cantidad_vendidos
    FROM pr4_product_information proinf
        JOIN pr4_order_items ordite ON proinf.product_id = ordite.product_id -- Necesitamos esta tabla para las cantidades.
        JOIN pr4_orders ord ON ordite.order_id = ord.order_id -- Necesitamos esta tabla para las fechas.
    WHERE EXTRACT (YEAR FROM ord.order_date) = 1990 -- Nos piden de 1990.
        AND EXTRACT (MONTH FROM ord.order_date) >= 7 -- Ultimo semestre de 1990.
    GROUP BY proinf.product_id, proinf.product_name -- Agrupamos por id y nombre por si hay productos con el mismo nombre.
    ORDER BY cantidad_vendidos DESC -- Ordenamos.
;
prompt ========================================
prompt -4:
SELECT jobs.job_title AS nombre_puesto, jobs.min_salary AS salario_minimo
    FROM pr3_jobs jobs
    WHERE jobs.min_salary > -- De aqui separamos por salario minimo > al salario medio de todos los empleados.
        (SELECT AVG(emp.salary)
            FROM pr3_employees emp)
    ORDER BY jobs.min_salary ASC -- Ordenamos.
;
prompt ========================================
prompt -5:
SELECT proinf.product_id AS codigo_producto, proinf.product_name AS nombre_producto, proinf.min_price AS precio_minimo
    FROM pr4_product_information proinf
    WHERE proinf.product_id NOT IN --De aqui separamos los productos que no han sido pedidos nunca. No es correlacionada.
        (SELECT ordite.product_id
            FROM pr4_order_items ordite)
        AND proinf.category_id = 14 -- Queremos solo los de la categoria 14.
;
prompt ========================================
prompt -6:
SELECT cus.customer_id AS codigo_cliente, cus.cust_first_name AS nombre_cliente, cus.cust_last_name AS apellidos_cliente
    FROM pr4_customers cus
    WHERE UPPER(cus.nls_territory) = 'GERMANY' -- Solo los clientes alemanes.
        AND NOT EXISTS -- De aqui separamos los clientes que no han pedido nunca. Es correlacionada.
            (SELECT 1 -- Como exists solo mira si true o false devolvemos 1, daria igual el valor.
                FROM pr4_orders ord
                WHERE ord.customer_id = cus.customer_id)
;
prompt ========================================
prompt -7:
SELECT cus.customer_id AS codigo_cliente, cus.cust_first_name AS nombre_cliente, cus.cust_last_name AS apellidos_cliente
    FROM pr4_customers cus -- No hay repeticiones de base porque estamos cogiendo la tabla clientes directamente y quitando gente de ella, entonces no hay motivo de duplicados.
    WHERE cus.customer_id IN -- De aqui separamos los que han pedido online.
        (SELECT ord.customer_id
            FROM pr4_orders ord
            WHERE UPPER(ord.order_mode) = 'ONLINE')
        AND cus.customer_id IN -- Y aqui los que han pedido direct.
            (SELECT ord.customer_id
                FROM pr4_orders ord
                WHERE UPPER(ord.order_mode) = 'DIRECT')
;
prompt ========================================
prompt -8:
SELECT cus.customer_id AS codigo_cliente, cus.cust_first_name AS nombre_cliente, cus.cust_last_name AS apellidos_cliente
    FROM pr4_customers cus -- Lo mismo que el anterior, usamos la tabla de clientes y vamos quitando gente de ella.
    WHERE cus.customer_id NOT IN -- Aqui separamos los que no han pedido direct.
        (SELECT ord.customer_id
            FROM pr4_orders ord
            WHERE UPPER(ord.order_mode) = 'DIRECT')
        AND cus.customer_id IN -- Aqui nos aseguramos que han pedido alguna vez algo.
            (SELECT ord.customer_id
                FROM pr4_orders ord)
;
prompt ========================================
prompt -9:
SELECT proinf.product_id AS codigo_producto, proinf.min_price AS precio_minimo, proinf.list_price AS precio_publico, (((ordite.unit_price-proinf.min_price)/proinf.min_price)*100) AS incremento_precio
    FROM pr4_product_information proinf
        JOIN pr4_order_items ordite ON proinf.product_id = ordite.product_id -- Unimos con los productos pedidos porque es ahi donde esta el precio de venta al publico.
    WHERE (((ordite.unit_price-proinf.min_price)/proinf.min_price)*100) > 30
        AND proinf.min_price <> 0 -- Para evitar divisiones por 0 por si acaso.
    ORDER BY incremento_precio ASC -- No hace falta pero queda bien.
;
prompt ========================================
prompt -10:
SELECT emp.last_name AS apellido_empleado, emp.salary AS salario_empleado, jobs.job_title AS puesto
    FROM pr3_employees emp
        JOIN pr3_jobs jobs ON emp.job_id = jobs.job_id -- Unimos con los trabajos porque necesitamos el nombre del trabajo.
    WHERE emp.salary > -- Aqui separamos los que tienen un salario por encima de la media un 35%
        (SELECT AVG(emp2.salary)*1.35 -- Un incremento del 35% es multiplicar por 1'35.
            FROM pr3_employees emp2
            WHERE emp.job_id=emp2.job_id)
;



prompt ========================================

















