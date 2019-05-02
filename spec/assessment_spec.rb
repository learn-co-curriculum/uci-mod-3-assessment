require "spec_helper"


#

#
#     describe "#all_students_graded?" do
#
#
#     end
#
#     # Should have smartes about Floats
#     #
#     #        expected #<Fixnum:191> => 95
# #           got #<Float:197595433650880514> => 95.0
#
# #      Compared using equal?, which compares object identity,
# #      but expected and actual are not the same object. Use
# #      `expect(actual).to eq(expected)` if you don't care about
# #      object identity in this example.
#     #
#
#
#     # no mention in readme
#
#
# end


describe 'Student' do
  before(:each) do
    Student.class_variable_set(:@@all, [])
    @student = Student.new('Marisa')
    @student2 = Student.new('Ian')
    @student3 = Student.new('Sandra')
    @student4 = Student.new('Diarmuid')
    @student5 = Student.new('Cynthia')
  end

  describe 'Class Variables' do
    describe '@@all' do
      it 'is a class variable set to an array' do
        expect(Student.class_variable_get(:@@all)).to be_a(Array)
      end
    end
  end

  describe 'Initialization' do
    describe '#new' do
      it 'is initialized with an argument of a name' do
        expect { Student.new('Hank') }.to_not raise_error
      end

      it 'pushes new instances into a class variable called @@all upon initialization' do
        expect(Student.class_variable_get(:@@all)).to match([@student, @student2, @student3, @student4, @student5])
      end
    end
  end

  describe 'Class Methods' do
    describe '.all' do
      it 'is a class method that returns an array of all student instances that have been created' do
        expect(Student.all).to match([@student, @student2, @student3, @student4, @student5])
      end
    end
  end


  describe 'Attribute Accessors' do
    describe '#name ' do
      it "returns a student's name" do
        expect(@student.name).to eq('Marisa')
        expect(@student2.name).to eq('Ian')
      end

      it "can be reassigned" do
        expect(@student.name).to eq('Marisa')
        @student.name = 'Mari'
        expect(@student.name).to eq('Mari')
      end
    end

    describe '#course' do
      it "is set to `nil` initially" do
        expect(@student.course).to eq(nil)
        expect(@student2.course).to eq(nil)
      end

      it "returns a student's course once assigned" do
        history = Course.new('History')
        @student.course = history
        expect(@student.course).to eq(history)
      end
    end

    describe '#grade' do
      it "is set to `nil` initially" do
        expect(@student.grade).to eq(nil)
        expect(@student2.grade).to eq(nil)
      end

      it "returns a student's grade once assigned" do
        @student.grade = 100
        expect(@student.grade).to eq(100)
      end
    end
  end

  describe 'Instance Methods' do
    describe '#has_grade?' do
      it 'checks if student has received a grade, returns true if student has a grade, false if not' do
        expect(@student.has_grade?).to eq(false)
        @student.grade = 90
        expect(@student.has_grade?).to eq(true)
      end
    end
  end
end

describe 'Course' do
  before(:each) do
    Course.class_variable_set(:@@all, [])
    @course = Course.new('Spanish 101')
    @course2 = Course.new('Spanish 201: Basic Conversation')
    @course3 = Course.new('Spanish 301: Natural Dialogue')
  end

  describe 'Class Variables' do
    describe '@@all' do
      it 'is a class variable set to an array' do
        expect(Course.class_variable_get(:@@all)).to be_a(Array)
      end
    end
  end

  describe 'Initialization' do
    describe '#new' do
      it 'is initialized with an argument of a name' do
        expect { Course.new('Spanish 202: Summer Review') }.to_not raise_error
      end

      it 'pushes new instances into a class variable called @@all upon initialization' do
        expect(Course.class_variable_get(:@@all)).to match([@course, @course2, @course3])
      end
    end
  end

  describe 'Class Methods' do
    describe '.all' do
      it 'is a class method that returns an array of all course instances that have been created' do
        expect(Course.all).to match([@course, @course2, @course3])
      end
    end
  end


  describe 'Attribute Accessors' do
    describe '#name ' do
      it "returns the name of a course" do
        expect(@course.name).to eq('Spanish 101')
        expect(@course2.name).to eq('Spanish 201: Basic Conversation')
      end

      it "can be reassigned" do
        expect(@course3.name).to eq('Spanish 301: Natural Dialogue')
        @course3.name = 'Spanish 301: Speaking Naturally'
        expect(@course3.name).to eq('Spanish 301: Speaking Naturally')
      end
    end
  end

  describe 'Instance Methods' do
    describe '#enroll_student' do
      it 'takes in a student instance and assigns that student a course' do
        amy = Student.new("Amy")
        @course.enroll_student(amy)
        expect(amy.course).to eq(@course)
      end
    end

    describe '#enroll_student_by_name' do
      it 'takes in a student name, creates a student instance, and enrolls that student' do
        @course.enroll_student_by_name("Julia")
        expect(@course.students.last.name).to eq("Julia")
        expect(@course.students.last.course).to eq(@course)
      end
    end

    describe '#add_grade' do
      it "takes in two arguments, a student instance and an integer grade, sets the student's grade" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(student.grade).to be(90)
        expect(student2.grade).to be(100)
      end
    end

    describe '#students' do
      it "returns an empty array if no students are enrolled in a course" do
        expect(@course.students).to match([])
      end

      it "returns an array of all students who are enrolled in a course" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        student3 = Student.new('Mike')
        student4 = Student.new('Matt')

        @course.enroll_student(student)
        @course.enroll_student(student2)
        @course2.enroll_student(student3)

        expect(@course.students).to match([student, student2])
        expect(@course2.students).to match([student3])
      end
    end

    describe '#all_existing_grades' do
      it "returns a collection of all added grades and ignores any ungraded students" do
         student = Student.new('Nadia')
         student2 = Student.new('Liz')

         @course.enroll_student(student)
         @course.enroll_student(student2)
         @course.add_grade(student, 90)
         @course.add_grade(student2, 100)

         expect(@course.all_existing_grades).to match([90,100])
         student3 = Student.new('Enzha')
         expect(@course.all_existing_grades).to match([90,100])
       end
    end

    describe "#all_students_graded?" do

      it "returns true if all enrolled students have been assigned grades" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.enroll_student(student)
        @course.enroll_student(student2)
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(@course.all_students_graded?).to be(true)
      end

      it "returns false if some enrolled students have yet to receive grades" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.enroll_student(student)
        @course.enroll_student(student2)
        @course.add_grade(student, 90)
        expect(@course.all_students_graded?).to be(false)
      end

      it "returns false if there are no students enrolled in the course" do
        expect(@course.all_students_graded?).to be(false)
        expect(@course2.all_students_graded?).to be(false)
        expect(@course3.all_students_graded?).to be(false)
      end
    end

    describe "#average_grade" do
      it "returns an average of all student grades in the class if grading is finished" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.enroll_student(student)
        @course.enroll_student(student2)
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(@course.average_grade).to be(95)
      end

      it "returns 'Grading still in progress.' if grading is not finished" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.enroll_student(student)
        @course.enroll_student(student2)
        expect(@course.average_grade).to eq('Grading still in progress.')
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(@course.average_grade).to be(95)
        @course.enroll_student_by_name('Harold')
        expect(@course.average_grade).to eq('Grading still in progress.')
      end
    end
  end


end



#

#
#   def average_grade
#     if all_students_graded?
#       grades.reduce(:+) / self.students.length
#     else
#        'Grading still in progress.'
#     end
#   end
#
#   def grades
#     self.students.map(&:grade)
#   end
#
#   def print_grades
#     puts students.reduce(""){ |memo, s| memo += "#{s.name}: #{s.grade}\n" }
#   end
# end
