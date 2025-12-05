--Pablo Iglesias Rodrigo
--Practica 9:

--sesion T1:
CREATE TABLE Cuentas( 
    Numero NUMBER PRIMARY KEY,  
    Saldo NUMBER NOT NULL); 

INSERT INTO cuentas VALUES (123, 400);  
INSERT INTO cuentas VALUES (456, 300); 
COMMIT; 

--Sesion T2: