require "spec_helper"

describe 'Student' do
  before(:each) do
    Student.class_variable_set(:@@all, [])
    @student = Student.new('Marisa')
    @student2 = Student.new('Ian')
    @student3 = Student.new('Sandra')
    @student4 = Student.new('Diarmuid')
    @student5 = Student.new('Cynthia')
  end

  describe '@@all' do
    it 'is a class variable set to an array' do
      expect(Student.class_variable_get(:@@all)).to be_a(Array)
    end
  end

  describe '#new' do
    it 'is initialized with an argument of a name' do
      expect { Student.new('Jackie') }.to_not raise_error
    end

    it 'pushes new instances into a class variable called @@all upon initialization' do
      expect(Student.class_variable_get(:@@all)).to match([@student, @student2, @student3, @student4, @student5])
    end
  end

  describe '.all' do
    it 'is a class method that returns an array of all student instances that have been created' do
      expect(Student.all).to match([@student, @student2, @student3, @student4, @student5])
    end
  end

  describe '#name' do
    it 'has a name' do
      expect(@student.name).to eq('Marisa')
      expect(@student2.name).to eq('Ian')
    end
  end

  describe '#course' do
    it 'belongs to a course' do
      history = Course.new('History')
      @student.course = history
      expect(@student.course).to eq(history)
    end
  end

  describe '#grade' do
    it 'can have a grade' do
      expect(@student.grade).to eq(nil)
      @student.grade = 90
      expect(@student.grade).to eq(90)
    end
  end
end

describe "Course" do
    before(:each) do
      Student.class_variable_set(:@@all, [])
      Course.class_variable_set(:@@all,[])
      @course = Course.new("French")
    end

    describe "#new" do
      it "is initialized with a name" do
        expect{Course.new("History")}.to_not raise_error
      end

      it 'pushes new instances into a class variable called @@all upon initialization' do
        expect(Course.class_variable_get(:@@all)).to include(@course)
      end
    end

    describe '@@all' do
      it 'is a class variable set to an array' do
        expect(Course.class_variable_get(:@@all)).to be_a(Array)
      end
    end

    describe '.all' do
      it 'is a class method that returns an array of all course instances that have been created' do
        expect(Course.all).to match([@course])
      end
    end


    describe "#name" do
      it "has an attr_accessor for name, allowing for both reading and writint" do
        expect(@course.name).to eq("French")
        @course.name = "French 201: Conversation"
        expect(@course.name).to eq("French 201: Conversation")
      end
    end

    describe "#add_student" do
      it "takes in an argument of a student and associates that student with the course by telling the student that it belongs to that course" do

        amy = Student.new("Amy")
        @course.add_student(amy)
        expect(amy.course).to eq(@course)
      end
    end

    describe "#students" do
      it "returns a collection of students specific to this class instance" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_student(student)
        @course.add_student(student2)
        expect(@course.students).to match([student,student2])
        course2 = Course.new('History')
        student3 = Student.new('Ian')
        course2.add_student(student3)
        expect(@course.students).to match([student,student2])
        expect(course2.students).to match([student3])

      end
    end

    describe "#add_student_by_name" do
      it "takes in an argument of a student name, creates a new student with it and associates the student and course" do
        @course.add_student_by_name("Julia")
        expect(@course.students.last.name).to eq("Julia")
        expect(@course.students.last.course).to eq(@course)
      end
    end

    describe ".student_count" do
      it "is a class method that returns the total number of students associated to all existing courses" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        expect(Course.student_count).to eq(2)
        student3 = Student.new('Liz')
        expect(Course.student_count).to eq(3)
      end
    end

    describe "#add_grade" do
      it "takes in two arguments, a student and an Integer grade, sets the student's grade using the student's attribute accessor" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(student.grade).to be(90)
        expect(student2.grade).to be(100)
      end
    end

    describe "#all_existing_grades" do
      it "returns a collection of all added grades and ignores any ungraded students" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_student(student)
        @course.add_student(student2)
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)

        expect(@course.all_existing_grades).to match([90,100])
        student3 = Student.new('Enzha')
        expect(@course.all_existing_grades).to match([90,100])
      end
    end

    describe "#all_students_graded?" do

      it "if there are students enrolled in the course, checks returns true if all students have grades, or false if some students do not have grades" do

        expect(@course.all_students_graded?).to be(false)

        student = Student.new('Nadia')
        @course.add_student(student)
        expect(@course.all_students_graded?).to be(false)

        student2 = Student.new('Liz')
        @course.add_student(student2)
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)

        expect(@course.all_students_graded?).to be(true)
        @course.add_student_by_name('Harold')
        expect(@course.all_students_graded?).to be(false)

      end
    end

    describe "#average_grade" do
      it "if grading is finished, returns an average of all student grades in the class" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_student(student)
        @course.add_student(student2)
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(@course.average_grade).to be(95)
      end

      it "if grading is not finished, returns 'Grading still in progress.'" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_student(student)
        @course.add_student(student2)
        expect(@course.average_grade).to eq('Grading still in progress.')
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect(@course.average_grade).to be(95)
        @course.add_student_by_name('Harold')
        expect(@course.average_grade).to eq('Grading still in progress.')
      end


    end

    describe "#print_grades" do
      it "is a class method that returns the total number of students associated to all existing courses" do
        student = Student.new('Nadia')
        student2 = Student.new('Liz')
        @course.add_student(student)
        @course.add_student(student2)
        @course.add_grade(student, 90)
        @course.add_grade(student2, 100)
        expect{@course.print_grades}.to output("Nadia: 90\nLiz: 100\n").to_stdout
      end
    end

end
