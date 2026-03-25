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
    id_branch INT,                             
    FOREIGN KEY (id_client) REFERENCES Clients (id_client),
    FOREIGN KEY (id_employee) REFERENCES Employees (id_employee),
    FOREIGN KEY (id_branch) REFERENCES Branches (id_branch)
);

CREATE TABLE Ticket_Details (
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

-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- Triggers de Audit
-- Roles
CREATE TRIGGER tr_roles_insert AFTER INSERT ON Roles FOR EACH ROW 
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Roles", "Insert", User());

CREATE TRIGGER tr_roles_update AFTER UPDATE ON Roles FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Roles", "Update", User());

CREATE TRIGGER tr_roles_delete AFTER DELETE ON Roles FOR EACH ROW 
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Roles", "Delete", User());

-- Categories
CREATE TRIGGER tr_categories_insert AFTER INSERT ON Categories FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Categories", "Insert", User());

CREATE TRIGGER tr_categories_update AFTER UPDATE ON Categories FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Categories", "Update", User()); 

CREATE TRIGGER tr_categories_delete AFTER DELETE ON Categories FOR EACH ROW 
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Categories", "Delete", User());

-- Suppliers
CREATE TRIGGER tr_supplier_insert AFTER INSERT ON Suppliers FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Suppliers", "Insert", User());

CREATE TRIGGER tr_supplier_update AFTER UPDATE ON Suppliers FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Suppliers", "Update", User());

CREATE TRIGGER tr_supplier_delete AFTER DELETE ON Suppliers FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Suppliers", "Delete", User());

-- Schedules
CREATE TRIGGER tr_schedules_insert AFTER INSERT on Schedules FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Schedules", "Insert", User());

CREATE TRIGGER tr_schedules_update AFTER UPDATE on Schedules FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Schedules", "Update", User());

CREATE TRIGGER tr_schedules_delete AFTER DELETE on Schedules FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Schedules", "Delete", User());

-- Branches 
CREATE TRIGGER tr_branches_insert AFTER INSERT ON Branches FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Branches", "Insert", User()); 

CREATE TRIGGER tr_branches_update AFTER UPDATE ON Branches FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Branches", "Update", User());

CREATE TRIGGER tr_branches_delete AFTER DELETE ON Branches FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Branches", "Delete", User());

-- Departments 
CREATE TRIGGER tr_departments_insert AFTER INSERT ON Departments FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Departments", "Insert", USER());

CREATE TRIGGER tr_departments_update AFTER UPDATE ON Departments FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Departments", "Update", USER());

CREATE TRIGGER tr_departments_delete AFTER DELETE ON Departments FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Departments", "Delete", USER());

-- Employees
CREATE TRIGGER tr_employee_insert AFTER INSERT ON Employees FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Employees","Insert",USER());
 
CREATE TRIGGER tr_employees_update AFTER UPDATE ON Employees FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Employees","Update",USER());

CREATE TRIGGER tr_employees_delete AFTER DELETE ON Employees FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Employees","Delete",USER());

-- Products
CREATE TRIGGER tr_products_insert AFTER INSERT ON Products FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Products","Insert",USER());

CREATE TRIGGER tr_products_update AFTER UPDATE ON Products FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user)  VALUES ("Products","Update",USER());

CREATE TRIGGER tr_products_delete AFTER DELETE ON Products FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Products","Delete",USER());

-- Inventory
CREATE TRIGGER tr_inventory_insert AFTER INSERT ON Inventory FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Inventory","Insert",USER());

CREATE TRIGGER tr_inventory_update AFTER UPDATE ON Inventory FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user)  VALUES ("Inventory","Update",USER());

CREATE TRIGGER tr_inventory_delete AFTER DELETE ON Inventory FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Inventory","Delete",USER());

-- Clients
CREATE TRIGGER tr_clients_insert AFTER INSERT ON Clients FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Clients","Insert",USER());

CREATE TRIGGER tr_clients_update AFTER UPDATE ON Clients FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user)  VALUES ("Clients","Update",USER());

CREATE TRIGGER tr_clients_delete AFTER DELETE ON Clients FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Clients","Delete",USER());

-- Tickets
CREATE TRIGGER tr_tickets_insert AFTER INSERT ON Tickets FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Tickets","Insert",USER());

CREATE TRIGGER tr_tickets_update AFTER UPDATE ON Tickets FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user)  VALUES ("Tickets","Update",USER());

CREATE TRIGGER tr_tickets_delete AFTER DELETE ON Tickets FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Tickets","Delete",USER());

-- Ticket_Details
CREATE TRIGGER tr_tickets_details_insert AFTER INSERT ON Ticket_Details FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Ticket_Details","Insert",USER());

CREATE TRIGGER tr_tickets_details_update AFTER UPDATE ON Ticket_Details FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user)  VALUES ("Ticket_Details","Update",USER());

CREATE TRIGGER tr_tickets_details_delete AFTER DELETE ON Ticket_Details FOR EACH ROW
INSERT INTO Audit (affected_table, action_, db_user) VALUES ("Ticket_Details","Delete",USER());

-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

DELIMITER //

-- Trigger: validar stock antes de registrar una venta
CREATE TRIGGER tr_check_stock_before_sale
BEFORE INSERT ON Ticket_Details
FOR EACH ROW
BEGIN
    DECLARE v_branch INT;
    DECLARE v_stock  INT;

    SELECT id_branch INTO v_branch
    FROM Tickets WHERE id_ticket = NEW.id_ticket;

    SELECT stock INTO v_stock
    FROM Inventory
    WHERE id_product = NEW.id_product AND id_branch = v_branch;

    IF v_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Producto no disponible en esta sucursal';
    END IF;

    IF v_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para completar la venta';
    END IF;
END //

-- Trigger: descontar stock al registrar una venta
CREATE TRIGGER tr_reduce_stock_on_sale
AFTER INSERT ON Ticket_Details
FOR EACH ROW
BEGIN
    DECLARE v_branch INT;

    SELECT id_branch INTO v_branch
    FROM Tickets WHERE id_ticket = NEW.id_ticket;

    UPDATE Inventory
    SET stock = stock - NEW.quantity
    WHERE id_product = NEW.id_product AND id_branch = v_branch;
END //

-- Trigger: recalcular total_amount del ticket automáticamente
CREATE TRIGGER tr_update_ticket_total
AFTER INSERT ON Ticket_Details
FOR EACH ROW
BEGIN
    UPDATE Tickets
    SET total_amount = (
        SELECT SUM(quantity * unit_price)
        FROM Ticket_Details
        WHERE id_ticket = NEW.id_ticket
    )
    WHERE id_ticket = NEW.id_ticket;
END //

-- Trigger: restaurar stock si se elimina un detalle de ticket
CREATE TRIGGER tr_restore_stock_on_delete
AFTER DELETE ON Ticket_Details
FOR EACH ROW
BEGIN
    DECLARE v_branch INT;

    SELECT id_branch INTO v_branch
    FROM Tickets WHERE id_ticket = OLD.id_ticket;

    UPDATE Inventory
    SET stock = stock + OLD.quantity
    WHERE id_product = OLD.id_product AND id_branch = v_branch;
END //

-- Trigger: ajustar stock si se modifica la cantidad de un detalle
CREATE TRIGGER tr_adjust_stock_on_update
AFTER UPDATE ON Ticket_Details
FOR EACH ROW
BEGIN
    DECLARE v_branch INT;
    DECLARE v_diff   INT;

    SELECT id_branch INTO v_branch
    FROM Tickets WHERE id_ticket = NEW.id_ticket;

    SET v_diff = NEW.quantity - OLD.quantity;

    UPDATE Inventory
    SET stock = stock - v_diff
    WHERE id_product = NEW.id_product AND id_branch = v_branch;
END //

DELIMITER ;

-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
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

-- Departments
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
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ("Gaming Monitor 4K", 399.99, 5, 1);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ("Mechanical Keyboard RGB", 85.00, 3, 4);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ("Gaming Chair Pro", 250.00, 3, 5);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ("Mousepad XL", 25.00, 3, 4);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ("Streaming Microphone", 120.00, 3, 4);
INSERT INTO Products (name_, price, id_category, id_supplier) VALUES ("HDMI 2.1 Cable", 19.99, 3, 1);

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

-- Clients 
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Juan Pérez', '555-0101', 'juan.perez@email.com', 'Av. Siempre Viva 123', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('María García', '555-0102', 'maria.garcia@email.com', 'Calle Falsa 456', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Carlos Rodríguez', '555-0103', 'c.rodriguez@email.com', 'Paseo de la Reforma 789', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Ana Martínez', '555-0104', 'ana.mtz@email.com', 'Av. Insurgentes 101', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Luis Hernández', '555-0105', 'luis.hndz@email.com', 'Colonia Juárez 202', 'Inactive');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Elena López', '555-0106', 'elena.lopez@email.com', 'Calle 50 x 25', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Miguel Ángel Torres', '555-0107', 'm.torres@email.com', 'Av. Juárez 303', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Lucía Fernández', '555-0108', 'lucia.f@email.com', 'Privada del Sol 404', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Ricardo Sánchez', '555-0109', 'r.sanchez@email.com', 'Boulevard Central 505', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Sofía Ramírez', '555-0110', 'sofia.ram@email.com', 'Calle Hidalgo 606', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Fernando Gomez', '555-0111', 'f.gomez@email.com', 'Av. Universidad 707', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Valeria Diaz', '555-0112', 'v.diaz@email.com', 'Calle Morelos 808', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Javier Vazquez', '555-0113', 'j.vazquez@email.com', 'Av. Chapultepec 909', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Camila Castro', '555-0114', 'c.castro@email.com', 'Calle 10 num 111', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Daniel Morales', '555-0115', 'd.morales@email.com', 'Paseo de las Flores 222', 'Inactive');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Paola Herrera', '555-0116', 'p.herrera@email.com', 'Av. Tecnológico 333', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Alejandro Medina', '555-0117', 'a.medina@email.com', 'Calle Libertad 444', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Gabriela Silva', '555-0118', 'g.silva@email.com', 'Av. Constituyentes 555', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Roberto Flores', '555-0119', 'r.flores@email.com', 'Calle Zaragoza 666', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Adriana Rojas', '555-0120', 'a.rojas@email.com', 'Av. Madero 777', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Diego Luna', '555-0121', 'd.luna@email.com', 'Calle Pino 888', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Mónica Vargas', '555-0122', 'm.vargas@email.com', 'Av. Roble 999', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Francisco Lara', '555-0123', 'f.lara@email.com', 'Calle Sauce 121', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Beatriz Solis', '555-0124', 'b.solis@email.com', 'Av. Fresno 131', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Hugo Ortega', '555-0125', 'h.ortega@email.com', 'Calle Alamo 141', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Jimena Mendoza', '555-0126', 'j.mendoza@email.com', 'Av. Palma 151', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Óscar Ríos', '555-0127', 'o.rios@email.com', 'Calle Cedro 161', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Natalia Cruz', '555-0128', 'n.cruz@email.com', 'Av. Laurel 171', 'Inactive');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Jorge Núñez', '555-0129', 'j.nunez@email.com', 'Calle Olmo 181', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Claudia Salazar', '555-0130', 'c.salazar@email.com', 'Av. Ciprés 191', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Manuel Bravo', '555-0131', 'm.bravo@email.com', 'Calle Nogal 202', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Raquel Paredes', '555-0132', 'r.paredes@email.com', 'Av. Acacia 212', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Andrés Acosta', '555-0133', 'a.acosta@email.com', 'Calle Abeto 222', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Silvia Pineda', '555-0134', 's.pineda@email.com', 'Av. Maple 232', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Raúl Mendez', '555-0135', 'r.mendez@email.com', 'Calle Cerezo 242', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Patricia Miranda', '555-0136', 'p.miranda@email.com', 'Av. Castaño 252', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Ignacio Soto', '555-0137', 'i.soto@email.com', 'Calle Avellano 262', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Teresa Vega', '555-0138', 't.vega@email.com', 'Av. Eucalipto 272', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Víctor Fuentes', '555-0139', 'v.fuentes@email.com', 'Calle Bambú 282', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Isabel Campos', '555-0140', 'i.campos@email.com', 'Av. Caoba 292', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Felipe Delgado', '555-0141', 'f.delgado@email.com', 'Calle Ébano 303', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Lorena Ibarra', '555-0142', 'l.ibarra@email.com', 'Av. Granadillo 313', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Sebastián Meza', '555-0143', 's.meza@email.com', 'Calle Haya 323', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Gloria Rangel', '555-0144', 'g.rangel@email.com', 'Av. Iroko 333', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Cristian Carrillo', '555-0145', 'c.carrillo@email.com', 'Calle Jatoba 343', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Estela Rosas', '555-0146', 'e.rosas@email.com', 'Av. Limoncillo 353', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Marcos Esquivel', '555-0147', 'm.esquivel@email.com', 'Calle Mimosa 363', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Diana Trejo', '555-0148', 'd.trejo@email.com', 'Av. Naranjo 373', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Sergio Palacios', '555-0149', 's.palacios@email.com', 'Calle Okume 383', 'Inactive');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Karla Beltrán', '555-0150', 'k.beltran@email.com', 'Av. Peral 393', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Samuel Bernal', '555-0151', 's.bernal@email.com', 'Calle Quina 404', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Rosaura Gallegos', '555-0152', 'r.gallegos@email.com', 'Av. Roble Blanco 414', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Esteban Guevara', '555-0153', 'e.guevara@email.com', 'Calle Sándalo 424', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Julia Montes', '555-0154', 'j.montes@email.com', 'Av. Teca 434', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Jaime Corona', '555-0155', 'j.corona@email.com', 'Calle Urua 444', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Yolanda Benítez', '555-0156', 'y.benitez@email.com', 'Av. Viraró 454', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Iván Jurado', '555-0157', 'i.jurado@email.com', 'Calle Wengué 464', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Verónica Leyva', '555-0158', 'v.leyva@email.com', 'Av. Xylia 474', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Arturo Villalobos', '555-0159', 'a.villalobos@email.com', 'Calle Yaya 484', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Bárbara Tapia', '555-0160', 'b.tapia@email.com', 'Av. Zapote 494', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('César Figueroa', '555-0161', 'c.figueroa@email.com', 'Calle Arce 505', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Alicia Zambrano', '555-0162', 'a.zambrano@email.com', 'Av. Boj 515', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Gonzalo Valadez', '555-0163', 'g.valadez@email.com', 'Calle Coco 525', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Brenda Olvera', '555-0164', 'b.olvera@email.com', 'Av. Durazno 535', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Mateo Espinoza', '555-0165', 'm.espinoza@email.com', 'Calle Encino 545', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Miriam Aranda', '555-0166', 'm.aranda@email.com', 'Av. Frambuesa 555', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Gerardo Ulloa', '555-0167', 'g.ulloa@email.com', 'Calle Girasol 565', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Leticia Orozco', '555-0168', 'l.orozco@email.com', 'Av. Heliotropo 575', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Dante Nava', '555-0169', 'd.nava@email.com', 'Calle Iris 585', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Fabiola Becerra', '555-0170', 'f.becerra@email.com', 'Av. Jazmín 595', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Mauricio Gaytán', '555-0171', 'm.gaytan@email.com', 'Calle Kentia 606', 'Inactive');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Rebeca Perales', '555-0172', 'r.perales@email.com', 'Av. Loto 616', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Omar Santillán', '555-0173', 'o.santillan@email.com', 'Calle Magnolia 626', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Tatiana Malpica', '555-0174', 't.malpica@email.com', 'Av. Narciso 636', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Erick Téllez', '555-0175', 'e.tellez@email.com', 'Calle Orquídea 646', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Mireya Castañeda', '555-0176', 'm.castaneda@email.com', 'Av. Pensamiento 656', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Agustín Correa', '555-0177', 'a.correa@email.com', 'Calle Quetzal 666', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Lourdes Rendón', '555-0178', 'l.rendon@email.com', 'Av. Rosa 676', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Saúl Briones', '555-0179', 's.briones@email.com', 'Calle Tulipán 686', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Guadalupe Arellano', '555-0180', 'g.arellano@email.com', 'Av. Violeta 696', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Rodolfo Escamilla', '555-0181', 'r.escamilla@email.com', 'Calle Wasabi 707', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Ximena Galán', '555-0182', 'x.galan@email.com', 'Av. Yuca 717', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Benjamín Macías', '555-0183', 'b.macias@email.com', 'Calle Zinnia 727', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Aída Marín', '555-0184', 'a.marin@email.com', 'Av. Alhelí 737', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Néstor Ávila', '555-0185', 'n.avila@email.com', 'Calle Begonia 747', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Elisa Garibay', '555-0186', 'e.garibay@email.com', 'Av. Camelia 757', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Félix Barajas', '555-0187', 'f.barajas@email.com', 'Calle Dalia 767', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Karina Tovar', '555-0188', 'k.tovar@email.com', 'Av. Edelweiss 777', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Héctor Cuellar', '555-0189', 'h.cuellar@email.com', 'Calle Fuchsia 787', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Silvana Bañuelos', '555-0190', 's.banuelos@email.com', 'Av. Geranio 797', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Israel Magaña', '555-0191', 'i.magana@email.com', 'Calle Hortensia 808', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Nora Cárdenas', '555-0192', 'n.cardenas@email.com', 'Av. Jacaranda 818', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Lorenzo Alarcón', '555-0193', 'l.alarcon@email.com', 'Calle Lavanda 828', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Cecilia Godínez', '555-0194', 'c.godinez@email.com', 'Av. Mimosa 838', 'Inactive');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Salvador Lemus', '555-0195', 's.lemus@email.com', 'Calle Nardo 848', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Erika Vaca', '555-0196', 'e.vaca@email.com', 'Av. Olivo 858', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Ramón Osorio', '555-0197', 'r.osorio@email.com', 'Calle Petunia 868', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Ofelia Paredes', '555-0198', 'o.paredes@email.com', 'Av. Reseda 878', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Uriel Cisneros', '555-0199', 'u.cisneros@email.com', 'Calle Silene 888', 'Active');
INSERT INTO Clients (name_, phone, email, address, status_) VALUES ('Violeta Rivas', '555-0200', 'v.rivas@email.com', 'Av. Verbena 898', 'Active');
 
-- Tickets

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-20 10:30:00', 0.00, 1, 1, 2);  -- branch 2: tiene productos 10 y 37

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-20 11:45:00', 0.00, 2, 2, 2);  -- branch 2: tiene producto 7

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-20 13:15:00', 0.00, 3, 7, 1);  -- branch 1: tiene producto 29

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-21 09:00:00', 0.00, 4, 13, 2); -- branch 2: tiene productos 10 y 37

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-21 15:30:00', 0.00, 5, 12, 3); -- branch 3: tiene producto 40

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-21 20:10:00', 0.00, 1, 2, 1);  -- branch 1: tiene producto 6

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-22 10:00:00', 0.00, 2, 15, 5); -- branch 5: tiene producto 11

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-22 12:00:00', 0.00, 3, 7, 4);  -- branch 4: tiene producto 31

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-22 14:45:00', 0.00, 4, 5, 2);  -- branch 2: tiene productos 37 y 36

INSERT INTO Tickets (ticket_date, total_amount, id_client, id_employee, id_branch)
VALUES ('2024-05-22 18:30:00', 0.00, 5, 13, 3); -- branch 3: tiene productos 30 y 32

-- Ticket_Details
-- MEJORA: el trigger calcula total_amount y descuenta stock automaticamente
INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 489.00, 1, 10);  -- Xbox Series X      → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 399.99, 1, 37);  -- Gaming Monitor 4K  → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 49.99, 2, 7);    -- Assassins Creed    → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 12.99, 3, 29);   -- Master Chief Funko → branch 1 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (2, 489.00, 4, 10);  -- Xbox Series X x2   → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 399.99, 4, 37);  -- Gaming Monitor 4K  → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 19.99, 5, 40);   -- HDMI 2.1 Cable     → branch 3 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 49.99, 6, 6);    -- Ghost of Tsushima  → branch 1 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 349.99, 7, 11);  -- Nintendo Switch    → branch 5 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 140.00, 8, 31);  -- Pokemon TCG Box    → branch 4 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 399.99, 9, 37);  -- Gaming Monitor 4K  → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 85.00, 9, 36);   -- Mechanical Keyboard → branch 2 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (2, 15.99, 10, 30);  -- Link Amiibo x2     → branch 3 OK

INSERT INTO Ticket_Details (quantity, unit_price, id_ticket, id_product)
VALUES (1, 49.99, 10, 32);  -- Gaming Mouse Pad   → branch 3 OK

-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- Views
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

-- inventory by branch: the inventory available in each store
create view vw_inventory_by_branch as
select b.name_ as Branch, p.name_ as Product, i.stock as current_stock
from Inventory i join Branches b on i.id_branch = b.id_branch
join Products p on i.id_product = p.id_product;
-- ============================================================================
select * from vw_inventory_by_branch;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

-- sales report by customer
create view vw_sales_by_customer as
select c.name_ as client, sum(t.total_amount) as total_spent
from Clients c
join Tickets t on c.id_client = t.id_client group by c.id_client;
-- ============================================================================
select * from vw_sales_by_customer;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

-- Best-selling products report
create view vw_best_selling_products as
select p.name_ as product, sum(td.quantity) as total_units_sold
from Ticket_Details td
join Products p on td.id_product = p.id_product
group by p.id_product;
-- ============================================================================
select * from vw_best_selling_products;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

-- loyalty report: Who are our most frequent customers?
create view vw_client_loyalty as
select c.name_ as client, count(t.id_ticket) as visit_count
from Clients c
join Tickets t on c.id_client = t.id_client
group by c.id_client;
-- ============================================================================
select * from vw_client_loyalty;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

-- critical stock report: Which branch needs urgent restocking?
create view vw_critical_stock as
select b.name_ as branch, p.name_ as product, i.stock
from Inventory i
join Branches b on i.id_branch = b.id_branch join Products p on i.id_product = p.id_product
where i.stock < 5;
-- ============================================================================
select * from vw_critical_stock;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*

-- Stored Procedures
-- ============================================================================ branches
-- ---------------------------------------------------------------------------------------insert
delimiter //
create procedure sp_create_branch(in p_name varchar(250), in p_address text, in p_id_sch int)
begin insert into branches(name_, address, id_schedule) values (p_name, p_address, p_id_sch);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_branch(in p_id int)
begin select * from branches where id_branch = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_branch(in p_id int, in p_name varchar(250), in p_address text)
begin update branches set name_ = p_name, address = p_address where id_branch = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_branch(in p_id int)
begin delete from branches where id_branch = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ clients
-- ---------------------------------------------------------------------------------------insert
delimiter //
create procedure sp_create_client(in p_name varchar(250), in p_phone varchar(50), in p_email varchar(250))
begin insert into clients(name_, phone, email) values (p_name, p_phone, p_email);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_client(in p_id int)
begin select * from clients where id_client = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_client(in p_id int, in p_name varchar(250), in p_phone varchar(50))
begin update clients set name_ = p_name, phone = p_phone where id_client = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_client(in p_id int)
begin delete from clients where id_client = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ departments
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_department(in p_name varchar(250), in p_branch int)
begin insert into departments(name_, id_branch) values (p_name, p_branch);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_department(in p_id int)
begin select * from departments where id_departments = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_department(in p_id int, in p_name varchar(250))
begin update departments set name_ = p_name where id_departments = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_department(in p_id int)
begin delete from departments where id_departments = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ categories
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_category(in p_name varchar(250))
begin insert into categories(name_) values (p_name);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_category(in p_id int)
begin select * from categories where id_category = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_category(in p_id int, in p_status boolean)
begin update categories set status_ = p_status where id_category = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_category(in p_id int)
begin delete from categories where id_category = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ employees
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_employee(in p_name varchar(250), in p_phone varchar(20), in p_day date, in p_rol int, in p_dep int)
begin insert into employees(name_, phone, contract_day, id_rol, id_departments) values (p_name, p_phone, p_day, p_rol, p_dep);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_employee(in p_id int)
begin select * from employees where id_employee = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_employee(in p_id int, in p_status enum('Active','Inactive','On Leave'))
begin update employees set status_ = p_status where id_employee = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_employee(in p_id int)
begin delete from employees where id_employee = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ inventory
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_inventory(in p_stock int, in p_prod int, in p_branch int)
begin insert into inventory(stock, id_product, id_branch) values (p_stock, p_prod, p_branch);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_inventory(in p_id int)
begin select * from inventory where id_inventory = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_stock(in p_id int, in p_stock int)
begin update inventory set stock = p_stock where id_inventory = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_inventory(in p_id int)
begin delete from inventory where id_inventory = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ products
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_product(in p_name varchar(250), in p_price decimal(10,2), in p_cat int, in p_supp int)
begin insert into products(name_, price, id_category, id_supplier) values (p_name, p_price, p_cat, p_supp);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_product(in p_id int)
begin select * from products where id_product = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_product(in p_id int, in p_name varchar(250), in p_price decimal(10,2))
begin update products set name_ = p_name, price = p_price where id_product = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_product(in p_id int)
begin delete from products where id_product = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ roles
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_rol(in p_name varchar(250), in p_salary decimal(10,2), in p_desc text)
begin insert into roles(name_, salary, description_) values (p_name, p_salary, p_desc);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_rol(in p_id int)
begin select * from roles where id_rol = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_rol(in p_id int, in p_name varchar(250), in p_salary decimal(10,2))
begin update roles set name_ = p_name, salary = p_salary where id_rol = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_rol(in p_id int)
begin delete from roles where id_rol = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ schedules
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_schedule(in p_start time, in p_end time, in p_days varchar(250))
begin insert into schedules(start_time, end_time, work_days) values (p_start, p_end, p_days);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_schedule(in p_id int)
begin select * from schedules where id_schedule = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_schedule(in p_id int, in p_start time, in p_end time, in p_days varchar(250))
begin update schedules set start_time = p_start, end_time = p_end, work_days = p_days where id_schedule = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_schedule(in p_id int)
begin delete from schedules where id_schedule = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ suppliers
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_supplier(in p_name varchar(250), in p_phone varchar(50), in p_email varchar(250))
begin insert into suppliers(name_, phone, email) values (p_name, p_phone, p_email);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_supplier(in p_id int)
begin select * from suppliers where id_supplier = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_supplier(in p_id int, in p_name varchar(250), in p_phone varchar(50), in p_email varchar(250))
begin update suppliers set name_ = p_name, phone = p_phone, email = p_email where id_supplier = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_supplier(in p_id int)
begin delete from suppliers where id_supplier = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ Ticket_Details
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_detail(in p_qty int, in p_price decimal(10,2), in p_ticket int, in p_prod int)
begin insert into Ticket_Details (quantity, unit_price, id_ticket, id_product) values (p_qty, p_price, p_ticket, p_prod);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_detail(in p_id int)
begin select * from Ticket_Details where id_detail = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_detail(in p_id int, in p_qty int, in p_price decimal(10,2))
begin update Ticket_Details set quantity = p_qty, unit_price = p_price where id_detail = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_detail(in p_id int)
begin delete from Ticket_Details where id_detail = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
-- ============================================================================ tickets
-- --------------------------------------------------------------------------------------- insert
delimiter //
create procedure sp_create_ticket(in p_client int, in p_emp int, in p_branch int)
begin insert into tickets(id_client, id_employee, id_branch) values (p_client, p_emp, p_branch);
end //
-- --------------------------------------------------------------------------------------- select
create procedure sp_read_ticket(in p_id int)
begin select * from tickets where id_ticket = p_id;
end //
-- --------------------------------------------------------------------------------------- update
create procedure sp_update_ticket(in p_id int, in p_total decimal(10,2), in p_client int)
begin update tickets set total_amount = p_total, id_client = p_client where id_ticket = p_id;
end //
-- --------------------------------------------------------------------------------------- delete
create procedure sp_delete_ticket(in p_id int)
begin delete from tickets where id_ticket = p_id;
end //
delimiter ;
-- -----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*-----*
select * from vw_client_loyalty;
SELECT COUNT(id_client) AS conteo_real FROM Clients;

SELECT id_ticket, ticket_date, total_amount, id_branch FROM Tickets;
SELECT * FROM vw_inventory_by_branch;

SELECT 
    b.name_ AS branch,
    p.name_ AS product,
    i.stock AS stock_actual,
    SUM(td.quantity) AS total_vendido
FROM Inventory i
JOIN Products p ON i.id_product = p.id_product
JOIN Branches b ON i.id_branch = b.id_branch
LEFT JOIN Ticket_Details td ON td.id_product = i.id_product
LEFT JOIN Tickets t ON td.id_ticket = t.id_ticket AND t.id_branch = i.id_branch
GROUP BY i.id_inventory, b.name_, p.name_, i.stock
ORDER BY b.name_, p.name_;