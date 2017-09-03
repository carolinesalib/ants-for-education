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
        teacher = Teacher.find_by(ieducar_code: result['ref_cod_servidor'].to_i)
        school = School.find_by(ieducar_code: result['ref_cod_escola'].to_i)
        if teacher && school
          TeacherSchool.create!(
            school_id: school.id,
            teacher_id: teacher.id,
            course_load: TimeConverter.hour2min(result['carga_horaria'].to_i),
            period: result['periodo'].to_i
          )
        end
      end
    end

  end
end
