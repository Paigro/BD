--Pablo Iglesias Rodrigo.
--Practica 3 Ejercicio Consultas.

prompt ------1:
--1: listado de departamentos (con toda la información disponible) de los departamentos cuya localización sea 1500.
SELECT *
    FROM pr3_departments dep
    WHERE dep.location_id = 1500;

prompt ------2:
--2: listado con los nombres de los empleados que trabajan en el departamento cuyo identificador es 100. 
SELECT emp.first_name
    FROM pr3_employees emp
    WHERE emp.department_id = 100;

prompt ------3:
--3: listado con los nombres de los empleados que no tienen jefe.
SELECT *
    FROM pr3_employees emp
    WHERE emp.manager_id IS NULL;

prompt ------4:
--4: listado con los identificadores de departamento de aquellos empleados que reciben algún tipo de comisión. Sin repetición.
SELECT dep.department_id
    FROM pr3_departments dep
    WHERE dep.department_id IN
        (SELECT emp.department_id
            FROM pr3_employees emp
            WHERE emp.commission_pct IS NOT NULL);

prompt ------5:
--5: listado con los nombres de los empleados (ordenados por apellido) que trabajan en el departamento Finance. 
SELECT emp.first_name || ' ' || emp.last_name as NombreCompleto
    FROM pr3_employees emp
    WHERE emp.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'Finance')
    ORDER BY emp.last_name ASC;

prompt ------6:
--6: nombres de los empleados que tienen personal a su cargo, es decir, que son jefes de algún empleado. Sin repetición.
SELECT emp.first_name
    FROM pr3_employees emp 
        JOIN pr3_departments dep ON emp.employee_id = dep.manager_id;

prompt ------7:  
--7: listado de los apellidos de los empleados que ganan más que su jefe, incluyendo también el apellido de su jefe y los salarios de ambos.
SELECT emp.last_name as EmpLastName, emp.salary as EmpSalary, jef.last_name as JefeLastName, jef.salary as JefSalary
    FROM pr3_employees jef 
        JOIN pr3_employees emp ON jef.employee_id = emp.manager_id
    WHERE emp.salary > jef.salary;

prompt ------8:
--8: listado con los nombres de los empleados que han trabajado en el departamento Sales.
SELECT emp.first_name
    FROM pr3_employees emp
        JOIN pr3_job_history jhi ON emp.employee_id = jhi.employee_id
    WHERE jhi.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'Sales');

prompt ------9:          
--9: nombres de los puestos que desempeñan los empleados en el departamento IT, sin tuplas repetidas
SELECT emp.first_name, jbs.job_title
    FROM pr3_employees emp
        JOIN pr3_jobs jbs ON jbs.job_id = emp.job_id
    WHERE emp.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'IT');

prompt ------10:          
--10: listado con los nombres de los empleados que trabajan en el departamento IT que no trabajan en Europa, junto con el nombre del país en el que trabajan.
SELECT emp.first_name, cou.country_name
    FROM pr3_employees emp
        JOIN pr3_departments dep ON emp.department_id = dep.department_id
        JOIN pr3_locations loc ON loc.location_id = dep.location_id
        JOIN pr3_countries cou ON cou.country_id = loc.country_id
    WHERE emp.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'IT')
        AND cou.region_id IN
            (SELECT reg.region_id
                FROM pr3_regions reg
                WHERE reg.region_name <> 'Europe');
        //AND dep.location_id IN
           // (SELECT loc.location_id
             //   FROM pr3_locations loc
               // WHERE loc.country_id IN
                 //   (SELECT cou.country_id
                   //     FROM pr3_countries cou
                     //   WHERE cou.region_id IN
                       //     (SELECT reg.region_id
                         //       FROM pr3_regions reg
                           //     WHERE reg.region_name <> 'Europe')))

prompt ------11:                        
--11: listado de los apellidos de los empleados del departamento SALES que no trabajan en el mismo departamento que su jefe, junto con el apellido de su jefe y el departamento en el que trabaja el jefe.
SELECT emp.last_name, jef.last_name, dep.department_name
    FROM pr3_employees emp
    JOIN pr3_employees jef ON emp.manager_id = jef.employee_id
    JOIN pr3_departments dep ON dep.department_id = jef.department_id
    WHERE emp.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'Sales')
        AND emp.department_id <> jef.department_id;

prompt ------12:
--12: listado con los nombres de los empleados que han trabajado en el departamento IT, pero que actualmente trabajan en otro departamento distinto. 
SELECT emp.first_name
    FROM pr3_employees emp
        JOIN pr3_job_history jhi ON emp.employee_id = jhi.employee_id
    WHERE jhi.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'IT')
        AND emp.department_id IS NOT NULL -- Te asegura que ahora trabaja en otro puesto.
        AND emp.department_id <> jhi.department_id; -- te asegura que se departamento actual no sea sales.

prompt ------13:  
--13: listado con los nombres de los empleados que trabajan en cualquier departamento cuyo nombre contenga una e que no trabajan en Europa, junto con el nombre del departamento y del país en el que trabajan.  
SELECT emp.first_name, dep.department_name, cou.country_name
    FROM pr3_employees emp
        JOIN pr3_departments dep ON emp.department_id = dep.department_id
        JOIN pr3_locations loc ON loc.location_id = dep.location_id
        JOIN pr3_countries cou ON cou.country_id = loc.country_id
        WHERE cou.region_id IN
            (SELECT reg.region_id
                FROM pr3_regions reg
                WHERE reg.region_name <> 'Europe')
        AND dep.department_name like '%e%';
        
prompt ------14:
--14: Listado de las localizaciones de los departamentos de la empresa (identificador del país, ciudad, identificador de la localización y nombre del departamento) en la que se encuentra algún departamento de UK, incluyendo aquellas localizaciones de UK en las que no hay departamento. El listado debe estar ordenado por ciudad. 
SELECT loc.country_id, loc.city, loc.location_id, dep.department_name
    FROM pr3_locations loc
        LEFT JOIN pr3_departments dep ON loc.location_id = dep.location_id --Queremos un JOIN que pueda coger los null de dep.
    WHERE loc.country_id = 'UK'
    ORDER BY loc.city;   
        
prompt ------15:
--15: nombre de todos los países que no tengan ninguna localización, ordenados alfabéticamente en orden descendente. 
SELECT cou.country_name
    FROM pr3_countries cou
         LEFT JOIN pr3_locations loc ON cou.country_id = loc.country_id
   WHERE loc.country_id IS NULL
    ORDER BY cou.country_name DESC;
      
prompt ------16:
--16: nombre, apellidos y departamento de los empleados sin departamento (el departamento aparecerá vacío) y de los departamentos sin empleados (el nombre y apellidos aparecerán vacíos).
SELECT emp.first_name, emp.last_name, dep.department_name
    FROM pr3_employees emp
        LEFT JOIN pr3_departments dep ON dep.department_id = emp.department_id --Simplemete para poder acceder al nombre de departmento.
    WHERE emp.department_id IS NULL
UNION
SELECT emp.first_name, emp.last_name, dep.department_name
    FROM pr3_departments dep
        LEFT JOIN pr3_employees emp ON dep.department_id = emp.department_id
    WHERE emp.first_name IS NULL
        AND emp.last_name IS NULL; 