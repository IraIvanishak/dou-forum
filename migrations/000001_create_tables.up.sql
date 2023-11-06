CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash CHAR(64) NOT NULL, 
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE topics (
    topic_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    topic_id INTEGER REFERENCES topics(topic_id) ON DELETE CASCADE,
    parent_comment_id INTEGER REFERENCES comments(comment_id),
    user_id INTEGER REFERENCES users(user_id),
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE likes (
    like_id SERIAL PRIMARY KEY,
    comment_id INTEGER REFERENCES comments(comment_id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE last_read_comments (
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments(comment_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, comment_id)
);

CREATE TABLE last_checked_notifications (
    user_id INTEGER PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    last_checked TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);