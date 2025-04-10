CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(255),
    join_date DATE,
    membership_status BOOLEAN -- TRUE if active, FALSE if inactive
);

CREATE TABLE trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_name VARCHAR(255),
    specialization VARCHAR(255)
);

CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(255),
    description TEXT,
    trainer_id INT,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);

CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    class_date DATE,
    start_time TIME,
    end_time TIME,
    max_capacity INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    schedule_id INT,
    attendance_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
);

INSERT INTO members (member_name, join_date, membership_status) VALUES
    ('Alice Johnson', '2024-01-15', TRUE),
    ('Bob Smith', '2024-02-20', TRUE),
    ('Charlie Davis', '2024-03-25', TRUE),
    ('Diana Green', '2024-04-10', FALSE);

INSERT INTO trainers (trainer_name, specialization) VALUES
    ('John Doe', 'Yoga'),
    ('Jane Smith', 'Strength Training'),
    ('Tom Brown', 'Cardio'),
    ('Emily White', 'Pilates');

INSERT INTO classes (class_name, description, trainer_id) VALUES
    ('Morning Yoga', 'A calming start to your day with yoga.', 1),
    ('Strength Training Basics', 'Learn the fundamentals of strength training.', 2),
    ('Cardio Blast', 'High-intensity cardio workout.', 3),
    ('Pilates Core', 'Strengthen your core with Pilates.', 4);

INSERT INTO schedules (class_id, class_date, start_time, end_time, max_capacity) VALUES
    (1, '2024-11-15', '07:00:00', '08:00:00', 15),
    (2, '2024-11-15', '09:00:00', '10:00:00', 20),
    (3, '2024-11-15', '17:00:00', '18:00:00', 25),
    (4, '2024-11-16', '10:00:00', '11:00:00', 10);

INSERT INTO attendance (member_id, schedule_id, attendance_date) VALUES
    (1, 1, '2024-11-15'),
    (2, 1, '2024-11-15'),
    (3, 2, '2024-11-15'),
    (1, 3, '2024-11-15'),
    (2, 4, '2024-11-16');

SELECT 
    c.class_name, 
    s.class_date, 
    s.start_time, 
    s.end_time, 
    (s.max_capacity - COUNT(a.attendance_id)) AS available_spots
FROM 
    schedules s
JOIN 
    classes c ON s.class_id = c.class_id
LEFT JOIN 
    attendance a ON s.schedule_id = a.schedule_id
GROUP BY 
    s.schedule_id
HAVING 
    available_spots > 0;

SELECT 
    m.member_name,
    c.class_name,
    s.class_date,
    s.start_time,
    s.end_time
FROM 
    members m
JOIN 
    attendance a ON m.member_id = a.member_id
JOIN 
    schedules s ON a.schedule_id = s.schedule_id
JOIN 
    classes c ON s.class_id = c.class_id
WHERE 
    m.member_id = 2;


SELECT 
    t.trainer_name,
    t.specialization,
    COUNT(a.attendance_id) AS total_attendance,
    COUNT(DISTINCT s.schedule_id) AS total_classes,
    (COUNT(a.attendance_id) / COUNT(DISTINCT s.schedule_id)) AS avg_attendance_per_class
FROM 
    trainers t
JOIN 
    classes c ON t.trainer_id = c.trainer_id
JOIN 
    schedules s ON c.class_id = s.class_id
LEFT JOIN 
    attendance a ON s.schedule_id = a.schedule_id
GROUP BY 
    t.trainer_id;

