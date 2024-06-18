----------------------------------------------------
--------------------| TASK 1 |----------------------
----------------------------------------------------
CREATE PROCEDURE AddBooking (
    IN booking_id INT,
    IN customer_id INT,
    IN booking_date DATE,
    IN table_no INT,
)
BEGIN
    
    DECLARE booking_status VARCHAR(50);

    START TRANSACTION;

    SELECT 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM Bookings 
                WHERE booking_date = BookingDate and table_no = TableNumber
            )
        THEN 'Table is already booked'
        ELSE 'Table is available'
    END INTO booking_status;

    IF booking_status = 'Table is already booked' THEN 
        ROLLBACK;
        SELECT CONCAT('Table ',table_no,' is already booked - booking cancelled.') AS 'Confirmation';
    ELSE
        INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID) VALUES (booking_id, booking_date, table_no, customer_id);
        COMMIT;
        SELECT 'New booking added!' AS 'Confirmation';
    END IF;
END //

DELIMITER ;

----------------------------------------------------
--------------------| TASK 2 |----------------------
----------------------------------------------------

DELIMITER //

CREATE PROCEDURE UpdateBooking (
    IN booking_id INT,
    IN booking_date DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = booking_date
    WHERE BookingID = booking_id;
    SELECT CONCAT('Booking ',booking_id,' updated.') AS 'Confirmation';
END //

DELIMITER ;

----------------------------------------------------
--------------------| TASK 3 |----------------------
----------------------------------------------------


DELIMITER //

CREATE PROCEDURE CancelBooking (
    IN booking_id INT
)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = booking_id;
    SELECT CONCAT('Booking ',booking_id,' canceled.') AS 'Confirmation';
END //

DELIMITER ;
