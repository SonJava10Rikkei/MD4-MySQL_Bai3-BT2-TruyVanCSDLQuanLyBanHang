-- DROP DATABASE TruyVanQuanLyBanHang;
CREATE DATABASE TruyVanQuanLyBanHang;
USE TruyVanQuanLyBanHang;

CREATE TABLE Customer
(
    cID int PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(25) NOT NULL,
    cAge int NOT NULL
);

CREATE TABLE Orders
(
    oID INT PRIMARY KEY AUTO_INCREMENT,
    cID INT,
    oDate DATETIME NOT NULL,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE Product
(
    pID INT PRIMARY KEY AUTO_INCREMENT,
    pName VARCHAR(25) NOT NULL,
    pPrice INT NOT NULL
);

CREATE TABLE OrderDetail
(
    oID INT,
    pID INT,
    odQTY INT NOT NULL,
    PRIMARY KEY(oID, pID),
    FOREIGN KEY(oID) REFERENCES Orders(oID),
    FOREIGN KEY(pID) REFERENCES Product(pID)
);

INSERT INTO Customer (Name, cAge) VALUES
("Minh Quan",10),
("Ngoc Oanh",20),
("Hong Ha",50);

INSERT INTO Orders (cID, oDate) VALUES
(1, "2006-3-21"),
(2, "2006-3-23"),
(1, "2006-3-16");

INSERT INTO Product (pName, pPrice) VALUES
("May Giat", 3),
("Tu Lanh", 5),
("Dieu Hoa", 7),
("Quat", 1),
("Bep Dien", 2);

INSERT INTO OrderDetail(oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM Product;
SELECT * FROM OrderDetail;

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT * FROM Orders;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT Orders.oID, Customer.Name, Product.pName, OrderDetail.odQTY
FROM OrderDetail
    JOIN Product ON OrderDetail.pID = Product.pID
    JOIN Orders ON OrderDetail.oID = Orders.oID
    JOIN Customer ON Orders.cID = Customer.cID;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT Customer.NAME FROM Customer
    JOIN Orders ON Customer.cID <> Orders.cID;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT Orders.oID AS "Order ID", Orders.oDate AS "Order Date", SUM((OrderDetail.odQTY * Product.pPrice)) AS "Total"
FROM OrderDetail
    JOIN Product ON OrderDetail.pID = Product.pID
    JOIN Orders ON OrderDetail.oID = Orders.oID
    JOIN Customer ON Orders.cID = Customer.cID
    GROUP BY Orders.oID;