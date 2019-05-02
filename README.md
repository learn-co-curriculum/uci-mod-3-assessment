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

#### Class Variables

##### `@@all`

Create an `@@all` class variable set to an array.

#### Initialization

##### `#new`

Initialize student instances with a string name. On initialization, the new
student instance should be pushed into the `@@all` class variable.

#### Class Methods

##### `.all`

Write a `.all` class method that returns this variable. This variable will be
used to contain all student instances that have been created.

#### Attribute Accessors

Students instances should have `name`, `course` and `grade` accessors. Since we
have only assigned `name` when initializing, `course` and `grade` by default
should return `nil` until they are assigned.

#### Instance Methods

##### `#has_grade?`

Write a `has_grade?` method that checks if the student's grade is assigned or is
still the default `nil`. Return true if student has a grade, false if not.

### Course

#### Class Variables

##### `@@all`

Create an `@@all` class variable set to an array.

#### Initialization

##### `#new`

Course instances should be initialized with a `name` argument. On
initialization, the new course instance should be pushed into the `@@all` class
variable.

#### Class Methods

##### `.all`

Write a `.all` class method that returns an array of all course instances that
have been created.

#### Attribute Accessors

Course instances should have a `name` attribute accessor.

#### Instance Methods

##### `#enroll_student`

Write an `#enroll_student` instance method that takes in a student instance as
an argument and associates that student with the course. It should do this by
telling the student that it belongs to this particular course.

##### `#enroll_student_by_name`

Write an `#enroll_student_by_name` instance method that takes in a student name
as a string, creates a new student instance, and associates that student with
the course instance.

##### `#add_grade`

Write an `#add_grade` instance method that takes two arguments, a student instance and an
Integer grade, and sets the student's grade.

##### `#students`

Write a `#students` instance method that returns a collection of student
instances that are enrolled in a course.

##### `#all_existing_grades`

Write an `#all_existing_grades` instance method that returns a collection of all
grades, leaving out any ungraded students.

##### `#all_students_graded?`

Write an `#all_students_graded?` instance method that does one of three things:

- Returns true if all enrolled students have been assigned grades
- Returns false if some enrolled students have yet to receive grades
- Returns false if there are no students enrolled in the course

##### `#average_grade`

Write an `#average_grade` method that does one of two things:

- if grading is finished, returns an average of all student grades. To calculate average, add all values together and divide by the number of values
- if grading is not finished, returns a string 'Grading still in progress.'
