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
		
 -- Employees
CREATE TRIGGER tr_employee_insert AFTER INSERT ON Employees FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Employees","Insert",USER());
 
CREATE TRIGGER tr_employees_update AFTER UPDATE ON Employees FOR EACH ROW
INSERT INTO Audit (affectes_table, action_, db_user) VALUES ("Employees","Update",USER());

CREATE TRIGGER tr_employees_delete AFTER DELETE ON Employees FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Employees","Delete",USER());

-- Products
CREATE TRIGGER tr_products_insert AFTER INSERT ON Products FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Products","Insert",USER());

CREATE TRIGGER tr_products_update AFTER UPDATE ON Products FOR EACH ROW
INSERT INTO Audit (affectes_table, action_, db_user)  VALUES ("Products","Update",USER());

CREATE TRIGGER tr_products_delete AFTER DELETE ON Products FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Products","Delete",USER());

-- Inventory
CREATE TRIGGER tr_inventory_insert AFTER INSERT ON Inventory FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Inventory","Insert",USER());

CREATE TRIGGER tr_inventory_update AFTER UPDATE ON Inventory FOR EACH ROW
INSERT INTO Audit (affectes_table, action_, db_user)  VALUES ("Inventory","Update",USER());

CREATE TRIGGER tr_inventory_delete AFTER DELETE ON Inventory FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Inventory","Delete",USER());

-- Clients
CREATE TRIGGER tr_clients_insert AFTER INSERT ON Clients FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Clients","Insert",USER());

CREATE TRIGGER tr_clients_update AFTER UPDATE ON Clients FOR EACH ROW
INSERT INTO Audit (affectes_table, action_, db_user)  VALUES ("Clients","Update",USER());

CREATE TRIGGER tr_clients_delete AFTER DELETE ON Clients FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Clients","Delete",USER());

-- Tickets
CREATE TRIGGER tr_tickets_insert AFTER INSERT ON Tickets FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Tickets","Insert",USER());

CREATE TRIGGER tr_tickets_update AFTER UPDATE ON Tickets FOR EACH ROW
INSERT INTO Audit (affectes_table, action_, db_user)  VALUES ("Tickets","Update",USER());

CREATE TRIGGER tr_tickets_delete AFTER DELETE ON Tickets FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Tickets","Delete",USER());

-- Tickets_Details
CREATE TRIGGER tr_tickets_details_insert AFTER INSERT ON Tickets_Details FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Tickets_Details","Insert",USER());

CREATE TRIGGER tr_tickets_details_update AFTER UPDATE ON Tickets_Details FOR EACH ROW
INSERT INTO Audit (affectes_table, action_, db_user)  VALUES ("Tickets_Details","Update",USER());

CREATE TRIGGER tr_tickets_details_delete AFTER DELETE ON Tickets_Details FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Tickets_Details","Delete",USER());

DELIMITER //

-- Start of insertions
-- Roles 
INSERT INTO Roles (name_, salary, description_) 
VALUES ('Store Manager', 4500.00, 'Responsible for overall store operations, staff management, and sales targets.');

INSERT INTO Roles (name_, salary, description_) 
VALUES ('Lead Game Consultant', 2800.50, 'Expert in gaming hardware and software, providing high-level customer advice.');

INSERT INTO Roles (name_, salary, description_) 
VALUES ('Inventory Coordinator', 2200.00, 'Manages stock levels, pre-orders, and distribution of new releases.');

INSERT INTO Roles (name_, salary, description_) 
VALUES ('Technical Support Specialist', 3100.00, 'Handles console repairs, hardware testing, and technical troubleshooting.');

INSERT INTO Roles (name_, salary, description_) 
VALUES ('Marketing Coordinator', 2600.75, 'In charge of social media campaigns, local tournaments, and store events.');

INSERT INTO Roles (name_, salary, description_) 
VALUES ('Receptionist', 1850.00, 'Responsible for greeting customers, handling phone calls, and managing store appointment schedules.');

INSERT INTO Roles (name_, salary, description_) 
VALUES ('Maintenance Staff', 1400.00, 'Ensures store cleanliness and performs basic repairs on facilities.');

-- Categories 
INSERT INTO Categories (name_, status_) VALUES ('Action & Adventure', TRUE);

INSERT INTO Categories (name_, status_) VALUES ('RPG', TRUE);

INSERT INTO Categories (name_, status_) VALUES ('Sports & Racing', TRUE);

INSERT INTO Categories (name_, status_) VALUES ('First-Person Shooter', TRUE);

INSERT INTO Categories (name_, status_) VALUES ('Consoles & Hardware', TRUE);

INSERT INTO Categories (name_, status_) VALUES ('Collectibles & Merch', TRUE);

-- Suppliers
INSERT INTO Suppliers (name_, phone, email, address) 
VALUES ('Global Gaming Dist', '+1-555-010-9988', 'sales@globalgaming.com', '123 Tech Plaza, San Jose, CA, USA');

INSERT INTO Suppliers (name_, phone, email, address) 
VALUES ('Pixel Accessories Ltd', '+1-555-022-4433', 'orders@pixelacc.com', '45 Industrial Way, Seattle, WA, USA');

INSERT INTO Suppliers (name_, phone, email, address) 
VALUES ('Retro Collector Wholesale', '+44-20-7946-0123', 'contact@retro-wholesale.co.uk', '12 Baker St, London, UK');

INSERT INTO Suppliers (name_, phone, email, address) 
VALUES ('Funko & Merch Co.', '+1-555-099-1122', 'wholesale@funkymerch.com', '789 Pop Culture Blvd, Orlando, FL, USA');

INSERT INTO Suppliers (name_, phone, email, address) 
VALUES ('Digital Keys Network', '+1-555-044-5566', 'support@digitalkeys.net', '99 Virtual Drive, Austin, TX, USA');

-- Schedules 
INSERT INTO Schedules (start_time, end_time, work_days) 
VALUES ('08:00:00', '16:00:00', 'Monday, Tuesday, Wednesday, Thursday, Friday');

INSERT INTO Schedules (start_time, end_time, work_days) 
VALUES ('13:00:00', '21:00:00', 'Monday, Tuesday, Wednesday, Thursday, Friday');

INSERT INTO Schedules (start_time, end_time, work_days) 
VALUES ('09:00:00', '21:00:00', 'Saturday, Sunday');

INSERT INTO Schedules (start_time, end_time, work_days) 
VALUES ('11:00:00', '17:00:00', 'Tuesday, Wednesday, Thursday, Friday, Saturday');

INSERT INTO Schedules (start_time, end_time, work_days) 
VALUES ('21:00:00', '03:00:00', 'Monday, Wednesday, Friday');

-- Branches
INSERT INTO Branches (name_, address, id_schedule) 
VALUES ('Game Store - Downtown TJ', 'Av. Revolución #450, Zona Centro, CP 22000, Tijuana, B.C.', 1);

INSERT INTO Branches (name_, address, id_schedule) 
VALUES ('Game Store - Plaza Río', 'Paseo de los Héroes #95, Zona Urbana Rio Tijuana, CP 22010, Tijuana, B.C.', 2);

INSERT INTO Branches (name_, address, id_schedule) 
VALUES ('Game Store - Otay University', 'Calzada Universidad #14, Mesa de Otay, CP 22427, Tijuana, B.C.', 4);

INSERT INTO Branches (name_, address, id_schedule) 
VALUES ('Game Store - Macroplaza Insurgentes', 'Blvd. Insurgentes #18015, Rio Tijuana 3ra. Etapa, CP 22226, Tijuana, B.C.', 1);

INSERT INTO Branches (name_, address, id_schedule) 
VALUES ('Game Store - Playas Point', 'Paseo Ensenada #1200, Playas de Tijuana, CP 22500, Tijuana, B.C.', 3);

-- Departament
INSERT INTO Departments (name_, id_branch) VALUES ('Sales & Customer Service', 1);

INSERT INTO Departments (name_, id_branch) VALUES ('Technical Support & Repair', 2);

INSERT INTO Departments (name_, id_branch) VALUES ('Inventory & Logistics', 3);

INSERT INTO Departments (name_, id_branch) VALUES ('Marketing & Events', 4);

INSERT INTO Departments (name_, id_branch) VALUES ('Administration & HR', 5);

-- Employees 
INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Carlos Mendoza', '664-123-4567', '2023-01-10', 1, 5, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Ana Lucía Rojas', '664-987-6543', '2023-02-15', 2, 1, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Roberto Guajardo', '664-555-8899', '2023-03-01', 3, 3, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Sofía Valenzuela', '664-444-2211', '2023-04-12', 4, 2, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Miguel Ángel Torres', '664-333-7788', '2023-05-20', 5, 4, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Valeria Ortiz', '664-111-2233', '2023-06-05', 6, 5, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Fernando Herrera', '664-888-9900', '2023-07-15', 7, 2, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Daniela Méndez', '664-777-6655', '2023-08-01', 2, 1, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Ricardo Salinas', '664-444-5566', '2023-09-10', 3, 3, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Oscar Ramírez', '664-222-3344', '2023-10-25', 4, 2, 'On Leave');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Martha Sánchez', '664-999-0011', '2023-11-30', 7, 1, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Alejandro Ruiz', '664-333-4455', '2024-01-12', 2, 4, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Gabriela Espinoza', '664-666-7788', '2024-02-14', 6, 1, 'Active');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Kevin Estrada', '664-555-1212', '2024-03-05', 3, 3, 'Inactive');

INSERT INTO Employees (name_, phone, contract_day, id_rol, id_departments, status_) 
VALUES ('Beatriz Adriana', '664-121-2323', '2024-04-20', 1, 1, 'Active');

-- Products
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Elden Ring', 59.99, 1, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Spider-Man 2', 69.99, 1, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('God of War Ragnarok', 59.99, 1, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('The Last of Us Part II', 39.99, 1, 3);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Resident Evil 4 Remake', 59.99, 1, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Ghost of Tsushima', 49.99, 1, 3);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Assassin''s Creed Mirage', 49.99, 1, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Hades', 24.99, 1, 5);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('PlayStation 5 Slim', 499.99, 5, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Xbox Series X', 489.00, 5, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Nintendo Switch OLED', 349.99, 5, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Steam Deck 512GB', 549.00, 5, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('ASUS ROG Ally', 699.99, 5, 2);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Final Fantasy VII Rebirth', 69.99, 2, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Starfield', 69.99, 2, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('The Witcher 3: Wild Hunt', 29.99, 2, 3);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Baldur''s Gate 3', 59.99, 2, 5);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Persona 5 Royal', 39.99, 2, 3);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Cyberpunk 2077 Ultimate Ed.', 59.99, 2, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Dragon''s Dogma 2', 69.99, 2, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Mass Effect Legendary Ed.', 29.99, 2, 3);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('EA Sports FC 24', 59.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('NBA 2K24', 49.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Gran Turismo 7', 69.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Forza Horizon 5', 49.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('F1 23', 39.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Mario Kart 8 Deluxe', 49.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Madden NFL 24', 59.99, 3, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Master Chief Funko Pop', 12.99, 6, 4);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Link Amiibo - Zelda', 15.99, 6, 4);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Pokemon TCG: Booster Box', 140.00, 6, 4);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Gaming Mouse Pad RGB', 24.99, 6, 2);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Control DualSense White', 69.99, 5, 2);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ('Super Mario Plush', 19.99, 6, 4);

-- Inventory
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (10, 1, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (25, 6, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (30, 14, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 22, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (50, 35, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (20, 29, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (12, 39, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (40, 38, 1); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (8, 2, 2);  
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 7, 2);  
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (10, 17, 2); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (25, 24, 2); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (100, 37, 2); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (30, 36, 2); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 10, 2); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (5, 5, 2);   
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 3, 3);  
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (40, 27, 3); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (20, 13, 3); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 19, 3); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (25, 32, 3); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (12, 30, 3);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (50, 40, 3); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (10, 4, 3); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (12, 1, 4);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (20, 23, 4);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (18, 8, 4);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 31, 4);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (22, 15, 4); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (10, 25, 4); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (20, 12, 4); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (5, 2, 5);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 3, 5); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (12, 11, 5); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (20, 18, 5); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (15, 28, 5); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (10, 34, 5); 
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (8, 21, 5);
INSERT INTO Inventory (stock, id_product, id_branch) VALUES (25, 36, 5); 

-- Tickets
INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-20 10:30:00', 549.98, 1, 1);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-20 11:45:00', 69.99, 2, 2);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-20 13:15:00', 12.99, 3, 7);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-21 09:00:00', 1250.50, 4, 13);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-21 15:30:00', 45.00, 5, 12);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-21 20:10:00', 59.99, 1, 2);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-22 10:00:00', 349.99, 2, 15);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-22 12:00:00', 140.00, 3, 7);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-22 14:45:00', 89.98, 4, 5);

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee) 
VALUES ('2024-05-22 18:30:00', 210.00, 5, 13);

-- Ticket_details
INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 499.99, 1, 1);
INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 49.99, 1, 11);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 69.99, 2, 7);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 12.99, 3, 35);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (2, 489.00, 4, 2); 
INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (4, 69.99, 4, 14);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 45.00, 5, 10);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 59.99, 6, 6);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 349.99, 7, 3);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 140.00, 8, 37);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 69.99, 9, 39);
INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 19.99, 9, 40);

INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (2, 15.99, 10, 36);
INSERT INTO Ticket_Datalis (quantity, unit_price, id_ticket, id_product) 
VALUES (1, 140.00, 10, 37);
