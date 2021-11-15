DROP TABLE IF EXISTS CustomerOrderLine;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Brand;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Subtype;
DROP TABLE IF EXISTS `Type`;
DROP TABLE IF EXISTS Color;
DROP TABLE IF EXISTS Gender;
DROP TABLE IF EXISTS Size;
DROP VIEW IF EXISTS ProductInformation;

CREATE TABLE Customer
(
  id INT NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(100) NOT NULL,
  lastname VARCHAR(100) NOT NULL,
  street VARCHAR(200) NOT NULL,
  city VARCHAR(100) NOT NULL,
  zipcode VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Brand
(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE `Type`
(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Subtype
(
  id INT NOT NULL AUTO_INCREMENT,
  typeId INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (typeId) REFERENCES `Type`(ID)
);

CREATE TABLE Color
(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Gender
(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Size
(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Product
(
  id INT NOT NULL AUTO_INCREMENT,
  price FLOAT NOT NULL,
  brandID INT NOT NULL,
  typeID INT NOT NULL,
  subtypeID INT NOT NULL,
  colorID INT NOT NULL,
  genderID INT NOT NULL,
  sizeID INT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (brandID) REFERENCES Brand(id),
  FOREIGN KEY (typeID) REFERENCES `Type`(id),
  FOREIGN KEY (subtypeID) REFERENCES Subtype(id),
  FOREIGN KEY (colorID) REFERENCES Color(id),
  FOREIGN KEY (genderID) REFERENCES Gender(id),
  FOREIGN KEY (sizeID) REFERENCES Size(id)
);

CREATE TABLE CustomerOrderLine
(
  id INT NOT NULL AUTO_INCREMENT,
  orderId INT NOT NULL,
  amount INT NOT NULL,
  productID INT NOT NULL,
  customerID INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (productID) REFERENCES Product(id),
  FOREIGN KEY (customerID) REFERENCES Customer(id)
);

CREATE VIEW ProductInformation AS (
	SELECT
        product.Id AS id,
		Brand.name AS brand,
		type.name AS type,
		subtype.name AS subtype,
		color.name AS color,
		gender.name AS gender,
		product.price as price,
		IFNULL(size.name, '-') as size
	FROM
		Product
	LEFT JOIN Brand ON Product.BrandID = Brand.ID
	LEFT JOIN Type ON Product.TypeID = Type.ID
	LEFT JOIN Subtype ON Product.SubtypeID = Subtype.ID
	LEFT JOIN Gender ON Product.GenderID = Gender.ID
	LEFT JOIN Color ON Product.ColorID = Color.ID
	LEFT JOIN Size ON Product.SizeID = Size.ID
);

