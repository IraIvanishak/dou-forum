CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE topics (
    topic_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    created_by INTEGER REFERENCES users(user_id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE,
    is_deleted BOOLEAN DEFAULT FALSE,
    content TEXT NOT NULL
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
    comment_id INTEGER REFERENCES comments(comment_id),
    liked_by INTEGER REFERENCES users(user_id),
    liked_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE last_read_comments (
    user_id INTEGER REFERENCES users(user_id),
    comment_id INTEGER REFERENCES comments(comment_id),
    topic_id INTEGER REFERENCES topics(topic_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, comment_id)
);
