-- Create database
CREATE DATABASE IF NOT EXISTS studentdb;

USE studentdb;

-- Create table for questions
CREATE TABLE IF NOT EXISTS questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  option1 VARCHAR(255) NOT NULL,
  option1_is_correct TINYINT(1) NOT NULL,
  option2 VARCHAR(255) NOT NULL,
  option2_is_correct TINYINT(1) NOT NULL,
  option3 VARCHAR(255) NOT NULL,
  option3_is_correct TINYINT(1) NOT NULL,
  option4 VARCHAR(255) NOT NULL,
  option4_is_correct TINYINT(1) NOT NULL
);

-- Example questions
INSERT INTO questions (title, option1, option1_is_correct, option2, option2_is_correct, option3, option3_is_correct, option4, option4_is_correct)
VALUES 
('What is Flutter?', 'A UI toolkit', 1, 'A programming language', 0, 'A database', 0, 'A cloud service', 0),
('Which language does Flutter use?', 'Java', 0, 'Dart', 1, 'Python', 0, 'C++', 0);
