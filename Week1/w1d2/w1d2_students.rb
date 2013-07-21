class Student
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def courses
    course_names = []
    @courses.each do |course|
      course_names << course.course_name
    end
    course_names.join(", ")
  end

  def enroll(course)
    unless @courses.include?(course) || conflict_checker?(course)
      @courses << course
      course.add_student(self)
    end
  end

  def conflict_checker?(potential_course)
    conflict = false
    @courses.each do |course|
      if Course.conflicts?(course, potential_course)
        conflict = true
      end
    end
    conflict
  end

  def course_load
    course_ld = Hash.new(0)
    @courses.each do |course|
      course_ld[course.department] += course.credits
    end
    course_ld
  end

end


class Course
  attr_accessor :course_name, :department, :credits, :times, :days

  def self.conflicts?(course1, course2)
    course1.times == course2.times && !(course1.days & course2.days).empty?
  end

  def initialize(course_name, department, credits, times, days)
    @course_name = course_name
    @department = department
    @credits = credits
    @students = []
    @times = times
    @days = days
  end

  def students
    students_names = []
    @students.each do |student|
      students_names << student.name
    end
    students_names.join(", ")
  end

  def add_student(student)
    puts "add student called"
    unless @students.include?(student) || student.conflict_checker?(self)
      puts "student added"
      @students << student
      student.enroll(self)
    end
  end

end

econ = Course.new("Economics", "Social Studies", 5, 4, [:mon, :wed, :fri])
algebra = Course.new("Algebra", "Math", 5, 4, [:wed])

sam = Student.new("Sam", "Davis")
sara = Student.new("Sara", "Smith")

#econ.add_student(sam)
#sam.enroll(algebra)

sara.enroll(algebra)
sara.enroll(econ)


#puts Course.conflicts?(econ, algebra)
#puts sam.courses
#puts sam.course_load
puts sara.courses
puts algebra.students





