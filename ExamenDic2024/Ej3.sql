--Ejercicio 3.

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
    ORDER BY ent.entrenador DESC, ent.socio ASC -- Ordenamos como dice el enunciado.
;

--Apartado B: Determinar las instalaciones que no han sido reservadas por ningún socio, mostrando el 
--  código y descripción. Ordena por código ascendentemente. Esquema: (Codigo, Descripcion).
SELECT ins.codigo AS codigo, ins.descripcion AS descripcion
    FROM t_instalacion ins -- Cogemos la tabla de instalaciones.
    WHERE ins.codigo NOT IN -- Con esto nos quedamos con las que no estan reservadas.
        (SELECT res.codigo --Subconsulta correlacionada para coger las instalaciones que estan en la tabla de reservas.
            FROM t_reserva res
            WHERE res.instalacion = ins.codigo)
    ORDER BY ins.codigo ASC -- Ordenamos como pide el enunciado.
;

--Aparatado C: Determinar los ingresos del club por reservas de socios con plan ‘Anual’ que no tengan 
--  entrenadores. Si no hay reservas de ese tipo se debe devolver 0. Esquema: (IngresosTotales).
SELECT NVL(SUM(res.precio), 0 ) AS ingresos_totales
    FROM t_reserva res -- Cogemos la tabla reservas.
        JOIN t_socio soc ON soc.codigo = res.socio -- La unimos con socio porque necesitamos el plan y su codigo. 
    WHERE soc.plan = 'Anual' -- Queremos solo los que tienen el pkan anual.
        AND soc.entrenador NOT IN -- Con esto quitamos los socios que estan en entrena => los que tienen entrenador.
            (SELECT ent.entrenador
                FROM t_entrena ent
                WHERE ent.socio = soc.codigo)
;

--Apartado D: Determinar los socios que en total han pagado menos dinero por sus reservas que lo que 
-- ha pagado la socia 'Elena Gómez' por las suyas. Esquema: (Codigo, Nombre, TotalPagado).
SELECT *
    FROM
;















