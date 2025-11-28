-- Alberto de la Encina Vara
ALTER session SET nls_date_format = "DD/MM/YYYY";
DROP TABLE Enero17_Asignados CASCADE CONSTRAINTS;
DROP TABLE Enero17_Exposiciones CASCADE CONSTRAINTS;
DROP TABLE Enero17_Museos CASCADE CONSTRAINTS;
DROP TABLE Enero17_Cuadros CASCADE CONSTRAINTS;
DROP TABLE Enero17_Pintores CASCADE CONSTRAINTS; -- Permite borrarlas en cualquier orden

-- Museos(nombre, ciudad) 
CREATE TABLE Enero17_Museos(
 	nombre VARCHAR2(40) PRIMARY KEY,
	ciudad VARCHAR2(20)   
);
-- Exposiciones(nombre, fechaIni, fechaFin, nombreMuseo)
CREATE TABLE Enero17_Exposiciones(
	nombre VARCHAR2(40) CONSTRAINT Enero17_PK_exposciones PRIMARY KEY,
	fechaIni DATE,
    fechaFin DATE,
    nombreMuseo VARCHAR2(40) REFERENCES Enero17_Museos(nombre) NOT NULL
--    Otra opci�n sin indicar el tipo de datos y con FOREIGN KEY
--    FOREIGN KEY (nombreMuseo) REFERENCES Enero17_Museos(nombre),
--    CHECK nombreMuseo NOT NULL
);
-- Pintores(nombre, fechaNac, nombreMaestro) 
CREATE TABLE Enero17_Pintores(
    nombre VARCHAR2(30),
    fechaNac DATE NOT NULL,
    nombreMaestro VARCHAR2(30),
    CONSTRAINT Enero17_PK_pintores PRIMARY KEY (nombre),
    CONSTRAINT Enero17_FK_pintores FOREIGN KEY (nombreMaestro) 
               REFERENCES Enero17_Pintores(nombre) ON DELETE SET NULL
); 
-- Cuadros(nombrePintor, nombre, siglo, tecnica)
CREATE TABLE Enero17_Cuadros(
    nombrePintor VARCHAR2(30),
    nombre VARCHAR2(25),
    siglo int NOT NULL, 
    tecnica VARCHAR2(20) NOT NULL
);
ALTER TABLE  Enero17_Cuadros ADD 
    CONSTRAINT Enero17_PK_cuadros PRIMARY KEY (nombrePintor, nombre);
ALTER TABLE  Enero17_Cuadros ADD 
    CONSTRAINT Enero17_FK_cuadros FOREIGN KEY (nombrePintor) REFERENCES Enero17_Pintores(nombre)
    ON DELETE CASCADE;
ALTER TABLE Enero17_Cuadros ADD
    CONSTRAINT Enero17_CK_Tecnica
    CHECK (tecnica IN ('oleo', 'acuarela', 'acr�lico', 'carboncillo','fresco', 'desconocida'));

-- Asignados(nombreExp, nombrePintor, nombreCuad, poliza) 
CREATE TABLE Enero17_Asignados(
    nombreExp VARCHAR2(40), 
    nombrePintor VARCHAR2(30),
    nombreCuad VARCHAR2(25),
    poliza int NOT NULL,
    CONSTRAINT Enero17_PK_asignados PRIMARY KEY (nombreExp, nombrePintor, nombreCuad),
    CONSTRAINT Enero17_FK_asignados_expo FOREIGN KEY (nombreExp) 
         REFERENCES Enero17_Exposiciones(nombre),
    CONSTRAINT Enero17_FK_asignados_cuad FOREIGN KEY (nombrePintor, nombreCuad) 
         REFERENCES Enero17_Cuadros
); 

----- PINTORES -------

INSERT INTO Enero17_Pintores VALUES
('Alberto',
 '10/12/1976',
 NULL);

INSERT INTO Enero17_Pintores VALUES
('Pepe',
 '11/12/1977',
 NULL);

INSERT INTO Enero17_Pintores VALUES
('Pablo',
 '12/12/1977',
 'Pepe');

INSERT INTO Enero17_Pintores VALUES
('Pedro',
 '13/12/1978',
 'Pepe');

INSERT INTO Enero17_Pintores VALUES
('Mateo',
 '14/12/1978',
 NULL);

INSERT INTO Enero17_Pintores VALUES
('Mario',
 '15/12/1978',
 NULL);

INSERT INTO Enero17_Pintores VALUES
('Martina',
 '16/12/1978',
 'Pepe');
 
INSERT INTO Enero17_Pintores 
	VALUES ('Marta', '05/11/1478', null);

INSERT INTO Enero17_Pintores 
	VALUES ('Sofia', '05/11/1478', 'Alberto');

INSERT INTO Enero17_Pintores 
	VALUES ('Juana', '06/11/1845', 'Pepe');

INSERT INTO Enero17_Pintores 
	VALUES ('Ana', '07/11/1832', 'Pepe');


INSERT ALL
    INTO Enero17_Pintores VALUES ('Marisa', '07/11/1932', 'Pepe')
    INTO Enero17_Pintores VALUES ('Eloisa', '07/11/1942', 'Pepe')
    INTO Enero17_Pintores VALUES ('Sandra', '07/11/1952', 'Eloisa')
SELECT * FROM dual; 


----- MUSEOS ------

INSERT INTO Enero17_Museos VALUES
('Pardo',
 'Madrid');

INSERT INTO Enero17_Museos VALUES
('Reina Cristina',
 'Madrid');

----- CUADROS ------

INSERT INTO Enero17_Cuadros VALUES
('Pepe',
 'La noche',
 17,
 'oleo');

INSERT INTO Enero17_Cuadros VALUES
('Martina',
 'La noche',
 20,
 'oleo');

INSERT INTO Enero17_Cuadros VALUES
('Martina',
 'El dia',
 20,
 'oleo');

INSERT INTO Enero17_Cuadros VALUES
('Mario',
 'Autorretrato',
 10,
 'desconocida');

------ Exposiciones ------

INSERT INTO Enero17_Exposiciones VALUES
('Art Novo',
 '10/12/2020',
 '12/12/2020',
 'Pardo');

INSERT INTO Enero17_Exposiciones VALUES
('Local',
 '10/12/200',
 '12/12/200',
 'Pardo');

INSERT INTO Enero17_Exposiciones VALUES
('Art Novo2',
 '11/12/2020',
 '13/12/2020',
 'Reina Cristina');

INSERT INTO Enero17_Exposiciones VALUES
('Sin Cuadros',
 '11/12/2023',
 '13/12/2023',
 'Reina Cristina');

------ Asignados ------

INSERT INTO ENERO17_Asignados VALUES
('Art Novo',
 'Martina',
 'El dia',
 123);
 
INSERT INTO ENERO17_Asignados VALUES
('Art Novo',
 'Pepe',
 'La noche',
 123);
 
INSERT INTO ENERO17_Asignados VALUES
('Art Novo2',
 'Pepe',
 'La noche',
 1234);

INSERT INTO ENERO17_Asignados VALUES
('Local',
 'Mario',
 'Autorretrato',
 234);

INSERT INTO ENERO17_Asignados VALUES
('Art Novo',
 'Mario',
 'Autorretrato',
 234); 

ALTER TABLE ENERO17_Asignados MODIFY poliza NULL;
INSERT INTO Enero17_Exposiciones VALUES
('MIO',
 '10/12/2021',
 '12/12/2021',
 'Pardo');
INSERT INTO ENERO17_Asignados VALUES
('MIO',
 'Mario',
 'Autorretrato',
 NULL);
INSERT INTO ENERO17_Asignados VALUES
('MIO',
 'Pepe',
 'La noche',
 3231);
INSERT INTO ENERO17_Asignados VALUES
('MIO',
 'Martina',
 'El dia',
 123);
 
UPDATE ENERO17_Asignados
    SET poliza = 3231
    WHERE nombrecuad = 'El dia'; 

-- CHATGPT Inserts
ALTER session SET nls_date_format = "YYYY-MM-DD";

-- ===============================================
-- INSERTS para las tablas Enero17_* (Oracle)
-- ===============================================

-- 1. Museos
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Museo del Prado', 'Madrid');
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Museo Reina Sofia', 'Madrid');
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Louvre', 'Paris');
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Tate Modern', 'Londres');

-- 2. Exposiciones
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo)
VALUES ('Impresionismo en Paris', TO_DATE('2025-01-15','YYYY-MM-DD'), TO_DATE('2025-05-15','YYYY-MM-DD'), 'Louvre');
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo)
VALUES ('Maestros del Renacimiento', TO_DATE('2025-02-01','YYYY-MM-DD'), TO_DATE('2025-07-01','YYYY-MM-DD'), 'Museo del Prado');
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo)
VALUES ('Arte Contemporaneo Espa�ol', TO_DATE('2025-03-10','YYYY-MM-DD'), TO_DATE('2025-06-10','YYYY-MM-DD'), 'Museo Reina Sofia');
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo)
VALUES ('Modernismo Britanico', TO_DATE('2025-04-20','YYYY-MM-DD'), TO_DATE('2025-08-30','YYYY-MM-DD'), 'Tate Modern');

-- 3. Pintores
INSERT INTO Enero17_Pintores (nombre, fechaNac, nombreMaestro) VALUES ('Leonardo da Vinci', TO_DATE('1452-04-15','YYYY-MM-DD'), NULL);
INSERT INTO Enero17_Pintores (nombre, fechaNac, nombreMaestro) VALUES ('Rafael Sanzio', TO_DATE('1483-04-06','YYYY-MM-DD'), 'Leonardo da Vinci');
INSERT INTO Enero17_Pintores (nombre, fechaNac, nombreMaestro) VALUES ('Claude Monet', TO_DATE('1840-11-14','YYYY-MM-DD'), NULL);
INSERT INTO Enero17_Pintores (nombre, fechaNac, nombreMaestro) VALUES ('Pablo Picasso', TO_DATE('1881-10-25','YYYY-MM-DD'), NULL);
INSERT INTO Enero17_Pintores (nombre, fechaNac, nombreMaestro) VALUES ('Joan Miro', TO_DATE('1893-04-20','YYYY-MM-DD'), 'Pablo Picasso');

-- 4. Cuadros
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) VALUES ('Leonardo da Vinci', 'La Gioconda', 16, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) VALUES ('Rafael Sanzio', 'La Escuela de Atenas', 16, 'fresco');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) VALUES ('Claude Monet', 'Nenufares', 19, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) VALUES ('Pablo Picasso', 'Guernica', 20, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) VALUES ('Joan Miro', 'El Carnaval del Arlequin', 20, 'acuarela');

-- 5. Asignados
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza)
VALUES ('Impresionismo en Paris', 'Claude Monet', 'Nenufares', 1001);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza)
VALUES ('Maestros del Renacimiento', 'Leonardo da Vinci', 'La Gioconda', 1002);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza)
VALUES ('Maestros del Renacimiento', 'Rafael Sanzio', 'La Escuela de Atenas', 1003);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza)
VALUES ('Arte Contemporaneo Espa�ol', 'Pablo Picasso', 'Guernica', 1004);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza)
VALUES ('Arte Contemporaneo Espa�ol', 'Joan Miro', 'El Carnaval del Arlequin', 1005);


-- ######################################################################
-- # 1. INSERCI�N EN TABLAS BASE (SIN DEPENDENCIAS EXTERNAS)
-- ######################################################################

-- Museos (nombre, ciudad)
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Pardos', 'Madrid');
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Reina Sofia', 'Madrid');
INSERT INTO Enero17_Museos (nombre, ciudad) VALUES ('Louvres', 'Paris');

-- Pintores (nombre, fechaNac, nombreMaestro)

-- P1: Picasso (M�ltiples t�cnicas, n. 1881) -> NO en consulta 2
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Picasso', DATE '1881-10-25');
-- P2: Goya (�nica t�cnica: acuarela, n. 1746) -> S� en consulta 2, S� en consulta 7, S� en consulta 8
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Goya', DATE '1746-03-30'); 
-- P3: Monet (Sin cuadros, n. 1840) -> S� en consulta 2, NO en consulta 7 (no tiene > 2 cuadros)
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Monet', DATE '1840-11-14');
-- P4: Tiziano (�nica t�cnica: oleo, n. 1488) -> S� en consulta 2, Clave para consultas 4 y 5
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Tiziano', DATE '1488-01-01');
-- P5: Velazquez (M�ltiples t�cnicas, n. 1599) -> Clave para consultas 5 y 6
INSERT INTO Enero17_Pintores (nombre, fechaNac, nombreMaestro) VALUES ('Velazquez', DATE '1599-06-06', 'Goya');

-- Pintores para la Consulta 9 (Nacidos en 1518, m�s de 2, todos terminan en 'a')
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Tintoretta', DATE '1518-01-01');
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Giorgiona', DATE '1518-02-01');
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Sofonisba', DATE '1518-03-01');

-- Otros pintores para asegurar > 2 nacidos en otro a�o > 1500 (1617) que no terminan en 'a'
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Murillo', DATE '1617-01-01');
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('El Greco', DATE '1541-10-01');
INSERT INTO Enero17_Pintores (nombre, fechaNac) VALUES ('Zurbaran', DATE '1617-02-01');


-- ######################################################################
-- # 2. INSERCI�N DE EXPOSICIONES
-- ######################################################################

-- E1: Exposici�n sin cuadros (Consulta 1: Exposiciones sin cuadros)
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo) 
VALUES ('Vacio Total', DATE '2026-01-01', DATE '2026-02-01', 'Reina Sofia');
-- E2: Exposici�n en Pardo 1 (Clave para Pardo)
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo) 
VALUES ('Grandes Maestros I', DATE '2024-05-01', DATE '2024-07-01', 'Pardo');
-- E3: Exposici�n en Pardo 2 (Necesaria para "TODAS las exposiciones del Pardo" - Consulta 4)
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo) 
VALUES ('Grandes Maestros II', DATE '2024-08-01', DATE '2024-10-01', 'Pardo');
-- E4: Exposici�n en Louvre (Necesaria para NO cumplir Consulta 5)
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo) 
VALUES ('Arte Espa�ol', DATE '2024-01-01', DATE '2024-03-01', 'Louvre');


-- ######################################################################
-- # 3. INSERCI�N DE CUADROS
-- ######################################################################

-- C1: Picasso (M�ltiples t�cnicas: oleo y carboncillo)
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Picasso', 'Guernica', 20, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Picasso', 'Retrato', 20, 'carboncillo');

-- C2: Tiziano (�nica t�cnica: oleo) - S. 16. Clave para Consultas 4 y 5
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Tiziano', 'Girasoles', 16, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Tiziano', 'Venus', 16, 'oleo');

-- C3: Goya (�nica t�cnica: acuarela) - S. 18. Clave para Consultas 7 y 8.
-- TRES cuadros (requerido para Consulta 7: "m�s de 2 cuadros")
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Goya', 'Maja', 18, 'acuarela');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Goya', 'Fusilamientos', 18, 'acuarela');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Goya', 'Caprichos', 18, 'acuarela');


-- C4: Velazquez (M�ltiples t�cnicas: acuarela y oleo) - S. 17. Clave para Consultas 5 y 6.
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Velazquez', 'Meninas', 17, 'acuarela');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Velazquez', 'Hilanderas', 17, 'oleo');

-- Cuadros de pintores nacidos en 1518 (S. 16) - NO expuestos (Clave para Consulta 8: "nunca fueron expuestos")
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Tintoretta', 'Obra S16-1', 16, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Giorgiona', 'Obra S16-2', 16, 'oleo');
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Sofonisba', 'Obra S16-3', 16, 'oleo');


-- ######################################################################
-- # 4. INSERCI�N DE ASIGNACIONES (EXPOSICI�N DE CUADROS)
-- ######################################################################

-- C1: Picasso 'Guernica' en E2 (Pardo)
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros I', 'Picasso', 'Guernica', 101);
-- C1: Picasso 'Retrato' en E4 (Louvre) -> Picasso NO cumple "todos en Pardo" (Consulta 5)
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Arte Espa�ol', 'Picasso', 'Retrato', 102); 

-- C2: Tiziano 'Girasoles' en E2 y E3 (Pardo)
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros I', 'Tiziano', 'Girasoles', 201);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros II', 'Tiziano', 'Girasoles', 202); -- Necesario para Consulta 4
-- C2: Tiziano 'Venus' en E2 y E3 (Pardo)
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros I', 'Tiziano', 'Venus', 203);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros II', 'Tiziano', 'Venus', 204); -- Necesario para Consulta 4

-- C4: Velazquez en E2 (Pardo) -> Velazquez S� cumple Consulta 6 (todos sus cuadros en UNA �NICA expo del Pardo)
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros I', 'Velazquez', 'Meninas', 301);
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros I', 'Velazquez', 'Hilanderas', 302);

-- E5: Exposici�n en Pardo 3
INSERT INTO Enero17_Exposiciones (nombre, fechaIni, fechaFin, nombreMuseo) 
VALUES ('Grandes Maestros III', DATE '2025-01-01', DATE '2025-03-01', 'Pardo');
-- Cuadro para Velazquez (usado antes, ahora lo asignamos a E5 para que NO cumpla)
-- Velazquez 'Meninas' (C7) en E5.
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros III', 'Velazquez', 'Meninas', 303);

-- Cuadro para Pardo que NO cumple la condici�n "TODAS" (Se queda en solo una expo)
-- C9: Murillo 'Inmaculada' - S. 17
INSERT INTO Enero17_Cuadros (nombrePintor, nombre, siglo, tecnica) 
VALUES ('Murillo', 'Inmaculada', 17, 'oleo');

-- Asignaci�n de 'Inmaculada' solo a E2 (Pardo)
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros I', 'Murillo', 'Inmaculada', 401);


-- ?? Actualizaci�n de Tiziano (Para que siga CUMPLIENDO la condici�n "TODAS" - C4)
-- Tiziano 'Girasoles' en E5
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros III', 'Tiziano', 'Girasoles', 205);
-- Tiziano 'Venus' en E5
INSERT INTO Enero17_Asignados (nombreExp, nombrePintor, nombreCuad, poliza) 
VALUES ('Grandes Maestros III', 'Tiziano', 'Venus', 206);

ALTER session SET nls_date_format = "DD/MM/YYYY";