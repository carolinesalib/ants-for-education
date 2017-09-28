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
            discipline: update_discipline(result['nome'], result['ref_cod_disciplina']),
            teacher: teacher
          )
        end
      end
    end

    def update_discipline(name, ieducar_code)
      discipline = Discipline.find_by(ieducar_code: ieducar_code)
      unless discipline
        discipline = Discipline.create(
          ieducar_code: ieducar_code,
          name: name
        )
      end
      discipline
    end
  end
end
