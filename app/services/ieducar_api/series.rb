module IeducarApi
  class Series < Api
    def api_fetch(params = {})
      params = {
        path: "module/Api/Serie",
        resource: "series"
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
        if serie = Serie.find_by(ieducar_code: result['cod_serie'])
          serie.update(
            name: result['nm_serie'],
            course_load: course_load.to_min,
            school_days: result['dias_letivos'],
            interval: result['intervalo']
          )
        elsif result['nm_serie'].present?
          Serie.create!(
            ieducar_code: result['cod_serie'],
            name: result['nm_serie'],
            course_load: course_load.to_min,
            school_days: result['dias_letivos'],
            interval: result['intervalo']
          )
        end
      end
    end

    def course_load_time_converter(course_load)
      TimeConverter.new(nil, course_load)
    end
  end
end