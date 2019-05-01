class Student
  attr_accessor :name, :course, :grade

  @@all = []

  def initialize(name)
    @name = name
    @grade = nil
    @@all << self
  end

  def self.all
    @@all
  end
end

class Course
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def add_student(student)
    student.course = self
  end

  def students
    Student.all.select {|student| student.course == self}
  end

  def add_student_by_name(student_name_string)
    student = Student.new(student_name_string)
    student.course = self
  end

  def self.student_count
      Student.all.count
  end

  def add_grade(student, grade)
    student.grade = grade
  end

  def all_existing_grades
    self.students.select{|student| student.grade != nil }.map{|student| student.grade}
  end

  def all_students_graded?
    all_existing_grades.length > 0 && all_existing_grades.length == self.students.length
  end

  def average_grade
    if all_students_graded?
      (students.map{|student| student.grade }.inject{|sum, n| sum + n }) / ( students.length)
    else
      'Grading still in progress.'
    end
  end

  def print_grades
    students.each{|student| puts student.name + ": " + student.grade.to_s }
  end

  def self.student_count
      Student.all.count
  end
end
