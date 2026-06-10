--Ejercicio 3 (ejercicio 3 apartados A, B, C, D y E)

/* -- Tablas:

Entrenador (NSS, nombre, fechaInicio) 

Socio (codigo, nombre, email, plan) 

Instalación (codigo, descripcion) 

Reserva (socio, instalacion, fecha, precio) 
    C.E. socio de Socio (codigo) 
    C.E. instalacion de Instalacion (codigo) 

Entrena(entrenador, socio) 
    C.E. socio de Socio (codigo) 
    C.E. entrenador de Entrenador (NSS)

*/

--Apartado A: Determinar los entrenadores que entrenan a más de 2 socios, indicando el NSS del 
--  entrenador y el número de socios a los que entrena. Ordena por el entrenador descendentemente y después 
--  por número de socios entrenados ascendentemente. Esquema: (Entrenador, NumeroSocios).
SELECT ent.entrenador AS codigo_entrendor, COUNT(ent.socio) AS n_socios
    FROM t_entrena ent -- Cogemos la tabla Entrena.
    GROUP BY ent.entrenador -- Agrupamos por entrenador.
    HAVING COUNT(ent.socio) > 2 -- Nos quedamos con los que tienen mas de 2 socios.
    ORDER BY ent.entrenador DESC, COUNT(ent.socio) ASC -- Ordenamos como dice el enunciado.
;

--Apartado B: Determinar las instalaciones que no han sido reservadas por ningún socio, mostrando el 
--  código y descripción. Ordena por código ascendentemente. Esquema: (Codigo, Descripcion).
SELECT ins.codigo AS codigo_instalacion, ins.descripcion AS descripcion_instalacion
    FROM t_instalacion ins -- Cogemos la tabla de instalaciones.
    WHERE ins.codigo NOT IN -- Con esto nos quedamos con las que no estan reservadas.
        (SELECT res.instalacion --Subconsulta correlacionada para coger las instalaciones que estan en la tabla de reservas.
            FROM t_reserva res)
    ORDER BY ins.codigo ASC -- Ordenamos como pide el enunciado.
;

--Aparatado C: Determinar los ingresos del club por reservas de socios con plan ‘Anual’ que no tengan 
--  entrenadores. Si no hay reservas de ese tipo se debe devolver 0. Esquema: (IngresosTotales).
SELECT NVL(SUM(res.precio), 0 ) AS ingresos_totales
    FROM t_reserva res -- Cogemos la tabla reservas.
        JOIN t_socio soc ON soc.codigo = res.socio -- La unimos con socio porque necesitamos el plan y su codigo. 
    WHERE soc.plan = 'Anual' -- Queremos solo los que tienen el pkan anual.
        AND soc.codigo NOT IN -- Con esto quitamos los socios que estan en entrena => los que tienen entrenador.
            (SELECT ent.socio
                FROM t_entrena ent
                WHERE ent.socio = soc.codigo)
;

--Apartado D: Determinar los socios que en total han pagado menos dinero por sus reservas que lo que 
-- ha pagado la socia 'Elena Gómez' por las suyas. Esquema: (Codigo, Nombre, TotalPagado).
SELECT soc.codigo AS codigo_socio, soc.nombre AS nombre_socio, NVL(SUM (res.precio), 0) AS total_pagado
    FROM t_reserva res -- Cogemos la tabla reservas.
        JOIN t_socio soc ON soc.codigo = res.socio -- Unimos con socio porque queremos sus datos.
    GROUP BY soc.codigo, soc.nombre -- Agrupamos las reservas de cada uno. Cogemos el nombre tambien para poder usarlo luego.
    HAVING SUM(res.precio) < -- Solo los que han pagado menos que Elena.
        (SELECT NVL(SUM (r.precio), 0) -- De aqui sacamos lo que ha pagado Elena en total en todas sus reservas. NVL por si acaso.
            FROM t_reserva r
                JOIN t_socio s ON s.codigo = r.socio
                WHERE s.nombre = 'Elena Gómez')        
;

--Apartado E: Determinar la reserva de instalación más reciente realizada por un socio que tiene 
--  entrenador. Muestra el código, la descripción y la fecha de reserva de esa instalación. Si hay varias 
--  instalaciones en esa fecha reservadas por socios con entrenador deberá mostrarlas todas ordenadas por 
--  código descendentemente. Esquema: (Codigo, Descripcion, Fecha). 
SELECT ins.codigo AS codigo_instalacion, ins.descripcion AS descripcion_instalacion, res.fecha AS fecha_reserva
    FROM t_instalacion ins -- Cogemos la tabla con las instalaciones.
        JOIN t_reserva res ON res.instalacion = ins.codigo -- Unimos con las reservas.
    WHERE res.socio IN -- De aqui sacamos los socios que tienen entrenador.
        (SELECT e.socio
            FROM t_entrena e)
        AND res.fecha = -- De aqui sacamos la fecha mas reciente.
            (SELECT MAX(r.fecha)
                FROM t_reserva r
                WHERE r.socio IN -- Lo mismo que antes, solo queremos los socios con entrenadores.
                    (SELECT e.socio
                        FROM t_entrena e))
    ORDER BY ins.codigo DESC -- Ordenamos como pide el enunciado.
; 
