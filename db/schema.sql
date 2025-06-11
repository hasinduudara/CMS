CREATE DATABASE cms_db;
USE cms_db;

CREATE TABLE users (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       username VARCHAR(50) UNIQUE,
                       password VARCHAR(255),
                       role ENUM('EMPLOYEE', 'ADMIN')
);

CREATE TABLE complaints (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            user_id INT,
                            title VARCHAR(100),
                            description TEXT,
                            status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED') DEFAULT 'PENDING',
                            remark TEXT,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
