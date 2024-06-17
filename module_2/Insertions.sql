use LittleLemonDB;
INSERT INTO `LittleLemonDB`.`Customers` (FullName, ContactNumber, Email) VALUES
('John Doe', '123-456-7890', 'john.doe@example.com'),
('Jane Smith', '234-567-8901', 'jane.smith@example.com'),
('Alice Johnson', '345-678-9012', 'alice.johnson@example.com'),
('Bob Brown', '456-789-0123', 'bob.brown@example.com'),
('Charlie Davis', '567-890-1234', 'charlie.davis@example.com'),
('Eve Martinez', '678-901-2345', 'eve.martinez@example.com');
select * from Customers;

INSERT INTO `LittleLemonDB`.`MenuItems` (CourseName, StarterName, DessertName) VALUES
('Italian Feast', 'Bruschetta', 'Tiramisu'),
('Seafood Delight', 'Shrimp Cocktail', 'Key Lime Pie'),
('Vegan Special', 'Stuffed Mushrooms', 'Sorbet'),
('Grill Masters', 'BBQ Wings', 'Brownie Sundae'),
('Breakfast Bonanza', 'Pancakes', 'Fruit Salad'),
('Asian Fusion', 'Spring Rolls', 'Mango Sticky Rice');

INSERT INTO `LittleLemonDB`.`Menus` (MenuID, MenuName, Cuisine, MenuItemID) VALUES
(1, 'Italian Menu', 'Italian', 1),
(2, 'Seafood Menu', 'Seafood', 2),
(3, 'Vegan Menu', 'Vegan', 3),
(4, 'BBQ Menu', 'American', 4),
(5, 'Breakfast Menu', 'Breakfast', 5),
(6, 'Asian Menu', 'Asian', 6);

INSERT INTO `LittleLemonDB`.`Orders` (OrderDate, Quantity, TotalCost, CustomerID, MenuID) VALUES
('2024-06-01', 2, 40.00, 1, 1),
('2024-06-02', 1, 20.00, 2, 2),
('2024-06-03', 3, 60.00, 3, 3),
('2024-06-04', 1, 15.00, 4, 4),
('2024-06-05', 2, 30.00, 5, 5),
('2024-06-06', 4, 80.00, 6, 6);


INSERT INTO `LittleLemonDB`.`Bookings` (TableNumber, BookingDate, CustomerID) VALUES
(5, '2022-10-10', 1),
(3, '2022-11-13', 3),
(2, '2022-10-11', 2),
(2, '2022-10-13', 1);

DELIMITER //
CREATE PROCEDURE CheckBooking(IN date DATE, IN table_no INT)
BEGIN
    DECLARE BookingStatus VARCHAR(45);
    SELECT 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM Bookings 
                WHERE date = BookingDate and table_no = TableNumber
            )
        THEN 'Table is already booked'
        ELSE 'Table is available'
    END INTO BookingStatus;

    SELECT BookingStatus as Status;
END //

DELIMITER ;
call CheckBooking("2022-10-11", 2);

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN date DATE, IN table_no INT, IN customer_id INT)
BEGIN
    
    DECLARE booking_status INT;

    START TRANSACTION;

    SELECT 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM Bookings 
                WHERE date = BookingDate and table_no = TableNumber
            )
        THEN 'Table is already booked'
        ELSE 'Table is available'
    END INTO booking_status;

    IF booking_status = 'Table is already booked' THEN 
        ROLLBACK;
        SELECT 'Table is already booked. Booking Declined!' AS Message;
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID) VALUES (date, table_no, customer_id);
        COMMIT;
        SELECT 'Table successfully booked' AS Message;
    END IF;
END //

DELIMITER ;