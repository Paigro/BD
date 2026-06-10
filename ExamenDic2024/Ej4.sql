--Ejercicio 4 (ejercicio 3 apartado F)

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

--Apartado A: Escribe un procedimiento PL/SQL que reciba un NSS de un entrenador y escriba (sólo si 
--  existe dicho entrenador en la base de datos) una primera línea con el NSS y nombre del entrenador. 
--  Posteriormente debe ir listando de cada uno de los socios entrenados por dicho entrenador el código y 
--  nombre, seguido de un listado de cada una de sus reservas en orden cronológico incluyendo la fecha, 
--  instalación y precio, y una línea final con el número total de reservas de dicho socio y suma de sus 
--  precios.  

--  Finalmente se debe mostrar número total de socios que entrena el entrenador, la suma total de reservas de 
--  sus socios y la suma total de sus precios. Si el entrenador no existe, se debe mostrar un mensaje de error 
--  en la consola. Unas posibles salidas de este procedimiento serían las siguientes: 

/*
exec listar_socios('123456789'); 
 
NSS Entrenador: 123456789 Nombre: Juan Pérez ------------------------------------ 
Codigo Socio: S001 Nombre: 
Ana Martínez 
Fecha: 15/03/23 Instalación:I001 Precio20 
Número de Reservas: 1 Suma de Precios:20 
 
Codigo Socio: S003 Nombre: Elena Gómez 
Fecha: 17/03/23 Instalación: I003 Precio: 10 
Fecha: 20/03/23 Instalación: I003 Precio: 15 
Número de Reservas: 2 Suma de Precios: 25 
 ------------------------------------ 
Número de Socios Entrenados: 2 
Número Total de Reservas: 3 
Suma Total de Precios:45 --- 
 
exec listar_socios('?????'); 
 
¡No se ha encontrado el entrenador: ?????!
*/

CREATE OR REPLACE PROCEDURE listar_socios (NSS_entrenador t_entrenador.NSS%TYPE)
    IS

        v_nombre_entrenador t_entrenador.nombre%TYPE; -- Nombre del entrenador para luego escribirlo.
        v_exists BOOLEAN := false; -- Si existe o no el entrenador para escribir o no algo.

        -- Cursor para coger los socios que tiene el entrenador asciado.
        CURSOR c_socios IS
            SELECT soc.codigo, soc.nombre
                FROM t_socio soc
                    JOIN t_entrena ent ON ent.socio = soc.codigo
                WHERE ent.entrenador = NSS_entrenador
            ;

        -- Cursor para coger las reservas de un socio dado.
        CURSOR c_reservas (p_cod_socio t_socio.codigo%TYPE) IS  
            SELECT res.instalacion AS intalacion, res.fecha AS fecha , res.precio AS precio
                FROM t_reserva res
                WHERE res.socio = p_cod_socio
                ORDER BY res.fecha ASC -- Porque el enunciado lo pide asi.
            ;

        -- Variables para contar cosas.
        v_total_socios NUMBER := 0; -- Contar el numero total de socios del entrenador.
        v_total_reservas NUMBER := 0; -- Contar el numero total de reservas del entrenador.
        v_total_precio NUMBER := 0; -- Contar el precio total de las reservas que ha tenido el enternador.
        v_aux_reservas NUMBER := 0; -- Para ir contando el numero de reservas de cada socio.
        v_aux_precios NUMBER := 0; -- Para ir contando el precio de cada socio.

    BEGIN
        BEGIN -- Hacemos otro bloque de codigo para usar las excepciones.
                SELECT entr.nombre
                    INTO v_nombre_entrenador
                    FROM t_entrenador entr
                    WHERE entr.nss = NSS_entrenador
                ; 
                v_exists := true;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    v_exists := false;
        END;
    
        IF v_exists = false THEN -- Si no existe pues escribimos y adios.

            DBMS_OUTPUT.put_line('¡No se ha encontrado el entrenador:'|| NSS_entrenador || '!');
            RETURN; -- Adios.

        END IF;

        -- Escrbimos los datos del entrenador.
        DBMS_OUTPUT.put_line('NSS entrenador: ' || NSS_entrenador || ' Nombre:');
        DBMS_OUTPUT.put_line(v_nombre_entrenador);

        -- Recorremos los socios del entrenador.
        FOR socio IN c_socios LOOP

            -- Reiniciamos las variables.
            v_aux_precios := 0;
            v_aux_reservas := 0;

            -- Escribimos los datos del socios.
            DBMS_OUTPUT.put_line('Codigo socios: ' || socio.codigo || ' Nombre: ' || socio.nombre);

            -- Recorremos las reservas del socio en cuestion.
            FOR reserva IN c_reservas(socio.codigo) LOOP

                -- Escribimos los datos de las reservas.
                DBMS_OUTPUT.put_line('Fecha: ' || reserva.fecha || ' Instalacion: ' || reserva.instalacion || ' Precio: ' || reserva.precio);

                -- Nos vamos guardando los datos de cada reserva.
                v_aux_precios := v_aux_precios + reserva.precio;
                v_aux_reservas := v_aux_reservas + 1;

            END LOOP;
            
            -- Escribimos sobre las reservas del socios.
            DBMS_OUTPUT.put_line('Numero de reservas: ' || v_aux_reservas || ' Suma de precios: ' || v_aux_precios);

            -- Actualizamos los contadores de totales.
            v_total_precio := v_total_precio + v_aux_precios;
            v_total_reservas := v_total_reservas + v_aux_reservas;
            v_total_socios := v_total_socios + 1;

        END LOOP;

        --Escribimos la totalizacion de cosas.
        DBMS_OUTPUT.put_line('--------------------');
        DBMS_OUTPUT.put_line('Numero de socios entrenados: ' || v_total_socios);
        DBMS_OUTPUT.put_line('Numero total de reservas: ' || v_total_reservas);
        DBMS_OUTPUT.put_line('Numero total de precios: ' || v_total_precio);
        DBMS_OUTPUT.put_line('---');

END;
/
