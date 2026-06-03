-- Inserting DATA INTO USERS

INSERT INTO Users(full_name, email, city, registration_date)
VALUES
('Alice Johnson', 'alice@example.com', 'New York', '2024-12-01'),
('Bob Smith', 'bob@example.com', 'Los Angeles', '2024-12-05'),
('Charlie Lee', 'charlie@example.com', 'Chicago', '2024-12-10'),
('Diana King', 'diana@example.com', 'New York', '2025-01-15'),
('Ethan Hunt', 'ethan@example.com', 'Los Angeles', '2025-02-01');

INSERT INTO Users(full_name, email, city, registration_date)
VALUES
('Frank Miller', 'frank@example.com', 'Boston', '2025-02-10');


-- Inserting DATA INTO EVENTS


INSERT INTO Events
(title, description, city, start_date, end_date, status, organizer_id)
VALUES
(
'Tech Innovators Meetup',
'A meetup for tech enthusiasts.',
'New York',
'2025-06-10 10:00:00',
'2025-06-10 16:00:00',
'upcoming',
1
),

(
'AI & ML Conference',
'Conference on AI and ML advancements.',
'Chicago',
'2025-05-15 09:00:00',
'2025-05-15 17:00:00',
'completed',
3
),

(
'Frontend Development Bootcamp',
'Hands-on training on frontend technologies.',
'Los Angeles',
'2025-07-01 10:00:00',
'2025-07-03 16:00:00',
'upcoming',
2
),
(
'Cyber Security Summit',
'Security and ethical hacking event.',
'Boston',
'2025-08-10 09:00:00',
'2025-08-10 17:00:00',
'upcoming',
1
);



-- Inserting DATA INTO SESSIONS


INSERT INTO Sessions
(event_id, title, speaker_name, start_time, end_time)
VALUES
(
1,
'Opening Keynote',
'Dr. Tech',
'2025-06-10 10:00:00',
'2025-06-10 11:00:00'
),

(
1,
'Future of Web Development',
'Alice Johnson',
'2025-06-10 11:15:00',
'2025-06-10 12:30:00'
),

(
2,
'AI in Healthcare',
'Charlie Lee',
'2025-05-15 09:30:00',
'2025-05-15 11:00:00'
),

(
3,
'Intro to HTML5',
'Bob Smith',
'2025-07-01 10:00:00',
'2025-07-01 12:00:00'
),
(
3,
'Advanced HTML5',
'Bob Smith',
'2025-07-02 01:00:00',
'2025-07-02 03:00:00'
);

-- Inserting DATA INTO REGISTRATIONS

INSERT INTO Registrations(user_id, event_id, registration_date)
VALUES
(1, 1, '2025-05-01'),
(2, 1, '2025-05-02'),
(3, 2, '2025-04-30'),
(4, 2, '2025-04-28'),
(5, 3, '2025-06-15'),
(1, 1, '2025-05-03');

-- Inserting DATA INTO FEEDBACK

INSERT INTO Feedback
(user_id, event_id, rating, comments, feedback_date)
VALUES
(3, 2, 4, 'Great insights!', '2025-05-16'),
(4, 2, 5, 'Very informative.', '2025-05-16'),
(2, 1, 3, 'Could be better.', '2025-06-11');

-- Inserting DATA INTO RESOURCES

INSERT INTO Resources
(event_id, resource_type, resource_url, uploaded_at)
VALUES
(
1,
'pdf',
'https://portal.com/resources/tech_meetup_agenda.pdf',
'2025-05-01 10:00:00'
),

(
2,
'image',
'https://portal.com/resources/ai_poster.jpg',
'2025-04-20 09:00:00'
),

(
3,
'link',
'https://portal.com/resources/html5_docs',
'2025-06-25 15:00:00'
);

-- EXERCISE 1: USER UPCOMING EVENTS

SELECT 
    u.full_name,
    e.title AS event_name,
    e.city,
    e.start_date
FROM Users u
JOIN Registrations r
    ON u.user_id = r.user_id
JOIN Events e
    ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
AND u.city = e.city
ORDER BY e.start_date;

-- EXERCISE 2: TOP RATED EVENTS

SELECT 
    e.title,
    AVG(f.rating) AS average_rating,
    COUNT(f.feedback_id) AS total_feedbacks
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(f.feedback_id) >= 10
ORDER BY average_rating DESC;

-- EXERCISE 3: INACTIVE USERS

SELECT
    u.user_id,
    u.full_name,
    u.email
FROM Users u
WHERE u.user_id NOT IN
(
    SELECT user_id
    FROM Registrations
    WHERE registration_date >= CURDATE() - INTERVAL 90 DAY
);

-- EXERCISE 4: PEAK SESSION HOURS

SELECT 
    e.title,
    COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
    AND TIME(s.start_time)
    BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.event_id, e.title;


-- EXERCISE 5: MOST ACTIVE CITIES

SELECT 
    u.city,
    COUNT(DISTINCT r.user_id) AS registration_count
FROM Users u
JOIN Registrations r
    ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY registration_count DESC
LIMIT 5;


-- EXERCISE 6: EVENT RESOURCE SUMMARY

SELECT 
    e.title,

    SUM(CASE
        WHEN r.resource_type = 'pdf' THEN 1
        ELSE 0
    END) AS pdf_count,

    SUM(CASE
        WHEN r.resource_type = 'image' THEN 1
        ELSE 0
    END) AS image_count,

    SUM(CASE
        WHEN r.resource_type = 'link' THEN 1
        ELSE 0
    END) AS link_count

FROM Events e

LEFT JOIN Resources r
    ON e.event_id = r.event_id

GROUP BY e.event_id, e.title;


-- EXERCISE 7: LOW FEEDBACK ALERTS

SELECT 
    u.full_name,
    e.title AS event_name,
    f.rating,
    f.comments
FROM Feedback f
JOIN Users u
    ON f.user_id = u.user_id
JOIN Events e
    ON f.event_id = e.event_id
WHERE f.rating < 3;


-- EXERCISE 8: SESSIONS PER UPCOMING EVENT

SELECT 
    e.title,
    COUNT(s.session_id) AS total_sessions
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;

-- EXERCISE 9: ORGANIZER EVENT SUMMARY

SELECT 
    u.full_name AS organizer_name,
    e.status,
    COUNT(e.event_id) AS total_events
FROM Users u
JOIN Events e
    ON u.user_id = e.organizer_id
GROUP BY u.full_name, e.status
ORDER BY u.full_name;


-- EXERCISE 10: FEEDBACK GAP


SELECT 
    e.title
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
LEFT JOIN Feedback f
    ON e.event_id = f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.event_id, e.title;

-- EXERCISE 11: DAILY NEW USER COUNT

SELECT 
    registration_date,
    COUNT(user_id) AS new_users
FROM Users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date
ORDER BY registration_date;

-- EXERCISE 12: EVENT WITH MAXIMUM SESSIONS

SELECT 
    e.title,
    COUNT(s.session_id) AS total_sessions
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) =
(
    SELECT MAX(session_count)
    FROM
    (
        SELECT COUNT(session_id) AS session_count
        FROM Sessions
        GROUP BY event_id
    ) AS temp_table
);

-- EXERCISE 13: AVERAGE RATING PER CITY

SELECT 
    e.city,
    AVG(f.rating) AS average_rating
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY e.city;


-- EXERCISE 14: MOST REGISTERED EVENTS

SELECT 
    e.title,
    COUNT(r.registration_id) AS total_registrations
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY total_registrations DESC
LIMIT 3;

-- EXERCISE 15: EVENT SESSION TIME CONFLICT

SELECT 
    s1.event_id,
    s1.title AS session_one,
    s2.title AS session_two,
    s1.start_time,
    s1.end_time,
    s2.start_time,
    s2.end_time

FROM Sessions s1

JOIN Sessions s2
    ON s1.event_id = s2.event_id
    AND s1.session_id < s2.session_id
    AND s1.start_time < s2.end_time
    AND s1.end_time > s2.start_time;


-- EXERCISE 16: UNREGISTERED ACTIVE USERS

SELECT 
    u.user_id,
    u.full_name
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
AND r.registration_id IS NULL;


-- EXERCISE 17: MULTI-SESSION SPEAKERS

SELECT 
    speaker_name,
    COUNT(session_id) AS total_sessions
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(session_id) > 1;

-- EXERCISE 18: RESOURCE AVAILABILITY CHECK

SELECT 
    e.title
FROM Events e
LEFT JOIN Resources r
    ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


-- EXERCISE 19: COMPLETED EVENTS (With FEEDBACK Summary)

SELECT 
    e.title,

    COUNT(DISTINCT r.registration_id)
    AS total_registrations,

    AVG(f.rating)
    AS average_feedback_rating

FROM Events e

LEFT JOIN Registrations r
    ON e.event_id = r.event_id

LEFT JOIN Feedback f
    ON e.event_id = f.event_id

WHERE e.status = 'completed'

GROUP BY e.event_id, e.title;


-- EXERCISE 20: USER ENGAGEMENT INDEX

SELECT 
    u.full_name,

    COUNT(DISTINCT r.event_id)
    AS attended_events,

    COUNT(DISTINCT f.feedback_id)
    AS feedbacks_submitted

FROM Users u

LEFT JOIN Registrations r
    ON u.user_id = r.user_id

LEFT JOIN Feedback f
    ON u.user_id = f.user_id

GROUP BY u.user_id, u.full_name;

-- EXERCISE 21: TOP FEEDBACK PROVIDERS


SELECT 
    u.full_name,
    COUNT(f.feedback_id) AS total_feedbacks
FROM Users u
JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_feedbacks DESC
LIMIT 5;

-- EXERCISE 22: DUPLICATE REGISTRATIONS CHECK

SELECT 
    user_id,
    event_id,
    COUNT(*) AS duplicate_count
FROM Registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;



-- EXERCISE 23: REGISTRATION TRENDS (month-wise)

SELECT 
    DATE_FORMAT(registration_date, '%Y-%m')
    AS registration_month,

    COUNT(registration_id)
    AS total_registrations

FROM Registrations

WHERE registration_date >= CURDATE() - INTERVAL 12 MONTH

GROUP BY DATE_FORMAT(registration_date, '%Y-%m')

ORDER BY registration_month;


-- EXERCISE 24: AVERAGE SESSION DURATION PER EVENT

SELECT 
    e.title,

    AVG(
        TIMESTAMPDIFF(
            MINUTE,
            s.start_time,
            s.end_time
        )
    ) AS average_duration_minutes

FROM Events e

JOIN Sessions s
    ON e.event_id = s.event_id

GROUP BY e.event_id, e.title;


-- EXERCISE 25: EVENTS WITHOUT SESSIONS

SELECT 
    e.title
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE s.session_id IS NULL;

-- For Verifying the TABLE DATA


SELECT * FROM Users;

SELECT * FROM Events;

SELECT * FROM Sessions;

SELECT * FROM Registrations;

SELECT * FROM Feedback;

SELECT * FROM Resources; 
