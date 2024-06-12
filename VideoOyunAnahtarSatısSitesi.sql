CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(255),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Games (
    GameID INT PRIMARY KEY AUTO_INCREMENT,
    GameName VARCHAR(100),
    Publisher VARCHAR(100),
    Genre VARCHAR(50),
    Price DECIMAL(10, 2)
);
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    GameID INT,
    SaleDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
CREATE TABLE GameKeys (
    KeyID INT PRIMARY KEY AUTO_INCREMENT,
    SaleID INT,
    GameID INT,
    Key VARCHAR(255) UNIQUE,
    UsageStatus BOOLEAN,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    GameID INT,
    UserID INT,
    Review TEXT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (GameID) REFERENCES Games(GameID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
DELIMITER //
CREATE PROCEDURE AddUser(IN firstName VARCHAR(50), IN lastName VARCHAR(50), IN email VARCHAR(100), IN password VARCHAR(255))
BEGIN
    INSERT INTO Users (FirstName, LastName, Email, Password) VALUES (firstName, lastName, email, password);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetUserTotalSales(
    IN userId INT, 
    OUT totalSales DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(TotalPrice) INTO totalSales 
    FROM Sales 
    WHERE UserID = userId;
END //
DELIMITER ;
CREATE FUNCTION GetTotalSales(userId INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE totalSales DECIMAL(10, 2);
    SELECT SUM(TotalPrice) INTO totalSales FROM Sales WHERE UserID = userId;
    RETURN totalSales;
END;
DELIMITER //
CREATE TRIGGER update_stock 
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Games 
    SET Stock = Stock - NEW.Quantity 
    WHERE GameID = NEW.GameID;
END //
DELIMITER ;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(255),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Games (
    GameID INT PRIMARY KEY AUTO_INCREMENT,
    GameName VARCHAR(100),
    Publisher VARCHAR(100),
    Genre VARCHAR(50),
    Price DECIMAL(10, 2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    GameID INT,
    SaleDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

CREATE TABLE GameKeys (
    KeyID INT PRIMARY KEY AUTO_INCREMENT,
    SaleID INT,
    GameID INT,
    Key VARCHAR(255) UNIQUE,
    UsageStatus BOOLEAN,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    GameID INT,
    UserID INT,
    Review TEXT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (GameID) REFERENCES Games(GameID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

DELIMITER //

CREATE PROCEDURE AddUser(IN firstName VARCHAR(50), IN lastName VARCHAR(50), IN email VARCHAR(100), IN password VARCHAR(255))
BEGIN
    INSERT INTO Users (FirstName, LastName, Email, Password) VALUES (firstName, lastName, email, password);
END //

CREATE PROCEDURE GetUserTotalSales(
    IN userId INT, 
    OUT totalSales DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(TotalPrice) INTO totalSales 
    FROM Sales 
    WHERE UserID = userId;
END //

DELIMITER ;
CREATE FUNCTION GetTotalSales(userId INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE totalSales DECIMAL(10, 2);
    SELECT SUM(TotalPrice) INTO totalSales FROM Sales WHERE UserID = userId;
    RETURN totalSales;
END;
CREATE FUNCTION GetTotalSales(userId INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE totalSales DECIMAL(10, 2);
    SELECT SUM(TotalPrice) INTO totalSales FROM Sales WHERE UserID = userId;
    RETURN totalSales;
END;
DELIMITER //

CREATE TRIGGER update_stock 
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Games 
    SET Stock = Stock - NEW.Quantity 
    WHERE GameID = NEW.GameID;
END //

DELIMITER ;

