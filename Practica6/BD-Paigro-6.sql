--Pablo Iglesias Rodrigo
--Practica 6. PL-SQL

DROP TABLE P6_PEDIDOSCLIENTE CASCADE CONSTRAINTS;
CREATE TABLE P6_PEDIDOSCLIENTE(
    customer_ID NUMBER(6), 
    customer_first_name VARCHAR2(20),
    customer_last_name VARCHAR2(20),
    order_ID NUMBER(12), 
    order_date TIMESTAMP(6),
    order_status NUMBER(2),
    order_total NUMBER(8, 2),
    CONSTRAINT P6_PK_pedidos PRIMARY KEY (customer_ID),
    CONSTRAINT P6_FK_pedidos_customerid FOREIGN KEY (customer_ID) 
         REFERENCES PR4_customers(customer_ID),
    CONSTRAINT P6_FK_pedidos_orderid FOREIGN KEY (order_id) 
         REFERENCES PR4_orders(order_id)
);

CREATE PROCEDURE p6_proc_pedidos (customer_id P6_PEDIDOSCLIENTE.customer_id%TYPE) IS
    
    BEGIN 
             
    END;
/ 







