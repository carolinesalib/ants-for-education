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
      Classroom.all.each do |classroom|
        update_records api_fetch(args: { 'turma_id' => classroom.ieducar_code } )
      end
    end

    private

    def update_records(results)
      return unless results
      results.each do |result|
        classroom = Classroom.find_by(ieducar_code: result['cod_turma'].to_i)
        if classroom
          discipline = update_discipline(result['nome'], result['id'])
          lesson = Lesson.find_or_initialize_by(discipline_id: discipline.id, classroom_id: classroom.id)
          lesson.course_load = result['carga_horaria']
          lesson.save!
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
