----------------------------------------------------
--------------------| TASK 1 |----------------------
----------------------------------------------------

INSERT INTO `LittleLemonDB`.`Bookings` (TableNumber, BookingDate, CustomerID) VALUES
(5, '2022-10-10', 1),
(3, '2022-11-13', 3),
(2, '2022-10-11', 2),
(2, '2022-10-13', 1);

----------------------------------------------------
--------------------| TASK 2 |----------------------
----------------------------------------------------
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
call CheckBooking("2022-10-12", 3);


----------------------------------------------------
--------------------| TASK 3 |----------------------
----------------------------------------------------

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN date DATE, IN table_no INT, IN customer_id INT)
BEGIN
    
    DECLARE booking_status VARCHAR(50);

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
        SELECT CONCAT('Table ',table_no,' is already booked - booking cancelled.') AS 'Booking Status';
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID) VALUES (date, table_no, customer_id);
        COMMIT;
        SELECT 'Table successfully booked!' AS 'Booking Status';
    END IF;
END //

DELIMITER ;

call AddValidBooking("2022-10-11", 4, 4);
-- DROP PROCEDURE AddValidBooking;