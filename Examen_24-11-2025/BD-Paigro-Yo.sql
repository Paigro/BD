--Pablo Iglesias Rodrigo
--Examen 24-11-2025. Tipo 2.
--Mis respuestas.


prompt ------1
--1: escribe una consulta para determinar, sin repeticiones, los partidos que no habiendo aparecido en los sondeos
--tengan mas votos que alguno de los partidos que aparecen en los sondeos. Esquema: (NombrePartido)
SELECT partido.nombre AS NombrePartido
    FROM parcial_partido partido
    WHERE partido.siglas NOT IN 
        (SELECT sondeo.idpartido
            FROM parcial_sondeo sondeo)
        AND partido.votosrecibidospartido >= 
            (SELECT MIN(p.votosrecibidospartido)
                FROM parcial_partido p
                    JOIN parcial_sondeo s ON p.siglas = s.idpartido)                                               
;
prompt ------2
--2: Escribe una consulta para determinar los politicos que habiendo votado, no son del partido 'Los Milagros',
--y que ademas tengan los DNI con la letra Z y cuyo penultimo digito sea un 3, y los que tienen un DNI con la letra A,
--ordenado ascendentemente. Esquema: (NombrePolitico)
SELECT politico.nombre AS NombrePolitico
    FROM parcial_politico politico
    WHERE politico.dni IN 
        (SELECT v.dni
            FROM parcial_votante v
            WHERE v.havotado = 'Si')
        AND politico.dni like '%A'
        OR politico.dni like '%3Z'
        AND politico.dni NOT IN
            (SELECT po.dni
                FROM parcial_politico po
                    JOIN parcial_partido pa ON po.idpartido = pa.siglas
                WHERE pa.nombre = 'Los Milagros')
;
prompt ------3
--3: Escribe una consulta para determinar los partidos con datos coherentes en la Base de Datos. Es decir, aquellos partidos
--cuyos votos corresponden con la suma de los votos de los votos de los politicos de su partido. Esquema: (SiglasPartido)
SELECT partido.siglas AS SiglasPartido
    FROM parcial_partido partido
    WHERE partido.votosrecibidospartido =
        (SELECT SUM(p.votosrecibidos)
            FROM parcial_politico p
            WHERE p.idpartido = partido.siglas)
;
prompt ------4
--4: Escribe una consulta para determinar el nombre de los partidos politicos cuyos sondeos arrojen intenciones de voto que se han
--ido decrementando a los largo del tiempo en todos los sondeos. Esquema: (NombrePartido)



prompt ------5
--5: Escribe una consulta para determinar para cada autor de cada sondeo las veces que ha fallado. Deben aparecer todos los autores
--de sondeos. Esquema: (AutorSondeo, NumFallos)
SELECT sondeo.autor AS AutorSondeo, COUNT(*) AS NumeroFallos
    FROM parcial_sondeo sondeo
    GROUP BY sondeo.autor
    HAVING sondeo.posiblesvotos <>
        (SELECT p.votosRecibidosPartido
            FROM parcial_partido p
            WHERE p.siglas = sondeo.idPartido)
;
prompt ------6
--6: Escribe una consulta para determinar la diferencia (en valor absoluto) entre los votos reales recibidos y la media de votos de
--los sondeos que se hicieron para cada partido. Ten en cuenta, que puede que no aparezca algun partido en ningun sondeo. Esquema:
--(NombrePartido, Diferencia)

;