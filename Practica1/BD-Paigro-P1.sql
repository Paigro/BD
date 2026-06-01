--PABLO IGLESIAS RODRIGO.
--P1.
--Preguntas:
--DEFULT NULL: establece por defecto el valor de ese atributo como NULL.
--ON DELETE CASCADE/ON DELETE SET NULL: Elimina el valor del atributo cuando se elimina la tabla a la que hace referencia/lo pone a NULL:
--UNIQUE: al ponerlo, no se pueden repetir los valores de la columna.
--Establcer columnas como NULL: con DEFAULT (x).


CREATE TABLE p1_persona (
    dni VARCHAR2(9),
    nombre VARCHAR2(40) NOT NULL,
    
    CONSTRAINT p1_persona_PK PRIMARY KEY (dni)
);

CREATE TABLE p1_arbitro(
    dni VARCHAR2(9),
    numTemporadas NUMBER(2) NOT NULL,
    
    CONSTRAINT p1_arbitro_PK PRIMARY KEY (dni),
    CONSTRAINT p1_arbitro_FK FOREIGN KEY (dni)
        REFERENCES p1_persona ON DELETE CASCADE
);

CREATE TABLE p1_entrenador(
    dni VARCHAR2(9),
    
    CONSTRAINT p1_entrenador_PK PRIMARY KEY (dni),
    CONSTRAINT p1_entrenador_FK FOREIGN KEY (dni)
        REFERENCES p1_persona ON DELETE CASCADE
);

CREATE TABLE p1_equipo(
    nif VARCHAR2(9),
    nombre VARCHAR2(20) NOT NULL,
    presupuesto NUMBER(20) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    
    CONSTRAINT p1_equipo_PK PRIMARY KEY (nif),
    CONSTRAINT p1_equipo_FK FOREIGN KEY (dni)
        REFERENCES p1_entrenador ON DELETE CASCADE
);

CREATE TABLE p1_jugador(
    dni VARCHAR2(9),
    dorsal NUMBER(2) NOT NULL,
    ficha VARCHAR2(10) NOT NULL,
    demarcacion VARCHAR2(14) NOT NULL,
    nif VARCHAR2(9) NOT NULL,
    
    CONSTRAINT p1_jugador_PK PRIMARY KEY (dni),
    CONSTRAINT p1_jugador_FK_dni FOREIGN KEY (dni)
        REFERENCES P1_Persona ON DELETE CASCADE,
    CONSTRAINT p1_jugador_FK_nif FOREIGN KEY (nif)
        REFERENCES p1_equipo ON DELETE CASCADE,
    CONSTRAINT p1_jugador_CK_dem CHECK (demarcacion IN('portero', 'defensa', 'delantero', 'centrocampista', 'lateral'))
);

CREATE TABLE p1_partido(
    jornada NUMBER(2),
    estadio VARCHAR2(20),
    diaYHora DATE NOT NULL,
    nifLocal VARCHAR2(9) NOT NULL,
    nifVisitante VARCHAR2(9) NOT NULL,
    dni VARCHAR2(9) NOT NULL,
    
    CONSTRAINT p1_partido_PK_ PRIMARY KEY (jornada, estadio),
    CONSTRAINT p1_partido_FK_nifLoc FOREIGN KEY (nifLocal)
        REFERENCES p1_equipo ON DELETE CASCADE,
    CONSTRAINT p1_partido_FK_nifVis FOREIGN KEY (nifVisitante)
        REFERENCES p1_equipo ON DELETE CASCADE,
    CONSTRAINT p1_partido_FK_dni FOREIGN KEY (dni)
        REFERENCES p1_arbitro ON DELETE CASCADE,
    CONSTRAINT p1_partido_CK_nifs CHECK (nifLocal!= nifVisitante)
);

CREATE TABLE p1_acta(
    idActa NUMBER(9),
    jornada NUMBER(2),
    estadio VARCHAR(20),
    dni VARCHAR2(9),
    
    CONSTRAINT p1_acta_PK PRIMARY KEY (idActa),
    CONSTRAINT p1_acta_FK_par FOREIGN KEY (jornada, estadio)
        REFERENCES p1_partido ON DELETE CASCADE,
    CONSTRAINT p1_acta_FK_dni FOREIGN KEY (dni)
        REFERENCES p1_arbitro ON DELETE CASCADE   
);

CREATE TABLE p1_incidencia(
    minuto NUMBER(3),
    idActa NUMBER(9),
    tipo VARCHAR2(14) NOT NULL,
    explicacion VARCHAR2(50),
    
    CONSTRAINT p1_incidencia_PK PRIMARY KEY (minuto, idActa),
    CONSTRAINT p1_incidencia_FK FOREIGN KEY (idActa)
        REFERENCES p1_acta,
    CONSTRAINT p1_incidencia_CK CHECK (tipo IN('falta', 'gol', 'fuera de banda', 'fuera de juego'))
);

CREATE TABLE p1_arbitroSec(
    dni VARCHAR2(9),
    jornada NUMBER(2),
    estadio VARCHAR2(20),
    
    CONSTRAINT p1_arbSec_PK PRIMARY KEY (dni, jornada, estadio),
    CONSTRAINT p1_arbSec_FK_dni FOREIGN KEY (dni)
        REFERENCES p1_arbitro ON DELETE CASCADE,
    CONSTRAINT p1_arbSec_FK_par FOREIGN KEY (jornada, estadio)
        REFERENCES p1_partido ON DELETE CASCADE
);

CREATE TABLE p1_interviene (
    dni VARCHAR2(9),
    idActa NUMBER(9),
    minuto NUMBER(3),
    sancion VARCHAR2(16) NOT NULL,
    
    CONSTRAINT p1_interviene_FK_dni FOREIGN KEY (dni)
        REFERENCES p1_jugador ON DELETE CASCADE,
    CONSTRAINT p1_interviene_FK_Act FOREIGN KEY (idActa, minuto)
        REFERENCES p1_incidencia ON DELETE CASCADE,
    CONSTRAINT p1_interviene_CK CHECK(sancion IN('tarjeta roja', 'tarjeta amarilla', 'inexixtente'))
);
