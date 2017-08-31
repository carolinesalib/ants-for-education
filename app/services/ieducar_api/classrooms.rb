module IeducarApi
  class Classrooms < Api
    def api_fetch(params = {})
      params = {
        path: "module/Api/Turma",
        resource: "turmas"
      }
      super
    end

    def sync!
      update_records api_fetch
    end

    private

    def update_records(results)
      results.each do |result|
        if classroom = Classroom.find_by(ieducar_code: result['cod_turma'])
          classroom.update(
            name: result['nm_turma'],
            start_at: result['hora_inicial'],
            stop_at: result['hora_final'],
            interval_start: result['hora_inicio_intervalo'],
            interval_stop: result['hora_fim_intervalo']
          )
        elsif result['nm_turma'].present?
          Classroom.create!(
            ieducar_code: result['cod_turma'],
            name: result['nm_turma'],
            start_at: result['hora_inicial'],
            stop_at: result['hora_final'],
            interval_start: result['hora_inicio_intervalo'],
            interval_stop: result['hora_fim_intervalo']
          )
        end
      end
    end

  end
end
