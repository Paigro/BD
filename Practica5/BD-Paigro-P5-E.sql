prompt ====================Pablo Iglesias Rodrigo====================
prompt ====================P5====================

prompt

prompt ========================================
prompt -1:
SELECT can.nombre AS nombre_canal, SUM(prog.duracion) AS duracion_total
    FROM pr5b_canal can -- Cogemos los canales.
        JOIN pr5b_programacion prgm ON can.idCanal = prgm.idCanal -- Unimos con programacion para poder llegar a los programas.
        JOIN pr5b_programa prog ON prog.codPrograma = prgm.codPrograma -- Unimos con los programas porque queremos saber cuales son documentales.
    WHERE UPPER(prog.tipo) = 'DOCUMENTAL' -- Nos quedamos solo con los documentales.
        AND EXTRACT(YEAR FROM prgm.fec_hora) = 2017 -- Nos quedamos con solo lo de 2017.
        AND EXTRACT(MONTH FROM prgm.fec_hora) = 12 -- Nos quedamos solo con los de Diciembre.
    GROUP BY can.nombre, can.idcanal -- Agrupamos por nombre de canal.
    HAVING COUNT(prgm.idemision) > 3 -- Y contamos que este mas de 3 veces que es lo que pide.
;
prompt ========================================
prompt -2:
SELECT can.nombre AS nombre_canal, COUNT(*) AS n_distintos
    FROM pr5b_canal can -- Cogemos los canales.
        JOIN pr5b_programacion prgm ON can.idCanal = prgm.idCanal -- Unimos con programacion para poder llegar a los programas.
        JOIN pr5b_programa prog ON prog.codPrograma = prgm.codPrograma -- Unimos con los programas porque queremos saber cuales son documentales.
    WHERE UPPER(prog.tipo) = 'DOCUMENTAL' -- Nos quedamos solo con los documentales.
    GROUP BY can.nombre, can.idcanal, TO_CHAR(prgm.fec_hora, 'DD-MM-YYYY') -- Agrupamos por canal y por dia.
    HAVING COUNT (prgm.idcanal) > 2 -- Nos quedamos si los canales aparecen mas de 2 veces.
;
prompt ========================================
prompt -3:
SELECT can.nombre AS nombre_canal, prog.titulo AS titulo_programa, prog.duracion AS duracion_mayor
    FROM pr5b_canal can -- Cogemos los canales.
        JOIN pr5b_programacion prgm ON can.idCanal = prgm.idCanal -- Unimos con programacion para poder llegar a los programas.
        JOIN pr5b_programa prog ON prog.codPrograma = prgm.codPrograma -- Unimos con los programas porque queremos saber sus duraciones.
    WHERE prog.duracion > -- Buscamos el programa que pide y lo usamos para quedarnos con los programas programados que duran mas que ese.
        (SELECT p.duracion
            FROM pr5b_programa p
            WHERE UPPER(p.titulo) = 'LO QUE EL VIENTO SE LLEVO')
;
prompt ========================================
prompt -4:
SELECT prog.titulo AS titulo_programa
    FROM pr5b_programa prog -- Cogemos los programas.
    WHERE UPPER(prog.tipo) = 'DOCUMENTAL' -- Nos quedamos solo con los documentales.
        AND prog.codprograma NOT IN -- Con esto quitamos los programas que se han emitido en el canal dado.
            (SELECT p.codprograma
                FROM pr5b_programacion p -- Cogemos la programacion.
                    JOIN pr5b_canal c ON p.idcanal = c.idcanal -- La unimos con los canalas porque necesitamos saber el nombre del canal.
                WHERE UPPER (c.nombre) = 'ANTENA SEXTA' -- Nos quedamos con el canal dado.
                    AND p.codprograma IS NOT NULL) -- Por si acaso.
;
prompt ========================================
prompt -5:
SELECT prog.titulo AS titulo_programa, can.nombre AS nombre_canal
    FROM pr5b_canal can -- Cogemos los canales.
        JOIN pr5b_programacion prgm ON can.idCanal = prgm.idCanal -- Unimos con programacion para poder llegar a los programas.
        JOIN pr5b_programa prog ON prog.codPrograma = prgm.codPrograma -- Unimos con los programas porque queremos todos los programas.
    WHERE prog.duracion > -- Con esto nos quedamos con lo que pide de que la duracion sea mayor a la media.
        (SELECT AVG(p.duracion)
            FROM pr5b_programa p -- Cogemos los programas.
                JOIN pr5b_programacion pg ON p.codprograma = pg. codprograma -- Lo juntamos con la programacion para ver en que canales se echan cada programa
            WHERE pg.idcanal = can.idcanal) -- Solo miramos la programacion del canal en el que estamos iterando ahora.
    ORDER BY titulo ASC -- Para que quede bonito.
;
prompt ========================================
prompt -6:
SELECT DISTINCT prog.titulo AS titulo_programa, prog.tipo AS tipo_programa, prog.duracion AS duracion_programa
FROM pr5b_programa prog -- Cogemos los programas.
    JOIN pr5b_programacion prgm ON prog.codPrograma = prgm.codPrograma -- Lo unimos con la programacion para tener las fechas.
WHERE prog.duracion = -- De aqui sacamos los que su duracion sea mayor que la mayor de su tipo.
    (SELECT MAX(p.duracion) -- Cogemos el mayor de las duracion.
        FROM pr5b_programa p -- Cogemos los programas.
            JOIN pr5b_programacion pg ON p.codPrograma = pg.codPrograma -- Lo unimos con la programacion para tener las fechas.
        WHERE p.tipo = prog.tipo -- Comparamos con el tipo que iteramos arriba.
            AND EXTRACT(MONTH FROM pg.fec_hora) = EXTRACT(MONTH FROM prgm.fec_hora) -- Miramos las fechas respecto a la iteracion de arriba.
            AND EXTRACT(YEAR FROM pg.fec_hora) = EXTRACT(YEAR FROM prgm.fec_hora))
;
prompt ========================================
prompt -7:
SELECT prog.titulo AS titulo_programa, NVL(can.nombre, 'NO EMITIDO') AS nombre_canal, NVL(TO_CHAR(prgm.fec_hora, 'DD-MM-YYYY'), 'NO EMITIDO') AS fecha_emision
    FROM pr5b_programa prog -- Cogemos los programas.
        LEFT JOIN pr5b_programacion prgm ON prgm.codprograma = prog.codprograma -- Lo unimos con la programacion para saber la fecha. Es LEFT porque queremos los nulos que haya programacion.
        LEFT JOIN pr5b_canal can ON can.idcanal = prgm.idcanal -- Lo unimos con los canales para saber sus nombres. Y usamos LEFT por lo mismo, queremos los nulos.
    ORDER BY prog.titulo ASC
;
prompt ========================================
prompt -8:
SELECT prog.titulo AS titulo_programa, can.nombre AS nombre_canal, prgm.fec_hora AS fecha_emision
    FROM pr5b_programa prog -- Cogemos los programas.
        JOIN pr5b_programacion prgm ON prgm.codprograma = prog.codprograma -- Lo unimos con la programacion para saber la fecha.
        JOIN pr5b_canal can ON can.idcanal = prgm.idcanal -- Lo unimos con los canales para saber sus nombres.
        JOIN pr5b_programacion pg2 ON pg2.idCanal = prgm.idCanal -- Volvemos a unir con la programacion para comprobar cada combinacion.
    WHERE prgm.idemision <> pg2.idemision -- Con esto evitamos duplicaciones y comrpobaciones consigo mismo.
        AND pg2.fec_hora > prgm.fec_hora -- Con esto nos quedamos con los programas que despues del que estamos iterando..
        AND pg2.fec_hora < (prgm.fec_hora + prog.duracion/1440) -- Con esto nos quedamos con los que acaban despues de que empiece otro.
;



prompt ====================P5====================