prompt ====================Pablo Iglesias Rodrigo====================
prompt ====================PL-SQL====================

prompt

prompt ========================================

SET SERVEROUTPUT ON;

DECLARE 
    parametro NUMBER(3) := 123; 
BEGIN
    /* Esto es un comentario */
    IF parametro = 123 THEN -- esto es otro comentario
        parametro:= parametro * 2;
        DBMS_OUTPUT.put('El valor es el '); 
        DBMS_OUTPUT.put_line(parametro); 
    ELSE 
        DBMS_OUTPUT.put_line('Hay un error.'); 
    END IF; 
END;
/
prompt ========================================
