--Pablo Iglesias Rodrigo.
--Practica 5.2.

prompt ------1
--1: codigo y nombre de los pilotos certificados para pilotar aviones Boeing.
SELECT empl.eid AS cod, empl.nombre AS nombre
    FROM pr5c1_empleado empl
        JOIN pr5c1_certificado cert ON empl.eid = cert.eid
    WHERE cert.aid IN
        (SELECT avi.aid
            FROM pr5c1_avion avi
            WHERE avi.nombre LIKE 'Boeing%')
;
prompt ------2
--2: codigo de aviones que pueden hacer el recorrido de Los Angeles a Chicago sin repostar.
SELECT avi.aid, avi.nombre
    FROM pr5c1_avion avi
    WHERE avi.autonomia >=
        (SELECT vuel.distancia
            FROM pr5c1_vuelo vuel
            WHERE vuel.origen = 'Los Angeles' AND vuel.destino = 'Chicago')
;
prompt ------3
--3: pilotos certificados para operar con aviones con una autonomia superior a 3000 millas pero no certifcados
--para aviones Boeing.
SELECT empl.eid AS cod, empl.nombre AS nombre
    FROM pr5c1_empleado empl
        JOIN pr5c1_certificado cert ON cert.eid = empl.eid
    WHERE cert.aid NOT IN
        (SELECT avi.aid
            FROM pr5c1_avion avi
            WHERE avi.nombre LIKE 'Boeing%')
        AND cert.aid IN
            (SELECT avi.aid
                FROM pr5c1_avion avi
                WHERE avi.autonomia > 3000)
;--Esta mal.
prompt ------4
--4: empleados con el salario mas elevado.
SELECT empl.eid, empl.nombre, empl.salario
    FROM pr5c1_empleado empl
    WHERE empl.salario =
        (SELECT MAX(empl2.salario)
            FROM pr5c1_empleado empl2)
;
prompt ------5
--5: empleados con el segundo salario mas alto.
SELECT empl.eid, empl.nombre, empl.salario  
    FROM pr5c1_empleado empl  
    WHERE empl.salario = (  
        SELECT MAX(empl2.salario)  
            FROM pr5c1_empleado empl2  
            WHERE empl2.salario < 
                (SELECT MAX(empl3.salario) 
                    FROM pr5c1_empleado empl3))
;
prompt ------6
--6: empleados con mayor numero de certificaciones para volar.
SELECT empl.eid, empl.nombre, COUNT(*) AS certificados
    FROM pr5c1_empleado empl
        JOIN pr5c1_certificado cert ON empl.eid = cert.eid
    GROUP BY empl.eid, empl.nombre
    HAVING COUNT(*) >= 
        (SELECT MAX(COUNT(*))
            FROM pr5c1_empleado empl
                JOIN pr5c1_certificado cert ON empl.eid = cert.eid
            GROUP BY empl.nombre)
;
prompt ------7
--7: empleados certificados para 3 modelos de avion.
SELECT empl.eid, empl.nombre, COUNT(*) AS certificados
    FROM pr5c1_empleado empl
        JOIN pr5c1_certificado cert ON empl.eid = cert.eid
    GROUP BY empl.eid, empl.nombre
    HAVING COUNT(*) >= 3
;
prompt ------8
--8: Nombre de los aviones tales que todos los pilotos certificados para operar con ellos tengan salarios superiores
--a 80.000 euros.
SELECT avi.nombre
    FROM pr5c1_avion avi
        JOIN pr5c1_certificado cert ON avi.aid = cert.aid
    WHERE cert.eid IN
        (SELECT emp.eid
            FROM pr5c1_empleado emp
            WHERE emp.salario > 80000)
;--Esta mal.







