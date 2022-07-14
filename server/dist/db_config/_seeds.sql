DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(25) NOT NULL
);

DROP TABLE IF EXISTS splits CASCADE;

CREATE TABLE splits (
    split_id INTEGER PRIMARY KEY,
    split VARCHAR(20) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS exercises CASCADE;

CREATE TABLE exercises (
    exercise_id SERIAL PRIMARY KEY,
    exercise_name VARCHAR(30) NOT NULL,
    split_id INTEGER,
    FOREIGN KEY(split_id)
        REFERENCES splits(split_id)
);

DROP TABLE IF EXISTS demos CASCADE;

CREATE TABLE demos (
    demo_id SERIAL PRIMARY KEY,
    demo_url VARCHAR(10000) NOT NULL,
    exercise_id INTEGER,
    FOREIGN KEY(exercise_id)
        REFERENCES exercises(exercise_id)
);

DROP TABLE IF EXISTS targets CASCADE;

CREATE TABLE targets (
    target_id SERIAL PRIMARY KEY,
    exercise_id INTEGER,
    user_id INTEGER,
    target_sets INTEGER,
    target_reps INTEGER,
    target_duration_seconds INTEGER DEFAULT NULL,
    target_distance_km INTEGER DEFAULT NULL,
    target_made_date DATE DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'utc'),
    FOREIGN KEY(exercise_id)
        REFERENCES exercises(exercise_id),
    FOREIGN KEY(user_id)
        REFERENCES users(user_id)
        ON DELETE SET NULL
);

DROP TABLE IF EXISTS days CASCADE;

CREATE TABLE days(
    day_id integer PRIMARY KEY,
    day VARCHAR(10) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS schedule CASCADE;

CREATE TABLE schedule (
    schedule_id SERIAL PRIMARY KEY,
    user_id integer,
    exercise_id integer,
    day_id integer,
    FOREIGN KEY(user_id)
        REFERENCES users(user_id),
    FOREIGN KEY(exercise_id)
        REFERENCES exercises(exercise_id),
    FOREIGN KEY(day_id)
        REFERENCES days(day_id)
);

DROP TABLE IF EXISTS record_ratings CASCADE;

CREATE TABLE record_ratings (
    record_rating_id INTEGER PRIMARY KEY,
    record_rating VARCHAR(25)
);

DROP TABLE IF EXISTS records CASCADE;

CREATE TABLE records (
    record_id SERIAL PRIMARY KEY,
    user_id integer,
    record_rating_id INTEGER,
    record_date DATE DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'utc'),
    FOREIGN KEY(user_id)
        REFERENCES users(user_id),
    FOREIGN KEY(record_rating_id)
        REFERENCES record_ratings(record_rating_id)
);

INSERT INTO record_ratings (record_rating_id, record_rating)
VALUES
    (1, 'Excellent'),
    (2, 'Good'),
    (3, 'Average'),
    (4, 'Below Average'),
    (5, 'Bad');


INSERT INTO splits (split_id, split)
VALUES
    (1, 'Push'),
    (2, 'Pull'),
    (3, 'Legs'),
    (4, 'Core'),
    (5, 'Cardio');

INSERT INTO days (day_id, day)
VALUES
    (1, 'Monday'),
    (2, 'Tuesday'),
    (3, 'Wednesday'),
    (4, 'Thursday'),
    (5, 'Friday'),
    (6, 'Saturday'),
    (7, 'Sunday');

INSERT INTO users (username)
VALUES 
    ('Jeff'),
    ('Bob');

INSERT INTO exercises (exercise_id, exercise_name, split_id)
VALUES
    (1, 'Push Ups', 1),
    (2, 'Pull Ups', 2),
    (3, 'Squats', 3),
    (4, 'Elbow Plank', 4),
    (5, 'Tricep Extension', 1),
    (6, 'Chin ups', 2),
    (7, 'Pistol Squats', 3),
    (8, 'Side Elbow Plank', 4),
    (9, 'Jogging', 5);

INSERT INTO demos (exercise_id, demo_url)
VALUES
    (1, 'https://www.fitnesseducation.edu.au/wp-content/uploads/2017/03/Pushups.jpg'),
    (1, 'https://miro.medium.com/max/645/1*WZmDgcJO40Va5mVgdfbz7g@2x.jpeg'),
    (2, 'https://fitnessvolt.com/wp-content/uploads/2019/04/pull-up.jpg');

INSERT INTO targets (user_id, exercise_id, target_sets, target_reps, target_duration_seconds, target_distance_km)
VALUES
    (1, 1, 4, 15, NULL, NULL),
    (1, 2, 4, 4, NULL, NULL),
    (2, 3, 4, 8, NULL, NULL),
    (1, 8, 4, NULL, 45, NULL),
    (2, 9, NULL, NULL, NULL, 4);

INSERT INTO schedule (user_id, exercise_id, day_id)
VALUES
    (1, 1, 1),
    (1, 2, 1),
    (1, 3, 1),
    (1, 5, 3),
    (1, 6, 3),
    (1, 7, 3),
    (1, 1, 5),
    (1, 2, 5),
    (1, 3, 5);

INSERT INTO records (user_id, record_rating_id, record_date)
VALUES
    (1, 1, 2022-07-11),
    (1, 2, 2022-07-12),
    (1, 2, 2022-07-13),
    (1, 3, 2022-07-14);