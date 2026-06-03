--Creating Tables:
-- TABLE 1: USERS

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL
);

-- TABLE 2: EVENTS

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    city VARCHAR(100) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    status ENUM('upcoming', 'completed', 'cancelled') NOT NULL,
    organizer_id INT,

    FOREIGN KEY (organizer_id)
    REFERENCES Users(user_id)
);

-- TABLE 3: SESSIONS

CREATE TABLE Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    title VARCHAR(200) NOT NULL,
    speaker_name VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,

    FOREIGN KEY (event_id)
    REFERENCES Events(event_id)
);

-- TABLE 4: REGISTRATIONS

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    registration_date DATE NOT NULL,

    FOREIGN KEY (user_id)
    REFERENCES Users(user_id),

    FOREIGN KEY (event_id)
    REFERENCES Events(event_id)
);

-- TABLE 5: FEEDBACK

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE NOT NULL,

    FOREIGN KEY (user_id)
    REFERENCES Users(user_id),

    FOREIGN KEY (event_id)
    REFERENCES Events(event_id)
);

-- TABLE 6: RESOURCES

CREATE TABLE Resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    resource_type ENUM('pdf', 'image', 'link'),
    resource_url VARCHAR(255) NOT NULL,
    uploaded_at DATETIME NOT NULL,

    FOREIGN KEY (event_id)
    REFERENCES Events(event_id)
);