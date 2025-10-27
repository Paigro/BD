--Pablo Iglesias Rodrigo.
--Practica 4 Ejercicio Consultas.

prompt ------1:
--1: elabora un listado (sin repeticiones) con los apellidos de los clientes de la empresa que hayan 
--hecho algún pedido online (order_mode online) junto con el apellido del empleado que 
--gestiona su cuenta. Muestra en el listado primero el apellido del empleado que gestiono la 
--cuenta y luego el apellido del cliente, y haz que el listado se encuentre ordenado por apellido 
--de empleado primero y luego por apellido del cliente. Usa reuniones para ello. 
SELECT emp.last_name AS apellido_emp, cus.cust_last_name as apellido_cust
    FROM pr4_customers cus
        JOIN pr3_employees emp ON cus.account_mgr_id = emp.employee_id
    WHERE cus.customer_id IN
        (SELECT ord.customer_id
            FROM pr4_orders ord
            WHERE ord.order_mode = 'online')
    ORDER BY emp.last_name, cus.cust_last_name;

prompt ------2:
--2: listado de categorías con más de 2 productos obsoletos (PRODUCT_STATUS obsolete). 
--Lista la categoría y el número de productos obsoletos. 
SELECT proInf.category_id AS categoria, COUNT(*) AS productos_obs
    FROM pr4_product_information proInf
    WHERE proInf.product_status = 'obsolete'
    GROUP BY proInf.category_id
    HAVING COUNT(*) > 2;

prompt ------3:
--3: se quiere generar un “ranking” de los productos más vendidos en el último semestre del año 
--1990. Para ello nos piden mostrar el nombre de producto y el número de unidades vendidas 
--para cada producto vendido en el último semestre del año 1990 (ordenado por número de 
--unidades vendidas de forma descendente). 
SELECT proinf.product_name AS nombre_pro, ordIte.quantity AS unidades
    FROM pr4_product_information proInf
        JOIN pr4_order_items ordIte ON proinf.product_id = ordite.product_id
        JOIN pr4_orders ord ON ord.order_id = ordite.order_id
        WHERE EXTRACT(year FROM ord.order_date) = 1990
            AND EXTRACT(month FROM ord.order_date) >= 7
        ORDER BY ordIte.quantity DESC;

prompt ------4:
--4: muestra los puestos en la empresa que tienen un salario mínimo superior al salario medio de 
--los empleados de la compañía. El listado debe incluir el puesto y su salario mínimo, y estar 
--ordenado ascendentemente por salario mínimo.
SELECT jobs.job_title, jobs.min_salary
    FROM pr3_jobs jobs
    WHERE jobs.min_salary > 
        (SELECT AVG(emp.salary)
            FROM pr3_employees emp)
   ORDER BY jobs.min_salary ASC;

prompt ------5:
--5: mostrar el código, nombre y precio mínimo de productos de la categoría 14 que no aparecen 
--en ningún pedido. Usa para ello una subconsulta no correlacionada. 
SELECT proInf.product_id, proInf.product_name, proInf.min_price
    FROM pr4_product_information proInf
    WHERE proInf.product_id NOT IN
        (SELECT ordIte.product_id
            FROM pr4_order_items ordIte)
        AND proinf.category_id = 14;
        
prompt ------6:
--6: mostrar el código de cliente, nombre y apellidos de aquellos clientes alemanes 
--(NLS_TERRITORY GERMANY) que no han realizado ningún pedido. Usa para ello una consulta 
--correlacionada.
SELECT cus.customer_id, cus.cust_first_name, cus.cust_last_name
    FROM pr4_customers cus
    WHERE cus.nls_territory = 'GERMANY'
        AND cus.customer_id NOT IN
            (SELECT ord.customer_id
                FROM pr4_orders ord);

prompt ------7:
--7: mostrar el código de cliente, nombre y apellidos (sin repetición) de aquellos clientes que han 
--realizado al menos un pedido de tipo (order_mode) online y otro direct. 
SELECT cus.customer_id, cus.cust_first_name, cus.cust_last_name
    FROM pr4_customers cus
    WHERE cus.customer_id IN
            (SELECT ord.customer_id
                FROM pr4_orders ord
                WHERE ord.order_mode = 'online')
        AND cus.customer_id IN
            (SELECT ord.customer_id
                FROM pr4_orders ord
                WHERE ord.order_mode = 'direct');

prompt ------8:
--8: mostrar el nombre y apellidos de aquellos clientes que, habiendo realizado algún pedido, 
--nunca han realizado pedidos de tipo direct. 
SELECT cus.customer_id, cus.cust_first_name, cus.cust_last_name
    FROM pr4_customers cus
    WHERE cus.customer_id NOT IN
            (SELECT ord.customer_id
                FROM pr4_orders ord
                WHERE ord.order_mode = 'direct')
        AND cus.customer_id IN
            (SELECT ord.customer_id
                FROM pr4_orders ord);

prompt ------9:
--9: se quiere generar un listado de los productos que generan mayor beneficio. Mostrar el código 
--de producto, su precio mínimo, su precio de venta al público y el porcentaje de incremento 
--de precio. En el listado deben aparecer solo aquellos cuyo precio de venta al público ha 
--superado en  un 30 % al precio mínimo. 
SELECT proInf.product_id AS id, proInf.min_price, proInf.list_price,((((proInf.list_price - proInf.min_price) / proInf.min_price)) * 100) AS incremento
    FROM pr4_product_information proInf
    WHERE ((((proInf.list_price - proInf.min_price) / proInf.min_price)) * 100) >= 30
        AND proInf.min_price <> 0
    ORDER BY proInf.product_id;


prompt ------10:
--10: Mostrar el apellido de los empleados que ganen un 35% más del salario medio de su puesto. 
--El listado debe incluir el salario del empleado y su puesto.
