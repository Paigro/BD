SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER antesDeCualquierModificacion
BEFORE UPDATE OF nombreMuseo ON Enero17_Exposiciones
BEGIN
    DBMS_OUTPUT.put('BEFORE STATEMENT: ');
    DBMS_OUTPUT.put_line('Antes de modificar Exposiciones(nombreMuseo), es bueno saludar y avisar que se ha cambiado alguna exposici�n de museo');
END;
/
CREATE OR REPLACE TRIGGER antesDeUnaInstancia
BEFORE UPDATE OF nombreMuseo ON Enero17_Exposiciones
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.put('  BEFORE FOR EACH ROW: ');
    DBMS_OUTPUT.put_line('Vamos a cambiar la exposicion "' || :OLD.nombre || '" que se encuentra en el museo "' || :OLD.nombreMuseo || '".');
END;
/
CREATE OR REPLACE TRIGGER despuesDeUnaInstancia
AFTER UPDATE OF nombreMuseo ON Enero17_Exposiciones
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.put('  AFTER FOR EACH ROW: ');
    DBMS_OUTPUT.put_line('Hemos cambiado la exposicion "' || :OLD.nombre || '" al museo "' || :NEW.nombreMuseo || '".');
END;
/
CREATE OR REPLACE TRIGGER despuesDeCualquierModificacion
AFTER UPDATE OF nombreMuseo ON Enero17_Exposiciones
BEGIN
    DBMS_OUTPUT.put('AFTER STATEMENT: ');
    DBMS_OUTPUT.put_line('Me despido tras realiar todas las moficiaciones en Exposiciones(nombreMuseo). Buen d�a!!!!');
END;
/
-- ***PRUEBA***
-- Insertando un dato para hacer la prueba
INSERT INTO Enero17_Museos VALUES ('Prado', 'Madrid');
SELECT * FROM Enero17_Exposiciones;
-- Actualizando muchos datos para que se lancen todos los triggers
UPDATE Enero17_Exposiciones 
    SET nombremuseo = 'Prado'
    WHERE nombreMuseo = 'Pardo';
    
SELECT * FROM Enero17_Exposiciones;

ROLLBACK;

SELECT * FROM Enero17_Museos;
SELECT * FROM Enero17_Exposiciones;