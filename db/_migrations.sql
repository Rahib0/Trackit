DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id serial PRIMARY KEY,
    username VARCHAR(25) NOT NULL
)

