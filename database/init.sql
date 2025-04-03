CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    photo_url TEXT,
    description TEXT,
    address TEXT,
    phone TEXT,
    permissions INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ratings (
    id SERIAL PRIMARY KEY,
    grade INTEGER NOT NULL,
    reporter_user_id INTEGER NOT NULL,
    reported_user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reporter_user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (reported_user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    photo_url TEXT,
    name TEXT NOT NULL,
    breed TEXT,
    age INTEGER,
    description TEXT,
    owner_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS complaints (
    id SERIAL PRIMARY KEY,
    reporter_user_id INTEGER NOT NULL,
    reported_post_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    reason TEXT,
    FOREIGN KEY (reporter_user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (reported_post_id) REFERENCES posts (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE,
    UNIQUE(user_id, post_id) 
);

INSERT INTO users (name, email, password, photo_url, description, address, phone, permissions)
VALUES
    ('Juan Botelho', 'juan@mail.com', '$2b$10$HRAqlhysuyI6369777gzWuIQOPJvylJqZOA0gFyb8M/4fwkY7qgHy', 'https://github.com/juancoelhoo.png', 'Descricao 2', 'Rua Dois, 359 - BH', '31 98765-4321', 1),
    ('Rafael Schimidt', 'rafael@mail.com', '$2b$10$HRAqlhysuyI6369777gzWuIQOPJvylJqZOA0gFyb8M/4fwkY7qgHy', 'https://github.com/rafaelchimicatti.png', 'Descricao 4', 'Rua Quatro, 981 - BH', '31 98765-4321', 0);

INSERT INTO posts (photo_url, name, breed, age, description, owner_id, created_at)
VALUES
    ('https://i.imgur.com/XjGncoV.jpeg', 'Darth Vader', 'Rotweiller', 7, 'Cão de guarda', 1, '2015-05-22 02:03:04'),
    ('https://i.imgur.com/z9sCEqU.jpeg', 'Totó', 'Shithzu', 1, 'Bravo, mas dócil', 2, '2016-01-10 02:03:04'),
INSERT INTO ratings (grade, reporter_user_id, reported_user_id)
VALUES
    (3, 1, 2),
    (4, 2, 1),


INSERT INTO complaints (reporter_user_id, reported_post_id, reason, created_at)
VALUES
    (2, 1, 'Achei ofensivo', '2016-05-22 02:33:25'),
    (1, 2, 'Escrito tudo errado', '2019-05-22 07:03:04'),

