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
        course_load = course_load_time_converter result['carga_horaria']
        if teacher = Teacher.find_by(ieducar_code: result['cod_servidor'])
          teacher.update(
            name: result['nome'],
            course_load: course_load.to_min
          )
        elsif result['nome'].present?
          Teacher.create!(
            ieducar_code: result['cod_servidor'],
            name: result['nome'],
            course_load: course_load.to_min
          )
        end
      end
    end

    def course_load_time_converter(course_load)
      TimeConverter.new(nil, course_load)
    end
  end
end
