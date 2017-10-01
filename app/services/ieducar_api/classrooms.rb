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
        school = School.find_by(ieducar_code: result['ref_ref_cod_escola'])
        course = Course.find_by(ieducar_code: result['ref_cod_curso'])
        serie = Serie.find_by(ieducar_code: result['ref_ref_cod_serie'])

        next unless school and course and serie

        if classroom = Classroom.find_by(ieducar_code: result['cod_turma'])
          classroom.update(
            name: result['nm_turma'],
            start_at: result['hora_inicial'],
            stop_at: result['hora_final'],
            interval_start: result['hora_inicio_intervalo'],
            interval_stop: result['hora_fim_intervalo'],
            year: result['ano'].to_i,
            school_id: school,
            course_id: course,
            serie_id: serie
          )
        elsif result['nm_turma'].present?
          Classroom.create(
            ieducar_code: result['cod_turma'],
            name: result['nm_turma'],
            start_at: result['hora_inicial'],
            stop_at: result['hora_final'],
            interval_start: result['hora_inicio_intervalo'],
            interval_stop: result['hora_fim_intervalo'],
            year: result['ano'].to_i,
            school_id: school,
            course_id: course,
            serie_id: serie
          )
        end
      end
    end

  end
end
