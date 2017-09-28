module IeducarApi
  class TeachersSchools < Api
    def api_fetch(params)
      params.merge!({
        path: "module/Api/Servidor",
        resource: "servidores-escolas",
      })
      super
    end

    def sync!
      TeacherSchool.delete_all
      Teacher.all.each do |teacher|
        update_records api_fetch(args: {'servidor_id': teacher.ieducar_code} )
      end
    end

    private

    def update_records(results)
      return unless results
      results.each do |result|
        course_load = course_load_time_converter result['carga_horaria']
        teacher = Teacher.find_by(ieducar_code: result['ref_cod_servidor'].to_i)
        school = School.find_by(ieducar_code: result['ref_cod_escola'].to_i)
        if teacher && school
          TeacherSchool.create!(
            school_id: school.id,
            teacher_id: teacher.id,
            course_load: course_load.to_min,
            period: result['periodo'].to_i
          )
        end
      end
    end

    def course_load_time_converter(course_load)
      TimeConverter.new(nil, course_load)
    end
  end
end
