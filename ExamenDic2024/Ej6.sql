--Ejercicio 6 (ejercicio 4)
-- NOTA: los comentarios estan asi pora que se vean con la extension de VS Code de Better Comments.

--Examina el siguiente script SQL de Oracle, que se ejecuta nada más iniciar 
--  sesión. 

/*
SET AUTOCOMMIT OFF;
--* Commit previo a CREATE.
01: CREATE TABLE Alien( idAlien NUMBER PRIMARY KEY, poder VARCHAR2(20) );
--* Commit posterior a CREATE.
--TODO Transaccion 1:
02: INSERT INTO Alien VALUES (222, 'telepatía');
03: SAVEPOINT inicio;
04: INSERT INTO Alien VALUES (888, 'control del fuego');
--* Commit previo a ALTER.
05: ALTER TABLE Alien ADD edad INT DEFAULT null;
--* Commit posterior a ALTER.
--TODO: Transaccion 2:
06: ROLLBACK TO SAVEPOINT inicio; --! Da error porque no se puede hacer rollback a otra transaccion, tras el ALTER(05) se hace COMMIT. 
07: INSERT INTO Alien (idAlien, poder) VALUES (333, 'metamorfosis');
08: COMMIT;
--* Commit de COMMIT.
--TODO Transaccion 3:
09: INSERT INTO Alien VALUES (111, 'invisibilidad', 10);
10: SAVEPOINT medio; --? Sobra porque no se usa.
11: UPDATE Alien SET edad = edad + 2 WHERE idAlien < 500;
12: INSERT INTO Alien VALUES (555, 'levitación'); --! Da error porque no tiene todos los valores necesarios para insertar en Alien.
13: SAVEPOINT fin;
14: INSERT INTO Alien VALUES (444, 'termovisión', 3);
15: ROLLBACK TO SAVEPOINT fin;
16: INSERT INTO Alien VALUES (666, 'sanación', 6);
--* Commit previo a CREATE.
17: CREATE TABLE Planeta (idPlaneta INT PRIMARY KEY, nombre VARCHAR2(20) );
--* Commit posterior a CREATE.
--TODO Transaccion 4:
18: INSERT INTO Planeta VALUES (23, 'Rudicutin');
19: ROLLBACK;
--* Fin.
*/

--Apartado A: Indica las instrucciones de control de transacciones que son innecesarias y las instrucciones que 
--  provocan error, explicando el motivo. 

/*
    Error: 06 (no se puede hacer ROLLBACK a un SAVEPOINT de otra transaccion) y 12 (faltan valores en el INSERT).
    Sobra: 10 (No se usa).
*/

--Apartado B: ¿Qué datos y qué tablas con qué atributos quedan al final de la ejecución del script? 

/*
    Tabla Alien: id-poder-edad
        222-telepatia-NULL (NULL+2=NULL)
        888-fuego-NULL
        333-metamorfosis-NULL (NULL+2=NULL)
        111-invisibilidad-12 (10+2=12)
        666-sanacion-6
    Tabla Planeta: id-nombre
*/

--Apartado C: ¿Cuántas transacciones se han ejecutado? Indica el inicio y el fin de cada una de ellas usando los 
--  números de línea. 

/*
    4 transacciones:
        02-05
        07-08
        09-17
        17-19
*/
