# UCI Mod 3 Assessment

## Introduction

In this assessment, you will be building a tool for helping teachers organize
the courses they teach and the students in each. As this is designed from a
teacher's perspective, a course has many students, and each student belongs to
a specific course (though we know you may actually be taking multiple courses).

Your task is to build a set of collaborating Ruby objects, one to handle
instances of `Course`s and one to handle `Student`s. Write your solution in
`lib/oo_course_domain.rb` following the instructions below.

## Instructions

### Student Class

#### `@@all` Class Variable

- Create an `@@all` class variable set to an array.
- Write a `.all` class method that returns an array of all student instances
  that have been created.

#### Initializing Student Instances

Student instances should be initialized with an argument of a `name`. On
initialization, the new student instance should be pushed into the `@@all` class
variable.

#### Attribute Accessors

Students instances should have `name`, `course` and `grade` accessors. Since we
have only assigned `name` when initializing, `course` and `grade` by default
should return `nil` until they are assigned.

### Course Class

#### `@@all` Class Variable

- Create an `@@all` class variable set to an array.
- Write a `.all` class method that returns an array of all course instances
  that have been created.

#### Initializing Course Instances

Course instances should be initialized with an argument of a `name`. On
initialization, the new course instance should be pushed into the `@@all` class
variable.

#### Attribute Accessors

Course instances should have a `name` attribute accessor.

#### `add_student`

Write an `#add_student` instance method that takes in a student instance as an
argument and associates that student with the course. It should do this by
telling the student that it belongs to this particular course.

#### `#students`

Write a `#students` instance method that returns a collection of student
instances unique to the course instance.

#### `#add_student_by_name`

Write an `#add_student_by_name` instance method that takes in a student name as a
string, creates a new student instance, and associates that student with the
course instance.

#### `.student_count`

Write a `.student_count` **class** method that returns the total number of all
students in all class instances.

#### `#add_grade`

Write an `#add_grade` instance method that takes in two arguments, a student
instance and an integer grade, then sets the student's grade using the student's
`grade` attribute accessor.

#### `#all_existing_grades`

Write an `#all_existing_grades` method that returns a collection of all added
grades, ignoring any ungraded students.

#### `#all_students_graded?`

Write an `#all_students_graded?` method that checks if there are students
enrolled in the course. If so, it returns true if all students have grades, or
false if some students have not been given grades yet.

#### `#average_grade`

Write an `#average_grade` method that does one of two things:

- if grading is finished, returns an average of all student grades. To calculate average, add all values together and divide by the number of values
- if grading is not finished, returns a string 'Grading still in progress.'
