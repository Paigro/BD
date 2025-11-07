--Pablo Iglesias Rodrigo.
--Practica 4.


prompt ------1
--1: muestra el nombre de los canales y el tiempo total dedicado a documentales en el mes de diciembre de 2017
--de aquellos canales que han emitido mas de 3 documentales en ese periodo.
SELECT can.nombre AS nombre_canal, SUM(prog.duracion) AS duracion_total
    FROM pr5b_programa prog
        JOIN pr5b_programacion progs ON prog.codprograma = progs.codprograma
        LEFT JOIN pr5b_canal can ON can.idcanal = progs.idcanal
   WHERE prog.tipo = 'documental'
    AND EXTRACT(MONTH FROM progs.fec_hora) = 12
        AND EXTRACT(YEAR FROM progs.fec_hora) = 2017
    GROUP BY(can.nombre)
    HAVING COUNT(progs.idcanal) > 3
 ;           
prompt ------2
--2: muestra el nombre de los canales que emiten mas de 2 documentales distintos el mismo da. NOTA: recuerda
--que puedes agrupar por columnas, pero tambien por expresiones (con operadores, funciones, etc.).
SELECT can.nombre AS nombre_canal, COUNT(progs.idcanal)
    FROM pr5b_programa prog
        JOIN pr5b_programacion progs ON prog.codprograma = progs.codprograma
        LEFT JOIN pr5b_canal can ON can.idcanal = progs.idcanal
    WHERE prog.tipo = 'documental'
    GROUP BY(TO_CHAR(progs.fec_hora, 'DD-MM-YYYY')), can.nombre
    HAVING COUNT(progs.idcanal) > 2
;
prompt ------3
--3: muestra el nombre de los canales que han programado algun programa con una duracion mayor a la de Lo
--que el viento se llevo, junto con el ttulo del programa y su duracion.
SELECT can.nombre AS nombre, prog.titulo, prog.duracion
    FROM pr5b_canal can
        JOIN pr5b_programacion progs ON can.idcanal = progs.idcanal
        JOIN pr5b_programa prog ON prog.codprograma = progs.codprograma
    WHERE prog.duracion > 
        (SELECT prog.duracion 
            FROM pr5b_programa prog
            WHERE prog.titulo = 'Lo que el viento se llevo')
    

;
prompt ------4
--4: muestra el ttulo de los documentales que no se han emitido nunca en el canal con nombre Antena Sexta.
SELECT prog.titulo 
    FROM pr5b_programa prog
    WHERE prog.tipo = 'documental'
        AND prog.codprograma NOT IN
            (SELECT progs.codprograma
                FROM pr5b_programacion progs
                    JOIN pr5b_canal can ON progs.idcanal = can.idcanal
                WHERE can.nombre = 'Antena Sexta')
;
prompt ------5
--5: para los programas que se emiten en algun canal, muestra el ttulo del programa y el nombre del canal en el
--que se emite de aquellos programas que cumplen la siguiente condicion: la duracion del programa es mayor a
--la duracion media de los programas emitidos en ese mismo canal.
SELECT *
    FROM pr5b_programa prog

;
prompt ------6
--6: muestra el ttulo de los programas de mayor duracion de cada tipo de los emitidos en el mismo mes en
--cualquier canal.



prompt ------7
--7: muestra los ttulos de todos los programas, con el nombre del canal y la fecha en la que han sido emitidos. Si
--un programa no ha sido emitido nunca, se debe indicar como canal el texto NO EMITIDO.



prompt ------8
--8: muestra la lista de los errores de programacion de TV: aquellos programas (codprograma, canal y fecha/hora
--de emision) que se solapan con otro en el tiempo en un mismo canal. Debe mostrar aquellos programas
--que terminan despues de la hora de inicio del siguiente programa del mismo canal. NOTA: para sumar una
--cantidad de minutos a una fecha se debe utilizar la siguiente expresion: fecha + minutos/1440.


