prompt ====================Pablo Iglesias Rodrigo====================
prompt ====================P6====================

prompt

-- Para escribir en consola.
SET SERVEROUTPUT ON; 

prompt ========================================
prompt -1:
CREATE OR REPLACE PROCEDURE p_pedidosClientes
    (idCLiente pr4_customers.customer_id%TYPE)
    IS
        --Declaracion de variables.
        v_nombre pr4_customers.cust_first_name%TYPE; -- Nombre.
        v_apellidos pr4_customers.cust_first_name%TYPE; -- Apellido.
        v_suma_pedidos NUMBER := 0; -- Valor de todos los pedidos.
        v_n_pedidos NUMBER := 0; -- Numero de  pedidos.
        
        -- Cursor para recorrer los pedidos.
        CURSOR c_pedidos IS
            SELECT ord.order_id, ord.order_date, ord.order_status, ord.order_total
                FROM pr4_orders ord -- Cogemos la tabla pedidos.
                WHERE ord.customer_id = idCliente -- Nos quedamos con las que pertenecen al cliente que queremos.
                ORDER BY ord.order_date ASC -- Ordenamos segun dice el enunciado.   
            ;
        
    BEGIN
        -- Cogemos el nombre y apellido del cliente.
        SELECT cus.cust_first_name, cus.cust_last_name
            INTO v_nombre, v_apellidos -- Donde vamos a meter los datos cogidos del SELECT.
            FROM pr4_customers cus -- Cogemos los clientes.
            WHERE cus.customer_id = idCliente -- Nos quedamos con el cliente que queremos.
        ;
        DBMS_OUTPUT.put_line('--------------------p_pedidosClientes--------------------'); -- Barrita.
        
        --Mostramos el id.
        DBMS_OUTPUT.put_line('Cliente con ID: ' || idCliente);
        -- Mostramos el nombre y apellidos.
        DBMS_OUTPUT.put_line('  Nombre: ' || v_nombre);
        DBMS_OUTPUT.put_line('  Apellidos: ' || v_apellidos);
        
        -- Mostramos los pedidos.
        DBMS_OUTPUT.put_line('PEDIDOS: ');
        
        FOR pedido IN c_pedidos LOOP
            v_n_pedidos := v_n_pedidos + 1; -- Lamentablemente no hay ++.
            v_suma_pedidos := v_suma_pedidos + pedido.order_total; -- Vamos sumando el coste de los pedidos.
            DBMS_OUTPUT.put_line('Pedido Id: ' || pedido.order_id);
            DBMS_OUTPUT.put_line('  Fecha: ' || pedido.order_date);
            DBMS_OUTPUT.put_line('  Estado: ' || pedido.order_status);
            DBMS_OUTPUT.put_line('  Importe: ' || pedido.order_total);
        END LOOP;
        
        IF v_n_pedidos = 0 THEN
            DBMS_OUTPUT.put_line('  Cliente sin pedidos.');
        ELSE 
            DBMS_OUTPUT.put_line('Importe total de los ' || v_n_pedidos || ' pedidos: ' || v_suma_pedidos);
        END IF;
        
        DBMS_OUTPUT.put_line('--------------------FIN p_pedidosClientes--------------------'); -- Barrita.
        
    EXCEPTION  
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No existe el cliente con id: ' || idCliente);
            DBMS_OUTPUT.put_line('--------------------FIN p_pedidosClientes--------------------'); -- Barrita.
            
END;
/
prompt ========================================
prompt -2:
CREATE OR REPLACE PROCEDURE p_revisaPedidos
    IS
        --Declaracion de variables.

        v_errores BOOLEAN := FALSE; -- Comprobar si un pedido tiene errores.
        v_total_real NUMBER := 0; -- Valor con los datos de precio*cantidad en ordite.
        
        -- Cursor para recorrer los pedidos.
        CURSOR c_pedidos IS
            SELECT ord.order_id, ord.order_total
                FROM pr4_orders ord  
            ;
        -- Cursor que devuelve el valor total de las unidades vendidas en un peidido.
        CURSOR c_elems_pedidos 
            (idPedido pr4_orders.order_id%TYPE)
            IS
                SELECT SUM(ordite.unit_price * ordite.quantity) -- Devolvemos la suma de las unidades por su valor.
                    FROM pr4_order_items ordite -- Cogemos la tabla de elementos pedidos.
                    WHERE ordite.order_id = idPedido -- Nos quedamos con los elementos pedidos en ese pedido.
                ;
        
    BEGIN
        DBMS_OUTPUT.put_line('--------------------p_revisaPedidos--------------------'); -- Barrita.
        
        DBMS_OUTPUT.put_line('Comprobacion de pedidos:');
        
        -- Recorremos todos los pedidos.
        FOR pedido IN c_pedidos LOOP
            OPEN c_elems_pedidos(pedido.order_id); -- Abrimos el cursor con el parametro por el que estamos iterando.
            FETCH c_elems_pedidos INTO v_total_real; -- Cogemos lo que devuelve el cursor y lo metemos en la variable.
            CLOSE c_elems_pedidos; -- Hay que cerrar el cursor.
        
            -- Casos segun los totales calculados.
            IF pedido.order_total <> v_total_real THEN
                DBMS_OUTPUT.put_line('  Pedido ERRONEO con id: ' || pedido.order_id);
                DBMS_OUTPUT.put_line('      Total del pedido: ' || pedido.order_total);
                DBMS_OUTPUT.put_line('      Total real de los elementos pedidos: ' || v_total_real);
            ELSE
                DBMS_OUTPUT.put_line('  Pedido CORRECTO con id: ' || pedido.order_id);
            END IF;
            
            DBMS_OUTPUT.put_line('----------------------------------------'); -- Barrita.
        
        END LOOP;
        
        DBMS_OUTPUT.put_line('--------------------FIN p_revisaPedidos--------------------'); -- Barrita.
            
END;
/
prompt ========================================
prompt -3:
prompt ========================================
prompt --3.a:
ALTER TABLE pr4_product_information ADD (quantity NUMBER(6) DEFAULT 0); -- Modificacion de la tabla.
prompt ========================================
prompt --3.b:
DECLARE
    -- Cursos para saber las cantidades de productos en los almacenes.
    CURSOR c_cantidades IS
        SELECT proinf.product_id, NVL(SUM(inv.quantity_on_hand), 0) AS cantidad
            FROM pr4_product_information proinf
                LEFT JOIN pr4_inventories inv ON inv.product_id = proinf.product_id --Unimos con los inventarios, como queremos todos los productos aunque no esten en el almacen.
            GROUP BY proinf.product_id
        ;
        
    BEGIN
        -- Iteramos por todos los productos.
        FOR producto IN c_cantidades LOOP
            UPDATE pr4_product_information
                SET quantity = producto.cantidad
                WHERE product_id = producto.product_id
            ;
        END LOOP;
        
        COMMIT; -- Confirmamos la actualizacion de la tablas.
    
END;
/
prompt ========================================
prompt --3.c:
CREATE OR REPLACE PROCEDURE p_actualizaPIQuantity
    (idProducto pr4_product_information.product_id%TYPE, 
        nElementos NUMBER)
    IS
        --Declaracion de variables.
        v_cantidad_anterior pr4_product_information.quantity%TYPE :=0;
        v_cantidad_final pr4_product_information.quantity%TYPE := 0;
        
        -- Cursor que devuelve la cantidad de un producto.
        CURSOR c_cantidad
            (idElemento pr4_product_information.product_id%TYPE)
            IS
                SELECT proinf.quantity -- Devolvemos la cantidad.
                    FROM pr4_product_information proinf -- Cogemos la tabla con la informacion de los productos.
                    WHERE proinf.product_id = idElemento -- Tiene que coicidir con el producto que queremos.
                ;
        
    BEGIN
        DBMS_OUTPUT.put_line('--------------------p_actualizaPIQuantity--------------------'); -- Barrita.
        
        DBMS_OUTPUT.put_line('Actualizacion de cantidades del producto con id: ' || idProducto );
        
        OPEN c_cantidad(idProducto); -- Abrimos el cursor con el id dado.
        FETCH c_cantidad INTO v_cantidad_anterior; -- Cogemos del cursos la cantidad de cada producto para guardarla.
        UPDATE pr4_product_information -- Actualziamos la tabla.
                SET quantity = v_cantidad_anterior + nElementos
                WHERE product_id = idProducto
            ;
        CLOSE c_cantidad; -- Cerrramos el cursor.
        
        -- Metemos la cantidad actualizada en una variable para guardarla.
        SELECT proinf.quantity
            INTO v_cantidad_final
            FROM pr4_product_information proinf
            WHERE proinf.product_id = idProducto
        ;
        
        -- Escribimos la comparacion.
        DBMS_OUTPUT.put_line('  Cantidad anterior: ' || v_cantidad_anterior );
        DBMS_OUTPUT.put_line('  Cantidad final: ' || v_cantidad_final );
        
        DBMS_OUTPUT.put_line('--------------------FIN p_actualizaPIQuantity--------------------'); -- Barrita.
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No existe el producto con id: ' || idProducto);
            DBMS_OUTPUT.put_line('--------------------FIN p_actualizaPIQuantity--------------------'); -- Barrita.
END;
/
prompt ========================================
prompt --3.d:
CREATE OR REPLACE TRIGGER t_actualiza_cantidades
    AFTER UPDATE OF quantity_on_hand ON pr4_inventories
    FOR EACH ROW
    DECLARE
        --Declaracion de variables.
        v_diferencia NUMBER;
        
    BEGIN
        v_diferencia := :NEW.quantity_on_hand - :OLD.quantity_on_hand;
        
        IF v_diferencia <> 0 THEN
            DBMS_OUTPUT.put_line('--------------------t_actualiza_cantidades--------------------'); -- Barrita.
            p_actualizaPIQuantity(:NEW.product_id, v_diferencia);
            DBMS_OUTPUT.put_line('Cambio de numero de elementos en producto con id: ' || :NEW.product_id);
            DBMS_OUTPUT.put_line('--------------------FIN t_actualiza_cantidades--------------------'); -- Barrita.
        END IF;
        
END;
/

--Ejecucion de ejercicios.
BEGIN

    DBMS_OUTPUT.put_line('--------------------Pruebas--------------------'); -- Barrita.
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('-1:');
    p_pedidosClientes(101);
    p_pedidosClientes(102);
    p_pedidosClientes(1);
    p_pedidosClientes(981);
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('-2:');
    p_revisaPedidos;
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('--3.c:');
    p_actualizaPIQuantity(1772, 10);
    
    DBMS_OUTPUT.put_line('========================================');
    DBMS_OUTPUT.put_line('--3.e:');
    UPDATE pr4_inventories
        SET quantity_on_hand = quantity_on_hand + 20
        WHERE product_id = 1797
            AND warehouse_id = 6 -- Para probar para que no salte el trigger las3 veces que esta el producto en los 3 almacenes.
    ;
    
END;
/



prompt ====================FIN P6====================