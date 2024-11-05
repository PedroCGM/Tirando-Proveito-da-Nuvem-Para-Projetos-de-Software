USE loja;
GO

-- Creating a sequence for generating order IDs
CREATE SEQUENCE OrderSequence
AS INT
START WITH 1
INCREMENT BY 1;

-- Creating a table for storing individuals' information
CREATE TABLE Individual(
  IndividualID INTEGER NOT NULL,
  FullName VARCHAR(255),
  Address VARCHAR(255),
  City VARCHAR(255),
  Province CHAR(2),
  PhoneNumber VARCHAR(15),
  EmailAddress VARCHAR(255),
  CONSTRAINT PK_Individual PRIMARY KEY CLUSTERED(IndividualID ASC)
);
GO

-- Creating a table for storing information of natural persons
CREATE TABLE NaturalPerson(
  FK_Individual_IndividualID INTEGER NOT NULL,
  SSN VARCHAR(11) NOT NULL,
  CONSTRAINT PK_NaturalPerson PRIMARY KEY CLUSTERED(FK_Individual_IndividualID ASC),
  CONSTRAINT FK_Individual_NaturalPerson FOREIGN KEY(FK_Individual_IndividualID) REFERENCES Individual(IndividualID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
GO

-- Creating a table for storing information of legal entities
CREATE TABLE LegalEntity(
  FK_Individual_IndividualID INTEGER NOT NULL,
  TaxID VARCHAR(14) NOT NULL,
  CONSTRAINT PK_LegalEntity PRIMARY KEY CLUSTERED(FK_Individual_IndividualID ASC),
  CONSTRAINT FK_Individual_LegalEntity FOREIGN KEY(FK_Individual_IndividualID) REFERENCES Individual(IndividualID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
GO

-- Creating a table for storing user credentials
CREATE TABLE UserCredentials(
  UserID INTEGER NOT NULL IDENTITY,
  Username VARCHAR(20) NOT NULL,
  Password VARCHAR(20) NOT NULL,
  CONSTRAINT PK_UserCredentials PRIMARY KEY CLUSTERED(UserID ASC)
);
GO

-- Creating a table for storing product information
CREATE TABLE Product(
  ProductID INTEGER NOT NULL IDENTITY,
  Name VARCHAR(255) NOT NULL,
  Quantity INTEGER,
  UnitPrice NUMERIC,
  CONSTRAINT PK_Product PRIMARY KEY CLUSTERED(ProductID ASC)
);
GO

-- Creating a table for storing transactions
CREATE TABLE Transaction(
  TransactionID INTEGER  NOT NULL IDENTITY,
  FK_UserCredentials_UserID INTEGER NOT NULL,
  FK_Individual_IndividualID INTEGER NOT NULL,
  FK_Product_ProductID INTEGER NOT NULL,
  Quantity INTEGER,
  TransactionType CHAR(1),
  UnitPrice NUMERIC,
  CONSTRAINT PK_Transaction PRIMARY KEY CLUSTERED(TransactionID ASC),
  CONSTRAINT FK_UserCredentials_Transaction FOREIGN KEY(FK_UserCredentials_UserID) REFERENCES UserCredentials(UserID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT FK_Individual_Transaction FOREIGN KEY(FK_Individual_IndividualID) REFERENCES Individual(IndividualID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT FK_Product_Transaction FOREIGN KEY(FK_Product_ProductID) REFERENCES Product(ProductID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
GO

