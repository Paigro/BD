--Ejercicio 4 (ejercicio 3 apartado G)

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

--Apartado A: Se decide modificar el esquema de los socios a Socio (Codigo, Nombre, Email, Plan, 
--  NumReservas, SumaPreciosDeReservas): 

/* 
ALTER TABLE Socio ADD NumReservas INTEGER; 
ALTER TABLE Socio ADD SumaPreciosDeReservas DECIMAL(10, 2); 
UPDATE Socio S 
   SET NumReservas = (SELECT COUNT(*) 
          FROM Reserva 
          WHERE Socio = S.Codigo) 
      , SumaPreciosDeReservas = (SELECT NVL(SUM(precio),0) 
                    FROM Reserva 
                 WHERE Socio = S.Codigo);  
 
 */

--  Escribe un disparador PL/SQL que mantenga actualizada la información de dichas columnas cada vez que 
--  se añada o se elimine una fila de la tabla Reserva, o bien, se actualice el campo precio de dicha tabla. 

CREATE OR REPLACE TRIGGER t_update_socio
    AFTER INSERT OR DELETE OR UPDATE OF precio ON t_reserva
    FOR EACH ROW 

    BEGIN  

        -- Caso insert
        IF INSERTING THEN

            UPDATE t_socio -- Actualizamos la tabla socio.
                SET numreservas = NVL(numreservas, 0) + 1, -- Metemos una reserva mas. Con NVL por si acaso.
                    sumapreciosdereservas = NVL(sumapreciosdereservas, 0) + :NEW.precio -- Sumamos el precio. NVL por si acaso.
                WHERE codigo = :NEW.socio
            ;

        -- Caso eliminar.
        ELSIF DELETING THEN -- Usamos OLD porque es antes de que se elimine, no se puede usar NEW.

            UPDATE t_socio -- Actualizamos la tabla socio.
                SET numreservas = NVL(numreservas, 0) - 1, -- Sacamos una reserva. Con NVL por si acaso.
                    sumapreciosdereservas = NVL(sumapreciosdereservas, 0) - :OLD.precio -- Restamos el precio. NVL por si acaso.
                WHERE codigo = :OLD.socio
            ;

        -- Caso actualizar.
        ELSIF UPDATING(precio) THEN

            UPDATE t_socio -- Actualizamos la tabla socio.
                SET sumapreciosdereservas = NVL(sumapreciosdereservas, 0) - :OLD.precio + :NEW.precio -- Quitamos el precio viejo y sumamos el nuevo. NVL por si acaso.
                WHERE codigo = :NEW.socio
            ;

        END IF;
    
END;
/
