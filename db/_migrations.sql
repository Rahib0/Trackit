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