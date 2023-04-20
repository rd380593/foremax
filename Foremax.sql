CREATE TABLE IF NOT EXISTS Usuario (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    balance REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS Divisas (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    sigla TEXT NOT NULL,
    tasa REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS Tarjetas (
    id INTEGER PRIMARY KEY,
    numero TEXT NOT NULL,
    vencimiento TEXT NOT NULL,
    cvv TEXT NOT NULL,
    marca TEXT NOT NULL CHECK (marca IN ('Visa', 'Mastercard', 'American Express')),
    id_usuario INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id)
);

CREATE TABLE IF NOT EXISTS Monedero (
    id INTEGER PRIMARY KEY,
    saldo REAL NOT NULL,
    id_usuario INTEGER NOT NULL,
    id_divisa INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id),
    FOREIGN KEY (id_divisa) REFERENCES Divisas (id)
);

CREATE TABLE IF NOT EXISTS Transacciones (
    id INTEGER PRIMARY KEY,
    cant REAL NOT NULL,
    valor REAL NOT NULL,
    tipo TEXT NOT NULL CHECK (tipo IN ('Compra', 'Venta')),
    comision REAL NOT NULL,
    id_usuario INTEGER NOT NULL,
    id_divisa INTEGER NOT NULL,
    id_monedero INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id),
    FOREIGN KEY (id_divisa) REFERENCES Divisas (id),
    FOREIGN KEY (id_monedero) REFERENCES Monedero (id)
);


--Añadir datos
INSERT INTO Divisas (nombre, sigla, tasa)
VALUES 
    ('Dólar Estadounidense', 'USD', 57.0),
    ('Dólar Canadiense', 'CAD', 45.3),
    ('Euro', 'EUR', 65.5),
    ('Peso Mexicano', 'MXN', 2.9),
    ('Bitcoin', 'BTC', 2700000.0),
    ('Litecoin', 'LTC', 2100.0),
    ('Libras Esterlinas', 'GBP', 74.1),
    ('Dogecoin', 'DOGE', 0.17), 
    ('Sol Peruano', 'PEN', 14.3),
    ('Franco Suizo', 'CHF', 62.0),
    ('Lira Turca', 'TRY', 7.0),
    ('Ethereum', 'ETH', 92000.0);

INSERT INTO Usuario (nombre, telefono, correo, balance)
VALUES 
    ('Juan Pérez', '809-123-4567', 'juan.perez@example.com', 1000),
    ('María Rodríguez', '829-234-5678', 'maria.rodriguez@example.com', 2100),
    ('Carlos Martínez', '849-345-6789', 'carlos.martinez@example.com', 3200),
    ('Ana García', '809-456-7890', 'ana.garcia@example.com', 4300),
    ('Luis Torres', '829-567-8901', 'luis.torres@example.com', 5400),
    ('Carmen Herrera', '849-678-9012', 'carmen.herrera@example.com', 6500),
    ('Fernando González', '809-789-0123', 'fernando.gonzalez@example.com', 7600),
    ('Sofía Morales', '829-890-1234', 'sofia.morales@example.com', 8700),
    ('Ricardo Castillo', '849-901-2345', 'ricardo.castillo@example.com', 9800),
    ('Laura Peña', '809-012-3456', 'laura.pena@example.com', 10000);

INSERT INTO Tarjetas (numero, vencimiento, cvv, marca, id_usuario)
VALUES
    ('4123456789012345', '04/24', '123', 'Visa', 1),
    ('5412345678901234', '06/25', '456', 'Mastercard', 1),
    ('347123456789012', '08/24', '789', 'American Express', 2),
    ('4512345678901234', '10/26', '321', 'Visa', 2),
    ('5290123456789012', '12/24', '654', 'Mastercard', 3),
    ('4532123456789012', '02/25', '987', 'Visa', 4),
    ('375612345678901', '03/26', '135', 'American Express', 5),
    ('5412345678909876', '05/25', '246', 'Mastercard', 6),
    ('4123456789010987', '07/27', '357', 'Visa', 6),
    ('375712345678902', '09/24', '468', 'American Express', 7),
    ('4556123456789012', '11/28', '579', 'Visa', 7),
    ('5345123456789012', '06/26', '612', 'Mastercard', 8),
    ('4929123456789012', '07/25', '723', 'Visa', 9),
    ('376212345678903', '08/26', '834', 'American Express', 9),
    ('5245123456789012', '09/27', '945', 'Mastercard', 10),
    ('4539123456789012', '12/29', '056', 'Visa', 10);


INSERT INTO Monedero (saldo, id_usuario, id_divisa)
VALUES
    (25000 / 57.0, 1, 1),
    (300000 / 2700000.0, 1, 5),
    (40000 / 7.0, 1, 11),

    (150000 / 65.5, 2, 3),
    (85000 / 45.3, 2, 2),
    (0.015, 2, 5),

    (0.12, 3, 12),
    (60000 / 0.17, 3, 8),
    (35000 / 2.9, 3, 4),

    (45000 / 2.9, 4, 4),
    (0.05, 4, 6),
    (180000 / 2700000.0, 4, 5),

    (75000 / 74.1, 5, 7),
    (0.008, 5, 11),
    (23000 / 2.9, 5, 4),

    (120000 / 45.3, 6, 2),
    (0.025, 6, 12),
    (40000 / 7.0, 6, 11),

    (90000 / 65.5, 7, 3),
    (0.02, 7, 11),
    (0.1, 7, 5),

    (75000 / 65.5, 8, 3),
    (0.005, 8, 6),
    (0.04, 8, 5),

    (160000 / 65.5, 9, 3),
    (0.01, 9, 5),
    (80000 / 62.0, 9, 10),

    (100000 / 57.0, 10, 1),
    (0.03, 10, 6),
    (20000 / 14.3, 10, 9);




INSERT INTO transacciones (cant, valor, tipo, comision, id_usuario, id_divisa, id_monedero)
VALUES
	(0.1 * (1000 / 57.0), 57.0, 'Compra', 0.03 * (0.1 * (1000 / 57.0) * 57.0), 1, 1, 1),
    (0.3 * (1000 / 57.0), 57.0, 'Venta', 0.03 * (0.3 * (1000 / 57.0) * 57.0), 1, 1, 1),
    (0.15 * (1000 / 62.0), 62.0, 'Compra', 0.03 * (0.15 * (1000 / 62.0) * 62.0), 1, 10, 2),

    (0.1 * (2100 / 45.3), 45.3, 'Compra', 0.03 * (0.1 * (2100 / 45.3) * 45.3), 2, 2, 5),
    (0.3 * (2100 / 45.3), 45.3, 'Venta', 0.03 * (0.3 * (2100 / 45.3) * 45.3), 2, 2, 5),
    (0.2 * (2100 / 65.5), 65.5, 'Compra', 0.03 * (0.2 * (2100 / 65.5) * 65.5), 2, 3, 6),

    (0.1 * (3200 / 65.5), 65.5, 'Compra', 0.03 * (0.1 * (3200 / 65.5) * 65.5), 3, 3, 7),
    (0.3 * (3200 / 65.5), 65.5, 'Venta', 0.03 * (0.3 * (3200 / 65.5) * 65.5), 3, 3, 7),
    (0.15 * (3200 / 2.9), 2.9, 'Compra', 0.03 * (0.15 * (3200 / 2.9) * 2.9), 3, 4, 8),

    (0.1 * (4300 / 2.9), 2.9, 'Compra', 0.03 * (0.1 * (4300 / 2.9) * 2.9), 4, 4, 10),
    (0.3 * (4300 / 2.9), 2.9, 'Venta', 0.03 * (0.3 * (4300 / 2.9) * 2.9), 4, 4, 10),
    (0.2 * (4300 / 74.1), 74.1, 'Venta', 0.03 * (0.2 * (4300 / 74.1) * 74.1), 4, 7, 11);