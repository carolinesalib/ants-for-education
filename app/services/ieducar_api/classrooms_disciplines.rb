module IeducarApi
  class ClassroomsDisciplines < Api
    def api_fetch(params)
      params.merge!({
        path: "module/Api/Turma",
        resource: "turmas-disciplinas",
      })
      super
    end

    def sync!
      Lesson.delete_all
      Classroom.all.each do |classroom|
        update_records api_fetch(args: { 'turma_id' => classroom.id } )
      end
    end

    private

    def update_records(results)
      return unless results
      results.each do |result|
        classroom = Classroom.find_by(ieducar_code: result['cod_turma'].to_i)
        if classroom
          Lesson.create!(
            discipline: update_discipline(result['nome'], result['id']),
            classroom: classroom,
            course_load: result['carga_horaria']
          )
        end
      end
    end

    def update_discipline(name, ieducar_code)
      discipline = Discipline.find_by(ieducar_code: ieducar_code)
      unless discipline
        discipline ||= Discipline.create(
          ieducar_code: ieducar_code,
          name: name
        )
      end
      discipline
    end
  end
end
