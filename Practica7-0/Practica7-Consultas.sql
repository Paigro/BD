-- Alberto de la Encina Vara
REM ******** CONSULTAS 1 tabla *******************

Prompt ****** 1.  Todos los datos de todos los pintores
SELECT *
FROM Enero17_Pintores;

Prompt ****** 2.  Nombre de pintor y nombre de cuadro de los cuadros
SELECT nombrePintor, nombre
FROM Enero17_Cuadros;
Prompt ****** 2.1.  Todos los datos de todos los cuadros indicando nombrePintor como "Nombre Pintor" y nombre como "Nombre cuadro"
SELECT NombrePintor AS "Nombre Pintor", nombre "Nombre Cuadro"
FROM Enero17_Cuadros;


Prompt ****** 3.  Todos los cuadros que han sido expuestos en alguna exposici�n (Sin repetici�n)
SELECT DISTINCT nombrePintor, nombre
FROM Enero17_Asignados;

Prompt ****** 4.  Todos los datos de todos los cuadros ordenados por nombre cuadro en orden lexicogr�fico y siglo primero los m�s modernos.
SELECT *
FROM Enero17_Cuadros
ORDER BY nombre ASC, siglo DESC;

Prompt ****** 5. Los pupilos. 
SELECT *
FROM Enero17_Pintores
WHERE nombremaestro IS NOT NULL;

Prompt ****** 6.  Los pupilos sin maestros. / Los maestros sin pupilos.
Prompt ******* No hay esa informaci�n en la base de datos

Prompt ****** 7. Los maestros de s� mismos.
SELECT *
FROM Enero17_Pintores
WHERE nombremaestro = nombre;

Prompt ****** 8. Pintores que han pintado un cuadro titulado �autorretrato�.
SELECT nombrePintor
FROM Enero17_Cuadros
WHERE nombre = 'Autorretrato';

Prompt ****** 9. Nombre de los cuadros pintados por el pintor �Pepe� y los pintados por �Martina�.
SELECT nombre, nombrePintor
FROM Enero17_Cuadros
WHERE nombrePintor = 'Pepe' OR nombrePintor = 'Martina';

Prompt ****** 10. Nombre de los Pintores nacidos antes de 1970.
SELECT *
FROM Enero17_Pintores
WHERE EXTRACT( YEAR FROM FechaNac) < 1976;

SELECT *
FROM Enero17_Pintores
WHERE FechaNac < '1/01/1976';

-- La fecha de nacimiento de los pintores que son maestros.

REM ******** CONSULTAS JOIN *******************

Prompt ****** 1.  Todos los datos de los pintores que han pintado alg�n cuadro
SELECT pintor.nombre, pintor.fechaNac, NVL(pintor.nombreMaestro, 'Sin maestro') As nombreMaestro
FROM Enero17_Pintores pintor
     JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor;
     
Prompt ****** 2.  Para cada cuadro nombre de cuadro y fecha de su nacimiento de su pintor.
SELECT cuadro.nombre, pintor.fechaNac
FROM Enero17_Pintores pintor
     JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor;

Prompt ****** 3.  Los cuadros que han sido expuestos en alguna exposici�n y su siglo.
SELECT DISTINCT cuadro.nombre, cuadro.nombrePintor, cuadro.siglo
FROM Enero17_Asignados asignado
     JOIN Enero17_Cuadros cuadro ON asignado.nombrePintor = cuadro.nombrePintor
                                    AND asignado.nombreCuad = cuadro.nombre;
                                    
Prompt ****** 4.  Los datos de todos los cuadros y sus pintores ordenados por nombre cuadro en orden lexicogr�fico y siglo primero los m�s modernos.
SELECT cuadro.nombre, cuadro.nombrePintor, cuadro.siglo
FROM Enero17_Pintores pintor
     JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
ORDER BY cuadro.nombre ASC, cuadro.siglo DESC;

Prompt ****** 5.  Los pupilos junto con los cuadros pintados. 
SELECT cuadro.nombrePintor, cuadro.nombre, cuadro.siglo
FROM Enero17_Pintores pintor
     JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
WHERE pintor.nombreMaestro IS NOT NULL;

Prompt ****** 6.  Los pupilos sin maestros. / Los maestros sin pupilos.
Prompt ******* No hay esa informaci�n en la base de datos

Prompt ****** 7.  Los maestros de s� mismos que hayan expuesto alg�n cuadro.
SELECT pintor.nombre, pintor.fechaNac
FROM Enero17_Pintores pintor
     JOIN Enero17_Asignados asignado ON asignado.nombrePintor = pintor.nombre
WHERE pintor.nombreMaestro = pintor.nombre;

Prompt ****** 8.  Pintores que han pintado un cuadro titulado �autorretrato� y este ha sido expuesto
SELECT DISTINCT cuadro.nombrePintor
FROM Enero17_Cuadros cuadro
     JOIN Enero17_Asignados asignado ON asignado.nombrePintor = cuadro.nombrePintor
                                        AND asignado.nombrecuad = cuadro.nombre
WHERE cuadro.nombre = 'Autorretrato';

Prompt ****** 9.  Datos de los cuadros expuestos del pintor �Pepe� y de la pintora �Martina�.
SELECT cuadro.nombrePintor, cuadro.nombre, cuadro.siglo, cuadro.tecnica
FROM Enero17_Pintores pintor
     JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
WHERE nombrePintor = 'Pepe' OR nombrePintor = 'Martina';

Prompt ****** 10.  Pintores y cuadros de aquellos que hayan expuesto alg�n cuadro nacidos antes de 1980.
SELECT pintor.nombre, cuadro.nombre, pintor.fechaNac, asignado.nombreExp
FROM Enero17_Pintores pintor
     JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
     JOIN Enero17_Asignados asignado ON asignado.nombrePintor = cuadro.nombrePintor
                                        AND asignado.nombrecuad = cuadro.nombre
WHERE EXTRACT( YEAR FROM pintor.fechaNac) < 1980;

REM ******** CONSULTAS GROUP *******************

Prompt ****** 1.  �Cu�ntos cuadros hay?
SELECT COUNT(*) AS numCuadros
FROM Enero17_Cuadros;

Prompt ****** 2.  �Cu�ntos cuadros con nombre distinto hay?
SELECT COUNT(DISTINCT nombre) AS numCuadrosNombreDistinto
FROM Enero17_Cuadros;

Prompt ****** 3.  �Cu�ntos cuantos cuadros titulados �autorretrato� hay?
SELECT COUNT(*) AS numCuadrosAutorretrato
FROM Enero17_Cuadros
WHERE nombre = 'Autorretrato';

Prompt ****** 4.  �Cu�ntos pintores han pintado un cuadro titulado �autorretrato�?
SELECT COUNT(*) AS numPintoresAutorretrato
FROM Enero17_Cuadros
WHERE nombre = 'Autorretrato';

Prompt ****** 5.  �Cu�ntos cuadros que no han sido expuestos en alguna exposici�n hay?
SELECT COUNT(*) AS numCuadrosNOExpuestos
FROM Enero17_Cuadros cuadro
     LEFT JOIN Enero17_Asignados asignado ON asignado.nombrePintor = cuadro.nombrePintor
                                             AND asignado.nombrecuad = cuadro.nombre
WHERE nombreExp IS NULL;

Prompt ****** 6.  Para cada t�cnica �Cu�ntos cuadros pintados hay?
SELECT tecnica, COUNT(*) AS numCuadros
FROM Enero17_Cuadros
GROUP BY tecnica;

Prompt ****** 7.  Para cada pintor �Cu�ntos cuadros ha pintado?
SELECT pintor.nombre, COUNT(DISTINCT cuadro.nombre) AS numCuadros
FROM Enero17_Pintores pintor
     LEFT JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
GROUP BY pintor.nombre;

Prompt ****** 8.  Para cada pintor �Cu�ntos cuadros ha pintado al �oleo�?
-- NO FUNCIONA: �por qu�?
SELECT pintor.nombre, COUNT(DISTINCT cuadro.nombre) AS numCuadros
FROM Enero17_Pintores pintor
     LEFT JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
WHERE tecnica = '�leo'
GROUP BY pintor.nombre;
-- Ahora S�.
SELECT pintor.nombre, COUNT(DISTINCT cuadro.nombre) AS numCuadros
FROM Enero17_Pintores pintor
     LEFT JOIN 
          (SELECT *
           FROM Enero17_Cuadros 
           WHERE tecnica = '�leo') cuadro ON pintor.nombre = cuadro.nombrePintor
GROUP BY pintor.nombre;

Prompt ****** 9.  Para cada pintor que no tenga una �i� en su pen�ltima letra �Cu�ntos cuadros?
SELECT pintor.nombre, COUNT(DISTINCT cuadro.nombre) AS numCuadros
FROM Enero17_Pintores pintor
     LEFT JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
WHERE pintor.nombre NOT LIKE '%i_' 
GROUP BY pintor.nombre;

Prompt ****** 10.  Para cada siglo con al menos 2 cuadros �Cu�ntos pintores?
SELECT cuadro.siglo, COUNT(DISTINCT pintor.nombre) AS numPintores
FROM Enero17_Pintores pintor
     RIGHT JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
GROUP BY cuadro.siglo
HAVING COUNT(*) > 1;

REM ******** CONSULTAS + SUBCONSULTAS *******************
Prompt ****** 1. Las exposiciones sin cuadros. 
-- Con subconsulta
SELECT *
FROM Enero17_Exposiciones exposicion
WHERE exposicion.nombre NOT IN (SELECT nombreExp
                                FROM Enero17_Asignados);
-- Mejor con JOIN
SELECT exposicion.*
FROM Enero17_Exposiciones exposicion
     LEFT JOIN Enero17_Asignados asignado ON exposicion.nombre = asignado.nombreExp
WHERE asignado.nombrePintor IS NULL;


Prompt ****** 2. Pintores que a lo largo de su carrera solo han pintado cuadros con un �nica t�cnica. Sin repetici�n.
-- Si no quiero los que no han pintado ning�n cuadro
SELECT nombrePintor -- SE seguro que no hay repeditos pues he agrupado por PK
FROM Enero17_Cuadros
GROUP BY nombrePintor
HAVING COUNT (DISTINCT tecnica) = 1;
-- Si considero que los que no han pintado tienen todos sus cuadros con la misma t�cnica(como en matem�ticas, conjunto vac�o)
----   OPCION A) UNION
SELECT nombrePintor -- SE seguro que no hay repeditos pues he agrupado por PK
FROM Enero17_Cuadros
GROUP BY nombrePintor
HAVING COUNT (DISTINCT tecnica) = 1
    UNION -- A�adir los que no han pintado ning�n cuadro
SELECT pintor.nombre
FROM Enero17_Cuadros cuadro
     RIGHT JOIN Enero17_Pintores pintor ON cuadro.nombrePintor = pintor.nombre
WHERE cuadro.nombrePintor IS NULL;
--      SELECT * FROM Enero17_Cuadros cuadro RIGHT JOIN Enero17_Pintores pintor ON cuadro.nombrePintor = pintor.nombre;
----   OPCION B): Sin union
SELECT nombre
FROM Enero17_Pintores
WHERE nombre IN (SELECT nombrePintor -- SE seguro que no hay repeditos pues he agrupado por PK
                 FROM Enero17_Cuadros
                      JOIN Enero17_Pintores pintor ON nombrePintor = pintor.nombre
                 GROUP BY nombrePintor
                 HAVING COUNT (DISTINCT tecnica) = 1)
       OR nombre IN (SELECT nombrePintor
                     FROM Enero17_Cuadros cuadro
                          RIGHT JOIN Enero17_Pintores pintor ON cuadro.nombrePintor = pintor.nombre
                      WHERE cuadro.nombrePintor IS NULL);
----    OPCION C simple y directa:
SELECT pintor.nombre -- SE seguro que no hay repeditos pues he agrupado por PK
FROM Enero17_Cuadros cuadro
     RIGHT JOIN Enero17_Pintores pintor ON cuadro.nombrePintor = pintor.nombre
GROUP BY pintor.nombre
HAVING COUNT (DISTINCT tecnica) <= 1;

Prompt ****** 3. Los cuadros que han sido expuestos en alguna de las exposiciones del museo �Pardo�.
SELECT DISTINCT nombrePintor, nombreCuad 
FROM Enero17_Asignados
     JOIN Enero17_Exposiciones ON nombre = nombreExp
WHERE nombreMuseo = 'Pardo';
-- Con subconsulta
SELECT DISTINCT A.nombrePintor, A.nombreCuad
FROM Enero17_Asignados A
WHERE A.nombreExp IN (
        SELECT E.nombre
        FROM Enero17_Exposiciones E
        WHERE E.nombreMuseo = 'Pardo'
    );
Prompt ****** 4. Los cuadros que han sido expuestos en todas las exposiciones del museo �Pardo�
SELECT P.nombre
FROM Enero17_Pintores P
WHERE NOT EXISTS (
        -- No existe un cuadro del pintor (C)
        SELECT C.nombre, C.nombrePintor
        FROM Enero17_Cuadros C
        WHERE C.nombrePintor = P.nombre
            -- que NO haya sido expuesto en el museo 'Pardo'
            MINUS
        SELECT  A.nombreCuad, A.nombrePintor
        FROM Enero17_Asignados A
             JOIN Enero17_Exposiciones E ON A.nombreExp = E.nombre
        WHERE E.nombreMuseo = 'Pardo'
              AND A.nombrePintor = P.nombre
    );
    
SELECT nombrePintor, nombreCuad, COUNT(*) AS numExposicionesPardo
FROM Enero17_Asignados
     JOIN Enero17_Exposiciones ON nombre = nombreExp
WHERE nombreMuseo = 'Pardo'
GROUP BY nombrePintor, nombreCuad
HAVING COUNT(DISTINCT nombreExp) = 
    (SELECT COUNT(*)
     FROM Enero17_Exposiciones
     WHERE nombreMuseo = 'Pardo'
     );
-- Con VIEW
CREATE VIEW Enero17_CuadrosAsignadosPardo AS
    (SELECT *
     FROM Enero17_Asignados
          JOIN Enero17_Exposiciones ON nombre = nombreExp
     WHERE nombreMuseo = 'Pardo'
     );
SELECT nombrePintor, nombreCuad 
FROM Enero17_CuadrosAsignadosPardo
GROUP BY nombrePintor, nombreCuad
HAVING COUNT(*) = 
    (SELECT COUNT(DISTINCT nombreExp)
     FROM Enero17_CuadrosAsignadosPardo
     );  

Prompt ****** 5. Los pintores que han exhibido todos sus cuadros en el museo �Pardo�
SELECT nombrePintor
FROM Enero17_Asignados a
     JOIN Enero17_Exposiciones  ON nombre = nombreExp
WHERE nombreMuseo = 'Pardo'
GROUP BY nombrePintor
HAVING COUNT(DISTINCT nombreCuad) = 
    ( SELECT COUNT(*)
      FROM Enero17_Cuadros c
      WHERE c.nombrePintor = a.nombrePintor
      );
-- ChatGpt SE EQUIVOCA la consulta de abajo est� mal, a saber �qu� hace?
SELECT * FROM Enero17_CuadrosAsignadosPardo;
SELECT P.nombre
FROM Enero17_Pintores P
WHERE
    NOT EXISTS (
        -- No existe un cuadro del pintor (C)
        SELECT C.nombre, C.nombrePintor
        FROM Enero17_Cuadros C
        WHERE C.nombrePintor = P.nombre
            -- que NO haya sido expuesto en el museo 'Pardo'
            MINUS
        SELECT A.nombreCuad, A.nombrePintor
        FROM Enero17_Asignados A
             JOIN Enero17_Exposiciones E ON A.nombreExp = E.nombre
        WHERE E.nombreMuseo = 'Pardo'
              AND A.nombrePintor = P.nombre
    );

Prompt ****** 6. Los pintores que han exhibido todos sus cuadros en una �nica 
Prompt exposici�n del museo �Pardo� al menos 2 veces.
SELECT nombrePintor
FROM (  SELECT nombrePintor, nombreExp
        FROM Enero17_Asignados a
             JOIN Enero17_Exposiciones  ON nombre = nombreExp
        WHERE nombreMuseo = 'Pardo'
        GROUP BY nombrePintor, nombreExp
        HAVING COUNT(DISTINCT nombreCuad) = 
            ( SELECT COUNT(*)
              FROM Enero17_Cuadros c
              WHERE c.nombrePintor = a.nombrePintor
              )
        )
GROUP BY nombrePintor
HAVING COUNT(*) >=2;

Prompt ****** 7. Los pintores que teniendo m�s de 2 cuadros no han exhibido ninguno de ellos.
-- Opci�n eficiente!!
SELECT nombrePintor
FROM Enero17_Cuadros
GROUP BY nombrePintor
HAVING COUNT(nombre) > 2
       AND nombrePintor NOT IN
            (SELECT nombrePintor
             FROM Enero17_Asignados) 
;
-- Opci�n eficiente!!
SELECT nombrePintor
FROM Enero17_Cuadros
WHERE nombrePintor NOT IN
            (SELECT nombrePintor
             FROM Enero17_Asignados) 
GROUP BY nombrePintor
HAVING COUNT(nombre) > 2
;
--  CON intersecci�n
SELECT nombrePintor -- Pintores con m�s de ds cuadros
FROM Enero17_Cuadros
GROUP BY nombrePintor
HAVING COUNT(nombre) > 2 
    INTERSECT
SELECT nombrePintor -- Pintores que no han exihibido ninguno de sus cuadros
FROM Enero17_Cuadros
GROUP BY nombrePintor
HAVING nombrePintor NOT IN
    (SELECT nombrePintor
     FROM Enero17_Asignados);

Prompt ****** 8. Pintores que han pintado todos los cuadros del siglo y nunca fueron expuestos
SELECT *
FROM Enero17_cuadros
GROUP BY nombrePintor, siglo
HAVING COUNT(DISTINCT nombrePintor) = 1
       AND nombrePintor NOT IN
    (SELECT nombrePintor
     FROM Enero17_Asignados);

Prompt ****** 8.1 Pintores que han pintado todos los cuadros del siglo y nunca fueron expuestos(los del siglo)
SELECT c.nombrePintor, c.siglo
FROM Enero17_cuadros c
GROUP BY c.nombrePintor, c.siglo
HAVING COUNT(DISTINCT nombrePintor) = 1
       AND nombrePintor NOT IN
    (SELECT a1.nombrePintor
     FROM Enero17_Asignados a1
          JOIN Enero17_Cuadros c1 ON (a1.nombrePintor = c1.nombrePintor AND a1.nombreCuad = c1.nombre)
     WHERE c.siglo = c1.siglo AND c.nombrePintor = a1.nombrePintor);

Prompt ****** 9.  Para cada a�o posterior a 1500 en el que hayan nacido m�s de 2 pintores.	 
Prompt ****** �Cu�ntos pintores cuyos nombres terminen en �a� hay?
-- NO funciona el GROUP BY �por qu�? �Qu� hace esta consulta?
SELECT EXTRACT(YEAR FROM pintor.fechaNac) year, COUNT(DISTINCT cuadro.nombre) AS numPintoresA
FROM Enero17_Pintores pintor
     LEFT JOIN Enero17_Cuadros cuadro ON pintor.nombre = cuadro.nombrePintor
WHERE pintor.nombre NOT LIKE '%a' 
      AND EXTRACT(YEAR FROM pintor.fechaNac) > 1500 
GROUP BY EXTRACT(YEAR FROM pintor.fechaNac)
HAVING COUNT(*) > 1;

-- Otra opci�n sin view, con subconsulta y legible
SELECT EXTRACT(YEAR FROM pintor.fechaNac) AS Anyo, COUNT(*) AS numPintores
FROM Enero17_Pintores pintor
WHERE pintor.nombre LIKE '%a'
      AND EXTRACT(YEAR FROM pintor.fechaNac) IN 
            (SELECT EXTRACT(YEAR FROM pintorP.fechaNac) anyo
             FROM Enero17_Pintores pintorP
			 WHERE EXTRACT(YEAR FROM pintorP.fechaNac) > 1500
             GROUP BY EXTRACT(YEAR FROM pintorP.fechaNac)
             HAVING COUNT(*)>1
             )
GROUP BY EXTRACT(YEAR FROM pintor.fechaNac);
-- Otra opci�n sin view, con subconsulta y legible, un poco m�s ineficiente que la de arriba
SELECT EXTRACT(YEAR FROM pintor.fechaNac) AS Anyo, COUNT(*) AS numPintores
FROM Enero17_Pintores pintor
     JOIN  (SELECT EXTRACT(YEAR FROM pintorP.fechaNac) anyoP
             FROM Enero17_Pintores pintorP
			 WHERE EXTRACT(YEAR FROM pintorP.fechaNac) > 1500
             GROUP BY EXTRACT(YEAR FROM pintorP.fechaNac)
             HAVING COUNT(*)>1
             ) ON EXTRACT(YEAR FROM pintor.fechaNac) = anyoP
WHERE pintor.nombre LIKE '%a'
GROUP BY EXTRACT(YEAR FROM pintor.fechaNac);

-- OTRAS IDEAS:
--   Crear una View para 
DROP VIEW Enero17_PintoresAnyoNac;
CREATE VIEW Enero17_PintoresAnyoNac AS
     (SELECT pintor.nombre, EXTRACT(YEAR FROM pintor.fechaNac) AS anyo 
      FROM Enero17_Pintores pintor);

-- Para cada a�o posterior a 1500 en el que hayan nacido m�s de 2 pintores �Cu�ntos pintores han nacido?
SELECT pintor.anyo, COUNT(*) AS numPintores
FROM Enero17_PintoresAnyoNac pintor
GROUP BY pintor.anyo
HAVING COUNT(*)>1;

-- Ya funciona con subconsulta y legible
SELECT pintor.anyo, COUNT(*) AS numPintores
FROM Enero17_PintoresAnyoNac pintor
WHERE pintor.nombre LIKE '%a'
      AND pintor.anyo IN 
            (SELECT pintorP.anyo
             FROM Enero17_PintoresAnyoNac pintorP
             GROUP BY pintorP.anyo
             HAVING COUNT(*)>1
             )
GROUP BY pintor.anyo;

-- Ya funciona sin subconsulta, menos legible
SELECT pintor1.anyo, COUNT(*) AS numPintores
FROM Enero17_PintoresAnyoNac pintor1
     JOIN   (SELECT pintorP.anyo
             FROM Enero17_PintoresAnyoNac pintorP
             GROUP BY pintorP.anyo
             HAVING COUNT(*)>1
             ) pintor2 ON pintor1.anyo = pintor2.anyo
WHERE pintor1.nombre LIKE '%a'
GROUP BY pintor1.anyo;

-- Otra opci�n, menos legible
SELECT pintor1.anyo, COUNT(*) AS numPintores
FROM (SELECT pintor0.anyo, pintor0.nombre
      FROM Enero17_PintoresAnyoNac pintor0
      WHERE pintor0.nombre LIKE '%a') pintor1
     JOIN   (SELECT pintorP.anyo
             FROM Enero17_PintoresAnyoNac pintorP
             GROUP BY pintorP.anyo
             HAVING COUNT(*)>1
             ) pintor2 ON pintor1.anyo = pintor2.anyo
GROUP BY pintor1.anyo;

-- Opci�n AE con funci�n que sustituye por null los que no cumplen la propiedad
DROP FUNCTION Enero17_onlyNombreLike;
CREATE FUNCTION Enero17_onlyNombreLike(nombre enero17_pintores.nombre%TYPE, formato VARCHAR2) RETURN enero17_pintores.nombre%TYPE IS 
    sol enero17_pintores.nombre%TYPE:= NULL;
BEGIN
    IF (nombre LIKE formato) THEN
        sol := nombre;
    END IF;
    return (sol);
END;
/
-- Con funci�n propia. La m�s eficiente!!
SELECT EXTRACT(YEAR FROM fechaNac) AS a�o, COUNT(Enero17_onlyNombreLike(nombre, '%a')) As num_pintores_con_a_final
FROM enero17_pintores p 
WHERE EXTRACT(YEAR FROM fechaNac) >1500
GROUP BY EXTRACT(YEAR FROM fechaNac)
HAVING COUNT(*) > 2;

-- Opci�n ChatGpt, igual de eficiente que arriba pero ...
SELECT EXTRACT(YEAR FROM fechaNac) AS a�o, COUNT(CASE WHEN nombre LIKE '%a' THEN 1 END) As num_pintores_con_a_final
FROM enero17_pintores p 
WHERE EXTRACT(YEAR FROM fechaNac) >1500
GROUP BY EXTRACT(YEAR FROM fechaNac)
HAVING COUNT(*) > 2;
