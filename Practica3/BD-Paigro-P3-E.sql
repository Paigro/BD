prompt ====================Pablo Iglesias Rodrigo====================
prompt ====================P3====================

prompt 
prompt ========================================

prompt ====================Countries====================
DESCRIBE pr3_countries;
prompt ====================Departments====================
DESCRIBE pr3_departments;
prompt ====================Employees====================
DESCRIBE pr3_employees;
prompt ====================Job_History====================
DESCRIBE pr3_job_history;
prompt ====================Jobs====================
DESCRIBE pr3_jobs;
prompt ====================Locations====================
DESCRIBE pr3_locations;
prompt ====================Regions
DESCRIBE pr3_regions;
prompt ========================================

prompt 

prompt ========================================
prompt -1: listado de departamentos (con toda la informacion disponible) de los departamentos cuya localizacion sea 1500.
SELECT *
    FROM pr3_departments dep
    WHERE dep.location_id = 1500
;
prompt ========================================
prompt -2: listado con los nombres de los empleados que trabajan en el departamento cuyo identificador es 100. 
SELECT emp.first_name
    FROM pr3_employees emp
    WHERE emp.department_id = 100
 ;
prompt ========================================
prompt -3: listado con los nombres de los empleados que no tienen jefe.
SELECT emp.first_name
    FROM pr3_employees emp
    WHERE emp.manager_id IS NULL
;
prompt ========================================
prompt -4: listado con los identificadores de departamento de aquellos empleados que reciben algun tipo de comision. Sin repeticion.
SELECT dep.department_id
    FROM pr3_departments dep
    WHERE dep.department_id IN
        (SELECT emp.department_id
            FROM pr3_employees emp
            WHERE emp.commission_pct IS NOT NULL)
;
prompt ========================================
prompt -5: listado con los nombres de los empleados (ordenados por apellido) que trabajan en el departamento Finance. 
SELECT emp.first_name || ' ' || emp.last_name as NombreCompleto
    FROM pr3_employees emp
    WHERE emp.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'Finance')
    ORDER BY emp.last_name ASC
;
prompt ========================================
prompt -6: nombres de los empleados que tienen personal a su cargo, es decir, que son jefes de algún empleado. Sin repetición.
SELECT emp.first_name || ' ' || emp.last_name as NombreCompleto
    FROM pr3_employees emp
    WHERE emp.employee_id IN
        (SELECT emp2.manager_id
            FROM pr3_employees emp2
            WHERE emp2.manager_id IS NOT NULL)
    ORDER BY emp.last_name ASC
;
prompt ========================================
prompt -7: listado de los apellidos de los empleados que ganan más que su jefe, incluyendo tambien el apellido de su jefe y los salarios de ambos.
SELECT emp.last_name as ApellidoEmpelado, emp.salary as SalarioEmpleado, man.last_name as ApellidoManager, man.salary as SalarioManager
    FROM pr3_employees emp 
        JOIN pr3_employees man ON emp.manager_id = man.employee_id
    WHERE emp.salary > man.salary
;
prompt ========================================
prompt -8: listado con los nombres de los empleados que han trabajado en el departamento Sales.
SELECT  emp.first_name || ' ' || emp.last_name as NombreCompleto
    FROM pr3_employees emp
        JOIN pr3_job_history jh ON emp.employee_id = jh.employee_id
    WHERE jh.department_id IN
    (SELECT dep.department_id
        FROM pr3_departments dep
        WHERE dep.department_name = 'Sales')
    ORDER BY emp.first_name
;
prompt ========================================
prompt -9: nombres de los puestos que desempeñan los empleados en el departamento IT, sin tuplas repetidas
SELECT emp.first_name, job.job_title
    FROM pr3_employees emp
        JOIN pr3_jobs job ON emp.job_id = job.job_id
    WHERE emp.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'IT')
;
prompt ========================================
prompt -10: listado con los nombres de los empleados que trabajan en el departamento IT que no trabajan en Europa, junto con el nombre del pais en el que trabajan.
SELECT emp.first_name || ' ' || emp.last_name as NombreCompleto
    FROM pr3_emp_details_view emp
    WHERE emp.department_name = 'IT'
        AND emp.region_name <> 'Europe'
;
prompt ========================================
prompt -11: listado de los apellidos de los empleados del departamento SALES que no trabajan en el mismo departamento que su jefe, junto con el apellido de su jefe y el departamento en el que trabaja el jefe.
SELECT emp.last_name AS apellido_empleado, dep1.department_name as departamento_empelado, mgr.last_name AS apellido_jefe, dep2.department_name AS departamento_jefe
    FROM pr3_employees emp
        JOIN pr3_departments dep1 ON emp.department_id = dep1.department_id
        JOIN pr3_employees mgr ON emp.manager_id = mgr.employee_id
        JOIN pr3_departments dep2 ON mgr.department_id = dep2.department_id
    WHERE dep1.department_name = 'Sales'
        AND emp.department_id <> mgr.department_id
;
prompt ========================================
prompt -12: listado con los nombres de los empleados que han trabajado en el departamento IT, pero que actualmente trabajan en otro departamento distinto.
SELECT  emp.first_name || ' ' || emp.last_name as NombreCompleto
    FROM pr3_employees emp
        JOIN pr3_job_history jh ON emp.employee_id = jh.employee_id
    WHERE jh.department_id IN
        (SELECT dep.department_id
            FROM pr3_departments dep
            WHERE dep.department_name = 'IT')
        AND emp.department_id IS NOT NULL
        AND emp.department_id <> jh.department_id
    ORDER BY emp.first_name
;



prompt ========================================














