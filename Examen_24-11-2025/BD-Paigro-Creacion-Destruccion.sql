--Pablo Iglesias Rodrigo
--Examen 24-11-2025. Tipo 2.
--Creacion y destruccion de tablas.

DROP TABLE Parcial_Votante CASCADE CONSTRAINTS;
DROP TABLE Parcial_Politico CASCADE CONSTRAINTS;
DROP TABLE parcial_Partido CASCADE CONSTRAINTS;
DROP TABLE Parcial_Sondeo CASCADE CONSTRAINTS;


CREATE TABLE Parcial_Votante (
    dni VARCHAR2(9),
    provincia VARCHAR2(20),
    haVotado VARCHAR2(2),
    CONSTRAINT parcial_votante_PK PRIMARY KEY (dni),
    CONSTRAINT futbol_votante_CK_vot CHECK(haVotado IN('Si', 'No'))
);

CREATE TABLE Parcial_Partido (
    nombre VARCHAR2(20),
    siglas VARCHAR2(9),
    votosRecibidosPartido NUMBER(10),
    CONSTRAINT parcial_partido_PK PRIMARY KEY (siglas)
);

CREATE TABLE Parcial_Politico (
    dni VARCHAR2(9),
    nombre VARCHAR2(20),
    idPartido VARCHAR2(9),
    votosRecibidos NUMBER(10),
    CONSTRAINT parcial_politico_PK PRIMARY KEY (dni),
    CONSTRAINT parcial_politico_FK_dni FOREIGN KEY (dni)
        REFERENCES Parcial_Votante ON DELETE CASCADE,
    CONSTRAINT parcial_politico_FK_idp FOREIGN KEY (idPartido)
        REFERENCES Parcial_Partido ON DELETE CASCADE
);

CREATE TABLE Parcial_Sondeo (
    fecha TIMESTAMP,
    autor VARCHAR2(20),
    idPartido VARCHAR2(9),
    posiblesVotos NUMBER(10),
    CONSTRAINT parcial_sondeo_PK PRIMARY KEY (fecha, idPartido),
    CONSTRAINT parcial_sondeo_FK_idp FOREIGN KEY (idPartido)
        REFERENCES Parcial_Partido ON DELETE CASCADE
);