----------------------------------------------------
--------------------| TASK 1 |----------------------
----------------------------------------------------

CREATE VIEW OrdersView 
AS 
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;

----------------------------------------------------
--------------------| TASK 2 |----------------------
----------------------------------------------------

SELECT 
    Customers.CustomerID, 
    Customers.FullName,
    Orders.OrderID,
    Orders.TotalCost AS Cost,
    Menus.MenuName,
    MenuItems.CourseName,
    MenuItems.StarterName
FROM 
    Customers
INNER JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN
     Menus ON Orders.MenuID = Menus.MenuID
INNER JOIN
     MenuItems ON Menus.MenuItemID = MenuItems.MenuItemID
WHERE Orders.TotalCost > 150
ORDER BY Cost; 

----------------------------------------------------
--------------------| TASK 3 |----------------------
----------------------------------------------------

SELECT 
    MenuName 
FROM 
    Menus 
WHERE 
    MenuID = ANY ( SELECT MenuID FROM Orders WHERE Quantity > 2 );


