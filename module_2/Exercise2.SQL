
----------------------------------------------------
--------------------| TASK 1 |----------------------
----------------------------------------------------

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) as 'Max Quantity in Order' FROM Orders;
END //

DELIMITER ;

----------------------------------------------------
--------------------| TASK 2 |----------------------
----------------------------------------------------


PREPARE GetOrderDetail FROM ' SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ? ';
SET @customer_id = 1;
EXECUTE GetOrderDetail USING @customer_id;

----------------------------------------------------
--------------------| TASK 3 |----------------------
----------------------------------------------------

DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM Orders
    WHERE OrderID = order_id;

    SELECT CONCAT('Order with OrderID = ', order_id, ' is cancelled') AS Confirmation;
END //

DELIMITER ;
CALL CancelOrder(2);