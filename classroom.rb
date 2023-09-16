class Classroom
  attr_accessor :label
  attr_reader :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    @students << student
    student.classroom = self
  end
end

# classroom = Classroom.new('Math')
# student = Student.new('Max')
# classroom.add_student(student)
# puts classroom.students[0].name
# puts student.classroom.label
