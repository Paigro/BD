--Pablo Iglesias Rodrigo
--Examen 24-11-2025. Tipo 2.
--Correccion.

prompt ------1
--1: escribe una consulta para determinar, sin repeticiones, los partidos que no habiendo aparecido en los sondeos
--tengan mas votos que alguno de los partidos que aparecen en los sondeos. Esquema: (NombrePartido)



prompt ------2
--2: Escribe una consulta para determinar los politicos que habiendo votado, no son del partido 'Los Milagros',
--y que ademas tengan los DNI con la letra Z y cuyo penultimo digito sea un 3, y los que tienen un DNI con la letra A,
--ordenado ascendentemente. Esquema: (NombrePolitico)



prompt ------3
--3: Escribe una consulta para determinar los partidos con datos coherentes en la Base de Datos. Es decir, aquellos partidos
--cuyos votos corresponden con la suma de los votos de los votos de los politicos de su partido. Esquema: (SiglasPartido)



prompt ------4
--4: Escribe una consulta para determinar el nombre de los partidos politicos cuyos sondeos arrojen intenciones de voto que se han
--ido decrementando a los largo del tiempo en todos los sondeos. Esquema: (NombrePartido)



prompt ------5
--5: Escribe una consulta para determinar para cada autor de cada sondeo las veces que ha fallado. Deben aparecer todos los autores
--de sondeos. Esquema: (AutorSondeo, NumFallos)



prompt ------6
--6: Escribe una consulta para determinar la diferencia (en valor absoluto) entre los votos reales recibidos y la media de votos de
--los sondeos que se hicieron para cada partido. Ten en cuenta, que puede que no aparezca algun partido en ningun sondeo. Esquema:
--(NombrePartido, Diferencia)
SELECT partido.nombre AS NombrePartido, ABS(partido.votosrecibidospartido - (SELECT NULL(AVG(s.posiblesvotos), 0)
                                                                                FROM parcial_sondeo s
                                                                                WHERE s.idpartido = partido.siglas)) AS Diferencia
    FROM parcial_partido partido
;
--o:
SELECT partido.nombre AS NombrePartido, NULL(partido.votosrecibidospartido - AVG(sondeo.posiblesvotos), 0) AS Diferencia
    FROM parcial_partido partido
        LEFT JOIN parcial_sondeo sondeo ON psondeo.idpartido = partido.siglas
    GROUP BY partido.siglas, aprtido.nombre, partido.votosrecibidospartido
;



















