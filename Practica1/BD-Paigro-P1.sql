--PABLO IGLESIAS RODRIGO. P1.
--Preguntas:
--DEFULT NULL: establece por defecto el valor de ese atributo como NULL.
--ON DELETE CASCADE/ON DELETE SET NULL: Elimina el valor del atributo cuando se elimina la tabla a la que hace referencia/lo pone a NULL:
--UNIQUE: al ponerlo, no se pueden repetir los valores de la columna.
--Establcer columnas como NULL: con DEFAULT (x).


--Creacion de tablas:
CREATE TABLE Futbol_Persona  (
    dni VARCHAR2(9),
    nombre VARCHAR2(40) NOT NULL,
    CONSTRAINT futbol_persona_PK PRIMARY KEY (dni)
);

CREATE TABLE Futbol_Arbitro (
    dni VARCHAR2(9),
    numTemporadas NUMBER(2) NOT NULL,
    CONSTRAINT futbol_arbitro_PK PRIMARY KEY (dni),
    CONSTRAINT futbol_arbitro_FK FOREIGN KEY (dni)
        REFERENCES Futbol_Persona ON DELETE CASCADE
);

CREATE TABLE Futbol_Entrenador (
    dni VARCHAR2(9),
    CONSTRAINT futbol_entrenador_PK PRIMARY KEY (dni),
    CONSTRAINT futbol_entrenador_FK FOREIGN KEY (dni)
        REFERENCES Futbol_Persona ON DELETE CASCADE
);

CREATE TABLE Futbol_Equipo (
    nif VARCHAR2(9),
    nombre VARCHAR2(20) NOT NULL,
    presupuesto NUMBER(10),
    dni VARCHAR2(9),
    CONSTRAINT futbol_equipo_PK PRIMARY KEY (nif),
    CONSTRAINT futbol_equipo_FK FOREIGN KEY (dni)
        REFERENCES Futbol_Entrenador ON DELETE CASCADE
    
);

CREATE TABLE Futbol_Jugador(
    dni VARCHAR2(9),
    dorsal NUMBER(2),
    ficha VARCHAR2(10),
    demarcacion VARCHAR2(14),
    nif VARCHAR2(9),
    CONSTRAINT futbol_jugador_PK_dni PRIMARY KEY (dni),
    CONSTRAINT futbol_jugador_FK_dni FOREIGN KEY (dni)
        REFERENCES Futbol_Persona ON DELETE CASCADE,
    CONSTRAINT futbol_jugador_FK_nif FOREIGN KEY (nif)
        REFERENCES Futbol_Equipo ON DELETE CASCADE,
    CONSTRAINT futbol_jugador_CK_der CHECK(demarcacion IN('portero', 'defensa', 'delantero', 'centrocampista', 'lateral'))
);

CREATE TABLE Futbol_Partido(
    jornada NUMBER(2),
    estadio VARCHAR2(20),
    diaYHora DATE,
    nifLocal VARCHAR2(9),
    nifVisitante VARCHAR2(9),
    dni VARCHAR2(9),
    CONSTRAINT futbol_partido_PK PRIMARY KEY (jornada, estadio),
    CONSTRAINT futbol_partido_FK_nifLoc FOREIGN KEY (nifLocal)
        REFERENCES Futbol_Equipo ON DELETE CASCADE,
    CONSTRAINT futbol_partido_FK_nifVis FOREIGN KEY (nifVisitante)
        REFERENCES Futbol_Equipo ON DELETE CASCADE,
    CONSTRAINT futbol_partido_FK_dni FOREIGN KEY (dni)
        REFERENCES Futbol_Arbitro ON DELETE CASCADE,
    CONSTRAINT futbol_partido_CK_eqs CHECK (nifLocal != nifVisitante)
);

CREATE TABLE Futbol_Acta (
    idActa NUMBER(9),
    jornada NUMBER(2),
    estadio VARCHAR2(20),
    dni VARCHAR2(9),
    CONSTRAINT futbol_acta_PK PRIMARY KEY (idActa),
    CONSTRAINT futbol_acta_FK_partido FOREIGN KEY (jornada, estadio)
        REFERENCES Futbol_Partido ON DELETE CASCADE,
    CONSTRAINT futbol_acta_FK_arbitro FOREIGN KEY (dni)
        REFERENCES Futbol_Arbitro ON DELETE CASCADE   
);

CREATE TABLE Futbol_Incidencia (
    idActa NUMBER(9),
    minuto NUMBER(3),
    tipo VARCHAR2(14),
    explicacion VARCHAR2(50),
    CONSTRAINT futbol_incidencia_PK PRIMARY KEY (idActa, minuto),
    CONSTRAINT futbol_incidencia_FK_acta FOREIGN KEY (idActa)
        REFERENCES Futbol_Acta ON DELETE CASCADE,
    CONSTRAINT futbol_incidencia_CK_tip CHECK(tipo IN('falta', 'gol', 'fuera de banda', 'fuera de juego'))
);

CREATE TABLE Futbol_ArbitroSecundario (
    dni VARCHAR2(9),
    jornada NUMBER(2),
    estadio VARCHAR2(20),
    CONSTRAINT futbol_arbSec_PK PRIMARY KEY (dni, jornada, estadio),
    CONSTRAINT futbol_arbSec_FK_arbitro FOREIGN KEY (dni)
        REFERENCES Futbol_Arbitro ON DELETE CASCADE,
    CONSTRAINT futbol_arbSec_FK_partido FOREIGN KEY (jornada, estadio)
        REFERENCES Futbol_Partido ON DELETE CASCADE
);

CREATE TABLE Futbol_Interviene (
    dni VARCHAR2(9),
    idActa NUMBER(9),
    minuto NUMBER(3),
    sancion VARCHAR2(16),
    CONSTRAINT futbol_interviene_FK_jugador FOREIGN KEY (dni)
        REFERENCES Futbol_Jugador ON DELETE CASCADE,
    CONSTRAINT futbol_interviene_FK_Acta FOREIGN KEY (idActa, minuto)
        REFERENCES Futbol_Incidencia ON DELETE CASCADE,
    CONSTRAINT futbol_interviene_CK_san CHECK(sancion IN('tarjeta roja', 'tarjeta amarilla', 'inexixtente'))
);