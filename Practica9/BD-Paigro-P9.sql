--Pablo Iglesias Rodrigo
--Practica 9.
--TODO: hacer en portatil tras instalar SQL Plus.

--sesion T1:
CREATE TABLE Cuentas( 
    Numero NUMBER PRIMARY KEY,  
    Saldo NUMBER NOT NULL); 

INSERT INTO cuentas VALUES (123, 400);  
INSERT INTO cuentas VALUES (456, 300); 
COMMIT; 

--Sesion T2: tiene que hacerse en SQL Plus para poder abrir dos sesiones.
