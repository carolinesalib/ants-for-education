# Create default schedule
# ClassSchedule.find_or_create_by!(name: 'Default')

# Create default test case
school = School.find_or_create_by!(name: 'Escola TCC - Demonstração')
course = Course.find_or_create_by!(name: 'Curso TCC')
serie = Serie.find_or_create_by!(name: 'Série TCC')
classrooms = []

5.times do |index|
  classrooms << Classroom.find_or_create_by!(
    name: "TCC Turma #{index}",
    school_id: school.id,
    course_id: course.id,
    serie_id: serie.id,
    year: Date.today.year
  )
end

disciplines_data = []
disciplines_data << { name: 'PORTUGUES TCC' }
disciplines_data << { name: 'MATEMATICA TCC' }
disciplines_data << { name: 'CIENCIAS TCC' }
disciplines_data << { name: 'GEOGRAFIA TCC' }
disciplines_data << { name: 'HISTORIA TCC' }

disciplines = []
disciplines_data.each do |discipline_name|
  disciplines << Discipline.find_or_create_by!(discipline_name)
end

classrooms.each do |classroom|
  disciplines.each do |discipline|
    Lesson.find_or_create_by!(
      discipline_id: discipline.id,
      classroom_id: classroom.id,
      credits: 3
    )
  end
end

disciplines_data = []
disciplines_data << { name: 'INGLES TCC' }
disciplines_data << { name: 'FILOSOFIA TCC' }
disciplines_data << { name: 'INFORMATICA TCC' }
disciplines_data << { name: 'ARTES TCC' }
disciplines_data << { name: 'ESPANHOL TCC' }

disciplines_data.each do |discipline_name|
  disciplines << Discipline.find_or_create_by!(discipline_name)
end

classrooms.each do |classroom|
  disciplines.each do |discipline|
    Lesson.find_or_create_by!(
      discipline_id: discipline.id,
      classroom_id: classroom.id,
      credits: 2
    )
  end
end

teacher_data = []
teacher_data << { name: 'MARIA TCC' }
teacher_data << { name: 'JOAO TCC' }
teacher_data << { name: 'MARCOS TCC' }
teacher_data << { name: 'DAVID TCC' }
teacher_data << { name: 'CLAUDIA TCC' }
teacher_data << { name: 'JORGE TCC' }
teacher_data << { name: 'MATEUS TCC' }
teacher_data << { name: 'JOANA TCC' }
teacher_data << { name: 'CLARA TCC' }
teacher_data << { name: 'LUIZA TCC' }

teachers = []
teacher_data.each do |teacher_name|
  teachers << Teacher.find_or_create_by!(teacher_name)
end

disciplines.each_with_index do |discipline, index|
  TeacherDiscipline.create(
    discipline: discipline,
    teacher: teachers[index]
  )
end