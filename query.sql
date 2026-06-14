-- Active: 1747667236987@@127.0.0.1@5432@postgres
-- Create table for users
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (
        role IN (
            'Football Fan',
            'Ticket Manager'
        )
    ),
    phone_number VARCHAR(20)
);

--create table for matches
CREATE TABLE Matches (
    match_id int PRIMARY KEY,
    fixture varchar(150) NOT NULL,
    tournament_category varchar(100) NOT NULL,
    base_ticket_price numeric(10, 2) NOT NULL CHECK (base_ticket_price >= 0),
    match_status varchar(20) NOT NULL CHECK (
        match_status IN (
            'Available',
            'Selling Fast',
            'Sold Out',
            'Postponed'
        )
    )
);

-- create table for bookings

CREATE TABLE Bookings (
  booking_id int PRIMARY KEY,
  user_id int NOT NULL,
  match_id int NOT NULL,
  seat_number varchar(20),
  payment_status varchar(20) CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost numeric(10, 2) NOT NULL CHECK (total_cost >= 0),
  CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES Users (user_id),
  CONSTRAINT fk_booking_match FOREIGN KEY (match_id) REFERENCES Matches (match_id)
);