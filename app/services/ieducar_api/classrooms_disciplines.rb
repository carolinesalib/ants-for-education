module IeducarApi
  class ClassroomsDisciplines < Api
    def api_fetch(params = {})
      params = {
        path: "module/Api/Turma",
        resource: "turmas-disciplinas"
      }
      super
    end

    def sync!
      update_records api_fetch
    end

    private

    def update_records(results)
      results.each do |result|

        classroom = Classroom.find_by(ieducar_code: result['cod_turma'].to_i)

        next unless classroom

        if disciplines = ClassroomDiscipline.find_by(ieducar_code: result['id'])
          disciplines.update(
            name: result['nome'],
            classroom_id: classroom.id,
            course_load: result['carga_horaria']
          )
        elsif result['nome'].present?
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
