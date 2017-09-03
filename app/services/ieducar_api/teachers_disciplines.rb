module IeducarApi
  class TeachersDisciplines < Api
    def api_fetch(params)
      params.merge!({
        path: "module/Api/Servidor",
        resource: "servidores-disciplinas",
      })
      super
    end

    def sync!
      TeacherDiscipline.delete_all
      Teacher.all.each do |teacher|
        update_records api_fetch(args: {'servidor_id': teacher.ieducar_code} )
      end
    end

    private

    def update_records(results)
      return unless results
      results.each do |result|
        teacher = Teacher.find_by(ieducar_code: result['ref_cod_servidor'].to_i)
        if teacher
          TeacherDiscipline.create!(
            ieducar_code: result['ref_cod_disciplina'],
            name: result['nome'],
            teacher_id: teacher.id
          )
        end
      end
    end

  end
end
