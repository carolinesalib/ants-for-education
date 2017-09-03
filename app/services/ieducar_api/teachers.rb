module IeducarApi
  class Teachers < Api
    def api_fetch(params = {})
      params = {
        path: "module/Api/Servidor",
        resource: "servidores"
      }
      super
    end

    def sync!
      update_records api_fetch
    end

    private

    def update_records(results)
      results.each do |result|
        if teacher = Teacher.find_by(ieducar_code: result['cod_servidor'])
          teacher.update(
            name: result['nome'],
            course_load: TimeConverter.hour2min(result['carga_horaria'].to_i)
          )
        elsif result['nome'].present?
          Teacher.create!(
            ieducar_code: result['cod_servidor'],
            name: result['nome'],
            course_load: TimeConverter.hour2min(result['carga_horaria'].to_i)
          )
        end
      end
    end

  end
end
