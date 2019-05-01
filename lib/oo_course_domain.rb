 require 'byebug'
# Write your Student and Course classes here
#
class Student
  @@all = []

  def self.all
    @@all
  end

  def self.add_student(s)
    @@all.push(s)
  end

  attr_reader :name
  attr_accessor :course, :grade

  def initialize(name)
    @name = name
    @course = nil
    @grade = nil
    Student.add_student(self)
  end

  def has_grade?
    !@grade.nil?
  end

  def enroll_in_course(c)
    @course = c
  end

  def setGrade(n)
    @grade = n
  end
end

class Course
  @@all = []

  def self.all
    @@all
  end

  def self.add_course(c)
    @@all.push(c)
  end

  def self.student_count
    @@all.length
  end

  attr_accessor :name
  attr_reader :students

  def initialize(name)
    @name = name
    @students = []
    self.class.add_course(self)
  end

  def add_student(s)
    s.enroll_in_course(self)
    @students.push(s)
  end

  def add_student_by_name(name)
    s = Student.new(name)
    add_student(s)
  end

  def add_grade(s, gradeInt)
    s.setGrade(gradeInt)
  end

  def all_existing_grades
    @students.select(&:has_grade?).map(&:grade)
  end

  def all_students_graded?
    return false if @students.length == 0
    return @students.all?(&:has_grade?)
  end

  def average_grade
    if all_students_graded?
      grades.reduce(:+) / @students.length
    else
       'Grading still in progress.'
    end
  end

  def grades
    @students.map(&:grade)
  end

  def print_grades
    puts students.reduce(""){ |memo, s| memo += "#{s.name}: #{s.grade}\n" }
  end
end
