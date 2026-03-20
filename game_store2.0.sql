CREATE DATABASE  Game_Store5;
USE Game_Store5;

CREATE TABLE Roles (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250) NOT NULL,
    salary DECIMAL(10,2),
    description_ TEXT
);

CREATE TABLE Categories (
    id_category INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250) NOT NULL,
    status_ BOOLEAN DEFAULT TRUE
);

CREATE TABLE Suppliers (
    id_supplier INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250) NOT NULL,
    contact VARCHAR(50),
    email VARCHAR (250),
    address TEXT 
);

CREATE TABLE Schedules (
    id_schedule INT PRIMARY KEY AUTO_INCREMENT,
    start_time TIME,
    end_time TIME,
    work_days VARCHAR (250)
);

CREATE TABLE Branches (
    id_branch INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250),
    address TEXT,
    id_schedule INT,
    FOREIGN KEY (id_schedule) REFERENCES Schedules(id_schedule)
);

CREATE TABLE Departments (
    id_department INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250),
    id_branch INT,
    FOREIGN KEY (id_branch) REFERENCES Branches(id_branch)
);

CREATE TABLE Employees (
    id_employee INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250),
    contract_day DATE,
    id_rol INT,
    id_department INT,
    status VARCHAR (250) DEFAULT 'Active',
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol),
    FOREIGN KEY (id_department) REFERENCES Departments(id_department)
);

CREATE TABLE Products (
    id_product INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(250) NOT NULL,
    id_category INT,
    id_supplier INT, 
    price DECIMAL(10,2),
    FOREIGN KEY (id_category) REFERENCES Categories(id_category),
    FOREIGN KEY (id_supplier) REFERENCES Suppliers(id_supplier) 
);

CREATE TABLE Inventory (
    id_inventory INT PRIMARY KEY AUTO_INCREMENT,
    stock INT DEFAULT 0,
    id_product INT,
    id_branch INT,
    FOREIGN KEY (id_product) REFERENCES Products(id_product),
    FOREIGN KEY (id_branch) REFERENCES Branches(id_branch)
);

CREATE TABLE Clients (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'inactive') DEFAULT 'active'
);
CREATE TABLE Sales (
    id_sale INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES Clients(id_client)
);

CREATE TABLE Tickets (
    id_ticket INT PRIMARY KEY AUTO_INCREMENT,
    id_sale INT,
    id_product INT,
    id_employee INT,
    quantity INT,
    FOREIGN KEY (id_sale) REFERENCES Sales(id_sale),
    FOREIGN KEY (id_product) REFERENCES Products(id_product),
    FOREIGN KEY (id_employee) REFERENCES Employees(id_employee)
);

CREATE TABLE Audit (
    id_audit INT PRIMARY KEY AUTO_INCREMENT,
    affected_table VARCHAR(50),
    action_ VARCHAR(20),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    db_user VARCHAR(50)
);