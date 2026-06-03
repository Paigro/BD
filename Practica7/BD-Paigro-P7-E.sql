prompt ====================Pablo Iglesias Rodrigo====================
prompt ====================P7====================

prompt

-- Para escribir en consola.
SET SERVEROUTPUT ON; 

prompt ========================================
prompt -1:
CREATE OR REPLACE TRIGGER t_update_ordrite
    AFTER INSERT ON pr4_order_items
    FOR EACH ROW
    BEGIN
        DBMS_OUTPUT.put_line('--------------------t_update_ordrite--------------------'); -- Barrita.
        
        UPDATE pr4_orders -- Actualizamos la tabla de pedidos.
            SET order_total = NVL(order_total, 0) + (:NEW.unit_price * :NEW.quantity) -- Sumamos el valor del pedido al total. Si fuese NULL, sumamos desde 0 y no desde NULL, que daria NULL.
            WHERE order_id = :NEW.order_id -- Lo sumamos al pedido que toque.
        ;

        DBMS_OUTPUT.put_line('--------------------FIN t_update_ordrite--------------------'); -- Barrita.

END;
/

prompt ========================================
prompt -2:
CREATE OR REPLACE TRIGGER t_update_min
    BEFORE UPDATE OF min_salary ON pr3_jobs
    FOR EACH ROW
    DECLARE
        --Declaracion de variables.
        v_afectados NUMBER := 0; -- Numero de empelados con un salario menor al nuevo minimo.
        
    BEGIN
        DBMS_OUTPUT.put_line('--------------------t_update_ordrite--------------------'); -- Barrita.
        
        SELECT COUNT(*) -- Cogemos la suma de los empleados que cumplen que su salario es menor al nuevo minimo.
            INTO v_afectados -- Metemos el valor a la variable.
            FROM pr3_employees emp -- Cogemos a los empleados.
            WHERE emp.job_id = :NEW.job_id -- Nos quedamos con los que necesitamos, que el puesto sea el puesto y que su salario sea menor al nuevo minimo.
                AND emp.salary < :NEW.min_salary
        ;
        
        IF v_afectados > 0 THEN
            DBMS_OUTPUT.put_line('ERROR: Hay empleados con sueldos menores al neuvo minimo. No se actualizara la Base de Datos');
            :NEW.min_salary := :OLD.min_salary; -- Dejamos el salario como esta.
        ELSE
            DBMS_OUTPUT.put_line('Salario minimo para el puesto: ' || :NEW.job_title || 'actualizado correctamente.');
        END IF;
            
        DBMS_OUTPUT.put_line('--------------------FIN t_update_ordrite--------------------'); -- Barrita.

END;
/

prompt ========================================
prompt -3:
CREATE OR REPLACE TRIGGER t_add_line
    BEFORE INSERT ON pr4_order_items
    FOR EACH ROW
    DECLARE
        --Declaracion de variables.
        v_linea NUMBER;
        
    BEGIN
        DBMS_OUTPUT.put_line('--------------------t_add_line--------------------'); -- Barrita.
        
        SELECT NVL(MAX(ordite.line_item_id), 0) -- Cogemos la linea mas alta. Si no hay, es NULL, entonces empezamos en el 0.
            INTO v_linea -- Lo metemos en la variable.
            FROM pr4_order_items ordite
            WHERE ordite.order_id = :NEW.order_id
        ;
        
        v_linea := v_linea + 1; -- Sumamos 1.
        
        DBMS_OUTPUT.put_line('La nueva linea del nuevo pedido es: ' || v_linea);
        :NEW.line_item_id := v_linea; -- Le ponemos la nueva linea.
        
        DBMS_OUTPUT.put_line('--------------------FIN t_add_line--------------------'); -- Barrita.

END;
/

prompt ========================================
prompt -4:
CREATE OR REPLACE TRIGGER t_update_emp
    AFTER UPDATE OF job_id, department_id ON pr3_employees
    FOR EACH ROW
        
    BEGIN
        DBMS_OUTPUT.put_line('--------------------t_update_emp--------------------'); -- Barrita.
        
        INSERT INTO pr3_job_history(employee_id, start_date, end_date, job_id, department_id) -- Insertamos en la tabla.
            VALUES(:OLD.employee_id, NVL(:OLD.hire_date, SYSDATE - 1), SYSDATE, :OLD.job_id, :OLD.department_id) -- Los datos que tocan,
        ;
        
        DBMS_OUTPUT.put_line('El historial de trabajos ha sido actualizado para el empleado con id: ' || :OLD.employee_id);
        
        DBMS_OUTPUT.put_line('--------------------FIN t_update_emp--------------------'); -- Barrita.

END;
/

--Ejecucion de ejercicios.
BEGIN

    DBMS_OUTPUT.put_line('--------------------Pruebas--------------------'); -- Barrita.

    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('-1:');
    /*INSERT INTO pr4_order_items(order_id, line_item_id, product_id, unit_price, quantity)
        VALUES (2458, 10, 2457, 4.4, 10)
    ;*/
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('-2:');
    UPDATE pr3_jobs
        SET min_salary = 5000
        WHERE job_id = 'AD_ASST'
    ;
    UPDATE pr3_jobs
        SET min_salary = 4400
        WHERE job_id = 'AD_ASST'
    ;
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('-3:');
    INSERT INTO pr4_order_items(order_id, line_item_id, product_id, unit_price, quantity)
        VALUES (2458, 420, 2457, 4.4, 10)
    ;
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('-4:');
    UPDATE pr3_employees
        SET job_id = 'AV_VP'
        WHERE employee_id = 100
    ;
    UPDATE pr3_employees
        SET department_id = 50
        WHERE employee_id = 205
    ;
    
    ROLLBACK;
END;
/



prompt ====================FIN P7====================