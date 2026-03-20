CREATE DATABASE game_store1;
USE game_store1;
CREATE TABLE categories (    
	id_category INT PRIMARY KEY,
    name_ VARCHAR (250),
    quantity INT
    );
CREATE TABLE schedules (
	id_schedule INT PRIMARY KEY,
    start_time TIME,
    end_time TIME                        
    );    

CREATE TABLE products (
	id_product INT PRIMARY KEY,
	name_ VARCHAR (250),
	id_category INT,
	quantity INT,
	FOREIGN KEY (id_category) REFERENCES categories (id_category)
	);

CREATE TABLE inventory (
	id_inventory INT PRIMARY KEY,
    stock INT,
	id_product INT,
    FOREIGN KEY (id_product) REFERENCES products (id_product)
    );
    
CREATE TABLE branchs (
	id_branch INT PRIMARY KEY,
	name_ VARCHAR (250),
	address VARCHAR (250),
    id_inventory INT,
    id_schedule INT,
    id_sales INT,
	FOREIGN KEY (id_inventory) REFERENCES inventory(id_inventory),
	FOREIGN KEY (id_schedule) REFERENCES schedules(id_schedule),
	FOREIGN KEY (id_sales) REFERENCES sales(id_sales)
	);
CREATE TABLE departments (
	id_departments INT PRIMARY KEY,
    name_ VARCHAR (250),
    id_branch INT,
	FOREIGN KEY (id_branch) REFERENCES branches (id_branch)
    );
CREATE TABLE roles (
	id_role INT PRIMARY KEY,
	name_ VARCHAR (255),
	salary DECIMAL (10,2),
    id_department INT,
	FOREIGN KEY (id_department) REFERENCES departments (id_department)
    );

CREATE TABLE employees (
	id_employee INT PRIMARY KEY,
	name_ VARCHAR (250),
	contact INT,
	address VARCHAR (250),
	birthday DATE,
    id_role INT,
	-- hire_date DATE (por si ocupamos la fecha de ingreso)
	FOREIGN KEY (id_role) REFERENCES roles (id_role)
	);
    
CREATE TABLE suppliers (
	id_supplier INT PRIMARY KEY,
	name_ VARCHAR (250),
    contact INT,
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES products (id_producto)
    );
    
CREATE TABLE warehouse (
	id_warehouse INT PRIMARY KEY,
	id_branch INT,
    id_supplier INT,
    FOREIGN KEY (id_branch) REFERENCES branch (id_branch),
    FOREIGN KEY (id_supplier) REFERENCES suppliers (id_supplier)
	);


CREATE TABLE sales (
	id_sale INT PRIMARY KEY,
	payment_method VARCHAR (250),
	sale_date DATE,
	id_customer INT,
	totale_sales DECIMAL (10,2),
	FOREIGN KEY (id_customer) REFERENCES customers (id_customer)
	);

CREATE TABLE tickets (
	id_ticket INT PRIMARY KEY,
	id_sale INT,
	id_branch INT,
	id_employee INT,
	id_product INT,
	FOREIGN KEY (id_sale) REFERENCES sales (id_sale),
	FOREIGN KEY (id_branch) REFERENCES branches (id_branch),
	FOREIGN KEY (id_employee) REFERENCES employees (id_employee),
	FOREIGN KEY (id_product) REFERENCES products (id_product)
	);
CREATE TABLE customers (
    id_customers INT PRIMARY KEY,
    name_ VARCHAR (250),
    email VARCHAR (250),
    id_ticket INT,
    FOREIGN KEY (id_ticket) REFERENCES tickets (id_ticket)
);
CREATE TABLE audit (
	id_audit INT PRIMARY KEY
	);






