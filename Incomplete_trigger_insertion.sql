CREATE DATABASE Game_Store3;
USE Game_Store3;

CREATE TABLE Roles (
	id_rol INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250) NOT NULL,
    salary DECIMAL (10,2),
    description_ TEXT
);

CREATE TABLE Categories (
	id_category INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250) NOT NULL,
    status_ BOOLEAN DEFAULT TRUE
);

CREATE TABLE Suppliers (
	id_supplier INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250) NOT NULL,
    phone VARCHAR (50),
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
    name_ VARCHAR (250),
    address TEXT,
    id_schedule INT,
    FOREIGN KEY (id_schedule) REFERENCES Schedules (id_schedule)
);

CREATE TABLE Departments (
	id_departments INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250),
    id_branch INT,
    FOREIGN KEY (id_branch) REFERENCES Branches (id_branch)
);

CREATE TABLE Employees (
	id_employee INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250),
    phone VARCHAR (20),
    contract_day DATE,
    id_rol INT,
    id_departments INT,
    status_ ENUM ('Active','Inactive','On Leave') DEFAULT 'Active',
    FOREIGN KEY (id_rol) REFERENCES Roles (id_rol),
    FOREIGN KEY (id_departments) REFERENCES Departments (id_departments)
);

CREATE TABLE Products (
	id_product INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250) NOT NULL,
    price DECIMAL (10,2),
    id_category INT,
    id_supplier INT,
    FOREIGN KEY (id_category) REFERENCES Categories (id_category),
    FOREIGN KEY (id_supplier) REFERENCES Suppliers (id_supplier)
);

CREATE TABLE Inventory (
	id_inventory INT PRIMARY KEY AUTO_INCREMENT,
    stock INT DEFAULT 0,
    id_product INT,
    id_branch INT,
    FOREIGN KEY (id_product) REFERENCES Products (id_product),
    FOREIGN KEY (id_branch) REFERENCES Branches (id_branch)
);

CREATE TABLE Clients (
	id_client INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR (250) NOT NULL,
    phone VARCHAR (50),
    email VARCHAR (250),
    address TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_ ENUM ('Active','Inactive') DEFAULT 'Active'
);
    
CREATE TABLE Tickets (
	id_ticket INT PRIMARY KEY AUTO_INCREMENT,
    ticket_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL (10,2) DEFAULT 0.00,
    id_client INT,
    id_employee INT,
    FOREIGN KEY (id_client) REFERENCES Clients (id_client),
    FOREIGN KEY (id_employee) REFERENCES Employees (id_employee)
);
CREATE TABLE Ticket_Datalis (
	id_detail INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    unit_price DECIMAL (10,2) NOT NULL,
    id_ticket INT,
    id_product INT,
    FOREIGN KEY (id_ticket) REFERENCES Tickets (id_ticket),
    FOREIGN KEY (id_product) REFERENCES Products (id_product)
);

CREATE TABLE Audit (
	id_audit INT PRIMARY KEY AUTO_INCREMENT,
    affected_table VARCHAR (250),
    action_ VARCHAR (20),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    db_user VARCHAR (50)
);

-- Creations Triggers 
DELIMITER //
-- Roles
CREATE TRIGGER tr_roles_insert AFTER INSERT ON Roles FOR EACH ROW 
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Roles", "Insert", User())
CREATE TRIGGER tr_roles_update AFTER UPDATE ON Roles FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Roles", "Update", User()) 
CREATE TRIGGER tr_roles_delete AFTER DELETE ON Roles FOR EACH ROW 
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Roles", "Delete", User())

-- Categories
CREATE TRIGGER tr_categories_insert AFTER INSERT ON Categories FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Categories", "Insert", User())
CREATE TRIGGER tr_categories_update AFTER UPDATE ON Categories FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Categories", "Update", User()) 
CREATE TRIGGER tr_categories_delete AFTER DELETE ON Categories FOR EACH ROW 
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Categories", "Delete", User())

-- Suppliers
CREATE TRIGGER tr_supplier_insert AFTER INSERT ON Suppliers FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Suppliers", "Insert", User())
CREATE TRIGGER tr_supplier_update AFTER UPDATE ON Suppliers FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Suppliers", "Update", User())
CREATE TRIGGER tr_supplier_delete AFTER DELETE ON Suppliers FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Suppliers", "Delete", User())

-- Schedules
CREATE TRIGGER tr_schedules_insert AFTER INSERT IN Schedules FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Schedules", "Insert", User())
CREATE TRIGGER tr_schedules_update AFTER UPDATE IN Schedules FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Schedules", "Update", User())
CREATE TRIGGER tr_schedules_delete AFTER DELETE IN Schedules FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Schedules", "Delete", User())

-- Branches 
CREATE TRIGGER tr_branches_insert AFTER INSERT ON Branches FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Branches", "Insert", User()) 
CREATE TRIGGER tr_branches_update AFTER UPDATE ON Branches FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Branches", "Update", User()) 
CREATE TRIGGER tr_branches_delete AFTER DELETE ON Branches FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Branches", "Delete", User()) 

-- Departaments 
CREATE TABLE tr_departments_insert AFTER INSERT ON Departments FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Departments", "Insert", User())
CREATE TABLE tr_departments_insert AFTER INSERT ON Departments FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Departments", "Insert", User())
CREATE TABLE tr_departments_insert AFTER INSERT ON Departments FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Departments", "Insert", User())
		
DELIMITER ;

