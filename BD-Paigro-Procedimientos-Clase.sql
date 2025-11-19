--Pablo Iglesias Rodrigo
--Procedimientos ejercicios clase.

prompt ------1
--Crear procedimiento encargado de generar la tabla MAESTROS(nombrePintor, nAlumnos). Usar cursor para meter los datos.

DROP TABLE enero17_maestros;
CREATE TABLE enero17_maestros(
            nombrePintor VARCHAR2(40),--enero17_pintores%TYPE,
            nAlumnos INTEGER,
            CONSTRAINT enero17_nombrePintor_PK PRIMARY KEY(nombrePintor),
            CONSTRAINT enero17_nombrePintor_FK FOREIGN KEY(nombrePintor)
                REFERENCES enero17_pintores(nombre) ON DELETE SET NULL
            );

--Para que aparezcan los errores de programacion, ponerlo siempre.
SET SERVEROUTPUT ON 
            
DROP PROCEDURE enero17_maestros_proc;
/
CREATE PROCEDURE enero17_maestros_proc IS
    CURSOR c_alumnosMaestros IS
        SELECT maes.nombre, COUNT(*) AS nAlumnos
                FROM enero17_pintores maes
                    JOIN enero17_pintores alum ON maes.nombre = alum.nombreMaestro
                GROUP BY maes.nombre
                ;
    BEGIN 
        FOR maestro IN c_alumnosMaestros LOOP
            INSERT INTO enero17_maestros VALUES maestro;
        END LOOP;          
    END;
/ 
--Fin de bloque de codigo de PL-SQL.

--Ejecutamos el proceso.
EXECUTE enero17_maestros_proc;

--Miramos a ver si ha funcionado.
SELECT * 
    FROM enero17_maestros;

--Todo esto se puede hacer mejor simplemente en un INSERT metiendo los valores recibidos del SELECT, pero si no supiesemos eso se tenadria que hacer con cursores.
--Ahora el problema es que hay que tener la tabla enero17_maestros actualizada automaticamente tras modificaciones en la tabla de enero17_pintores, Eso con disparadores. 


