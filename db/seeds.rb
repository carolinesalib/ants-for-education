# Create default schedule
ClassSchedule.find_or_create_by!(name: 'Default')

# Create default test case
school = School.find_or_create_by!(name: 'TCC Escola - Demonstração')
course = Course.find_or_create_by!(name: 'TCC Curso')
serie = Serie.find_or_create_by!(name: 'TCC Série')
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
disciplines_data << { name: 'TCC PORTUGUES' }
disciplines_data << { name: 'TCC MATEMATICA' }
disciplines_data << { name: 'TCC CIENCIAS' }
disciplines_data << { name: 'TCC GEOGRAFIA' }
disciplines_data << { name: 'TCC HISTORIA' }

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
disciplines_data << { name: 'TCC INGLES' }
disciplines_data << { name: 'TCC FILOSOFIA' }
disciplines_data << { name: 'TCC INFORMATICA' }
disciplines_data << { name: 'TCC ARTES' }
disciplines_data << { name: 'TCC ESPANHOL' }

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
teacher_data << { name: 'MARIA' }
teacher_data << { name: 'JOAO' }
teacher_data << { name: 'MARCOS' }
teacher_data << { name: 'DAVID' }
teacher_data << { name: 'CLAUDIA' }
teacher_data << { name: 'JORGE' }
teacher_data << { name: 'MATEUS' }
teacher_data << { name: 'JOANA' }
teacher_data << { name: 'CLARA' }
teacher_data << { name: 'LUIZA' }

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