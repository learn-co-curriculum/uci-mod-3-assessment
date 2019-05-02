class Student
  @@all = []

  def self.all
    @@all
  end

  attr_accessor :name, :course, :grade

  def initialize(name)
    @name = name
    @course = nil
    @grade = nil
    @@all << self
  end

  def has_grade?
    !@grade.nil?
  end
end

class Course
  @@all = []

  def self.all
    @@all
  end

  attr_accessor :name

  def initialize(name)
    @name = name
    @@all.push(self)
  end

  def enroll_student(s)
    s.course = self
  end

  def enroll_student_by_name(name)
    s = Student.new(name)
    enroll_student(s)
  end

  def students
    Student.all.select{|student| student.course === self}
  end

  def add_grade(s, gradeInt)
    s.grade = gradeInt
  end

  def all_existing_grades
    self.students.select(&:has_grade?).map(&:grade)
  end

  def all_students_graded?
    return false if self.students.length == 0
    return self.students.all?(&:has_grade?)
  end

  def average_grade
    if all_students_graded?
      grades.reduce(:+) / self.students.length
    else
       'Grading still in progress.'
    end
  end

  def grades
    self.students.map(&:grade)
  end

  def print_grades
    puts students.reduce(""){ |memo, s| memo += "#{s.name}: #{s.grade}\n" }
  end
end
