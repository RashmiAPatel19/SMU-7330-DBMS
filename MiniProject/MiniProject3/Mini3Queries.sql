use SalesOrdersExampleTest;

SELECT *
FROM Customers
WHERE Customers.CustomerID NOT IN
(SELECT CustomerID FROM
(Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber
WHERE Products.CategoryID IN (2, 6));


SELECT 
    *
FROM
    Customers
WHERE
    (CustomerID IN (SELECT 
            Orders.CustomerID
        FROM
            (Orders
            INNER JOIN Order_Details ON Orders.OrderNumber = Order_Details.OrderNumber)
                INNER JOIN
            Products ON Products.ProductNumber = Order_Details.ProductNumber
        WHERE
            Products.CategoryID = 2))
        AND (CustomerID NOT IN (SELECT 
            Orders.CustomerID
        FROM
            (Orders
            INNER JOIN Order_Details ON Orders.OrderNumber = Order_Details.OrderNumber)
                INNER JOIN
            Products ON Products.ProductNumber = Order_Details.ProductNumber
        WHERE
            Products.ProductName LIKE '%Helmet'));



SELECT 
    *
FROM
    Customers
        INNER JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
WHERE
    EXISTS( SELECT 
            OrderNumber
        FROM
            (Order_Details
            INNER JOIN Products ON Order_Details.ProductNumber = Products.ProductNumber)
                INNER JOIN
            Categories ON Products.CategoryID = Categories.CategoryID
        WHERE
            Categories.CategoryDescription = 'Bikes'
                AND Order_Details.OrderNumber = Orders.OrderNumber)
        AND NOT EXISTS( SELECT 
            *
        FROM
            Order_Details
                INNER JOIN
            Products ON Order_Details.ProductNumber = Products.ProductNumber
        WHERE
            Products.ProductName LIKE '%Helmet'
                AND Order_Details.OrderNumber = Orders.OrderNumber);


SELECT 
    *
FROM
    Customers
        INNER JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
WHERE
    EXISTS( SELECT 
            *
        FROM
            (Orders AS O2
            INNER JOIN Order_Details ON O2.OrderNumber = Order_Details.OrderNumber)
                INNER JOIN
            Products ON Products.ProductNumber = Order_Details.ProductNumber
        WHERE
            Products.CategoryID = 2
                AND Orders.CustomerID = Customers.CustomerID
                AND O2.OrderNumber = Orders.OrderNumber)
        AND EXISTS( SELECT 
            *
        FROM
            (Orders AS O3
            INNER JOIN Order_Details ON O3.OrderNumber = Order_Details.OrderNumber)
                INNER JOIN
            Products ON Products.ProductNumber = Order_Details.ProductNumber
        WHERE
            Products.ProductName LIKE '%Helmet'
                AND Orders.CustomerID = Customers.CustomerID
                AND O3.OrderNumber = Orders.OrderNumber);


SELECT *
FROM Vendors
WHERE Vendors.VendorID IN
(SELECT VendorID 
  FROM (Product_Vendors
INNER JOIN Products
ON Product_Vendors.ProductNumber = Products.ProductNumber)
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryDescription = 'Accessories')
AND Vendors.VendorID IN
(SELECT VendorID 
  FROM (Product_Vendors
INNER JOIN Products
ON Product_Vendors.ProductNumber = Products.ProductNumber)
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryDescription = 'Car racks')
AND Vendors.VendorID IN
(SELECT VendorID 
  FROM (Product_Vendors
INNER JOIN Products
ON Product_Vendors.ProductNumber = Products.ProductNumber)
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryDescription = 'Clothing');
