CREATE TABLE users (
	id INTEGER PRIMARY KEY
, fname VARCHAR(64) NOT NULL
, lname VARCHAR(64) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY
, title VARCHAR(255) NOT NULL
, body TEXT
, user_id INTEGER NOT NULL
, FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY
,	user_id INTEGER NOT NULL
,	question_id INTEGER NOT NULL
, FOREIGN KEY(user_id) REFERENCES users(id)
, FOREIGN KEY(question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY
,	question_id INTEGER NOT NULL
,	parent_id INTEGER
, user_id INTEGER NOT NULL
, body TEXT
, FOREIGN KEY(question_id) REFERENCES questions(id)
, FOREIGN KEY(parent_id) REFERENCES replies(id)
, FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE question_likes (
	id INTEGER PRIMARY KEY
, user_id INTEGER NOT NULL
, question_id INTEGER NOT NULL
, FOREIGN KEY(user_id) REFERENCES users(id)
, FOREIGN KEY(question_id) REFERENCES questions(id)
);


INSERT INTO users (fname, lname)
	VALUES ('ruth', 'thompson'), ('matt', 'hilty');

INSERT INTO questions (title, body, user_id)
	VALUES ('whats this?', 'theres something on the bottom of my shoe. What is it?', 1),
				 ('What should my question be?', NULL, 2);

INSERT INTO replies (question_id, parent_id, body, user_id)
  VALUES (1, NULL, 'I dont know what that is.', 1), (2, 1, 'Thats gross.', 2);

INSERT INTO question_followers (user_id, question_id)
VALUES ( 1, 2 ) ;