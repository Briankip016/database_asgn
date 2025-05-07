-- Create the database
CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;  

-- Create the Students table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- Create the Courses table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

-- Create the Enrollments table (Many-to-Many relationship between Students and Courses)
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    grade CHAR(2),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE(student_id, course_id) -- Ensures a student cannot enroll in the same course twice
);

-- Create the Instructors table
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
);

-- Create the CourseAssignments table (1-to-Many relationship between Instructors and Courses)
CREATE TABLE CourseAssignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    instructor_id INT NOT NULL,
    course_id INT NOT NULL,
    assigned_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_instructor FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE,
    CONSTRAINT fk_course_assignment FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE(instructor_id, course_id) -- Ensures an instructor cannot be assigned to the same course multiple times
);
