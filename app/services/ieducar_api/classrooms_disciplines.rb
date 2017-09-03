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
      ClassroomDiscipline.delete_all
      Classroom.all.each do |classroom|
        update_records api_fetch(args: {'turma_id': classroom.id} )
      end
    end

    private

    def update_records(results)
      return unless results
      results.each do |result|
        classroom = Classroom.find_by(ieducar_code: result['cod_turma'].to_i)
        if classroom
          ClassroomDiscipline.create!(
            ieducar_code: result['id'],
            name: result['nome'],
            classroom_id: classroom.id,
            course_load: result['carga_horaria']
          )
        end
      end
    end

  end
end
