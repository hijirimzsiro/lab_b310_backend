-- 切換資料庫
USE lab_b310;

-- 建立 Students 表
CREATE TABLE IF NOT EXISTS Students (
    student_id VARCHAR(10) PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 建立 Seats 表
CREATE TABLE IF NOT EXISTS Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    row_label CHAR(1),
    seat_number INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 建立 Timeslots 表
CREATE TABLE IF NOT EXISTS Timeslots (
    timeslot_id INT PRIMARY KEY AUTO_INCREMENT,
    start_time TIME,
    end_time TIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 建立 Reservations 表
CREATE TABLE IF NOT EXISTS Reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(10),
    seat_id INT,
    timeslot_id INT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (timeslot_id) REFERENCES Timeslots(timeslot_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    UNIQUE KEY unique_seat_timeslot (seat_id, timeslot_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;