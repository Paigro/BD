ALTER TABLE pr3_job_history 
DROP CONSTRAINT CK_Date;

ALTER TABLE pr5_customers
DROP CONSTRAINT CK_CreditLimit;

ALTER TABLE pr5_customers
DROP CONSTRAINT CK_CustomerId;

ALTER TABLE pr5_product_information
DROP CONSTRAINT CK_ProductStatus;
   
DROP TRIGGER pr6_update_unit_price;
DROP TRIGGER pr6_update_min_salary;
UPDATE pr3_jobs
SET MIN_SALARY = 0;

DROP TRIGGER pr6_insert_ord_line;
DROP TRIGGER pr6_update_job_history;