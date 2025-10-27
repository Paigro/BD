--PABLO IGLESIAS RODRIGO. P2.

--Personas:
INSERT INTO futbol_persona
    VALUES('11111111A', 'David Pérez Pallas');
INSERT INTO futbol_persona
    VALUES('22222222B', 'Alexandre Alemán Pérez');
INSERT INTO futbol_persona
    VALUES('33333333C', 'Moisés Mateo Montañés');
INSERT INTO futbol_persona
    VALUES('44444444D', 'Adrián Díaz González');
INSERT INTO futbol_persona
    VALUES('55555555E', 'Juan Manuel López Amaya');
INSERT INTO futbol_persona
    VALUES('66666666F', 'Iván González González');
INSERT INTO futbol_persona
    VALUES('77777777G', 'Jorge Figueroa Vázquez'); --EL DNI del enunciado es muy largo, lo voy a acortar.
INSERT INTO futbol_persona
    VALUES('11111110A', 'Cristiano Ronaldo');
INSERT INTO futbol_persona
    VALUES('22222221B', 'Achraf Hakimi');
INSERT INTO futbol_persona
    VALUES('33333332C', 'Carvajal');
INSERT INTO futbol_persona
    VALUES('44444443D', 'Piqué');
INSERT INTO futbol_persona
    VALUES('55555554E', 'Arda Turan');
INSERT INTO futbol_persona
    VALUES('66666665F', 'Lucas');
INSERT INTO futbol_persona
    VALUES('77777779G', 'Moya');
INSERT INTO futbol_persona
    VALUES('01111110A', 'Zinedine Zidane');
INSERT INTO futbol_persona
    VALUES('02222221B', 'Luis Enrique Martinez García');
INSERT INTO futbol_persona
    VALUES('03333332C', 'Diego Simeone');
--Entrenadores:
INSERT INTO futbol_entrenador
    VALUES('01111110A');
INSERT INTO futbol_entrenador
    VALUES('02222221B');
INSERT INTO futbol_entrenador
    VALUES('03333332C');
--Equipos:
INSERT INTO futbol_equipo
    VALUES('B84030576', 'Real Madrid C.F.', '453000000', '01111110A');
INSERT INTO futbol_equipo
    VALUES('G8266298', 'F.C. Barcelona', '157000000', '02222221B');
INSERT INTO futbol_equipo
    VALUES('A80373764', 'Atlético de Madrid', '140000000', '03333332C');
--Arbitros:
INSERT INTO futbol_arbitro
    VALUES('11111111A', '10');
INSERT INTO futbol_arbitro
    VALUES('22222222B', '2');
INSERT INTO futbol_arbitro
    VALUES('33333333C', '5');
INSERT INTO futbol_arbitro
    VALUES('44444444D', '1');
INSERT INTO futbol_arbitro
    VALUES('55555555E', '23');
INSERT INTO futbol_arbitro
    VALUES('66666666F', '15');
INSERT INTO futbol_arbitro
    VALUES('77777777G', '3'); -- Igual que antes, acortdo el DNI.
--Jugadores:
INSERT INTO futbol_jugador
    VALUES('11111110A', '7', '32000000', 'delantero', 'B84030576'); --Delantero y demarcciones en minuscula.
INSERT INTO futbol_jugador
    VALUES('22222221B', '19', '6760000', 'centrocampista', 'B84030576');
INSERT INTO futbol_jugador
    VALUES('33333332C', '2 ', '4000000', 'defensa', 'B84030576');
INSERT INTO futbol_jugador
    VALUES('44444443D', '3', '5800000', 'delantero', 'G8266298');
INSERT INTO futbol_jugador
    VALUES('55555554E', '7', '4000000', 'centrocampista', 'G8266298');
INSERT INTO futbol_jugador
    VALUES('66666665F', '19', '1000000', 'defensa', 'A80373764');
INSERT INTO futbol_jugador
    VALUES('77777779G', '1', '3500000', 'portero', 'A80373764');
--Partidos:
INSERT INTO futbol_partido
    VALUES('14', 'Camp Nou', TO_DATE('03/12/2016 16:15:00','DD/MM/YYYY HH24:MI:SS'), 'G8266298', 'B84030576', '11111111A');
INSERT INTO futbol_partido
    VALUES('11', 'Vicente Calderón', TO_DATE('19/11/2016 20:45:00','DD/MM/YYYY HH24:MI:SS'), 'A80373764', 'B84030576', '66666666F');
INSERT INTO futbol_partido
    VALUES('11', 'Ramón Sánchez', TO_DATE('6/11/2016 20:45:00','DD/MM/YYYY HH24:MI:SS'), 'B84030576', 'G8266298', '33333333C'); --No existe A55662354, lo cambio por B84030576. He acortatdo el nombre.
INSERT INTO futbol_partido
    VALUES('24', 'Vicente Calderón', TO_DATE('25/02/2017 16:15:00','DD/MM/YYYY HH24:MI:SS'), 'A80373764', 'G8266298', '33333333C');
--Actas:
INSERT INTO futbol_acta
    VALUES('00000001', 14, 'Camp Nou','11111111A');
INSERT INTO futbol_acta
    VALUES('00000002', 11 , 'Vicente Calderón', '66666666F');
--Arbitros secundarios:
INSERT INTO futbol_arbitrosecundario
    VALUES('11111111A', 14 , 'Camp Nou');
INSERT INTO futbol_arbitrosecundario
    VALUES('66666666F', 11 , 'Ramón Sánchez'); --No existe 66666665F, lo cambio por 66666666F. En la jornada 11 no hubo partido en el Santiago Bernabeu. Lo cambio por Ramón Sánchez
INSERT INTO futbol_arbitrosecundario
    VALUES('66666666F', 24 , 'Vicente Calderón'); --No existe 66666665F, lo cambio por 66666666F.