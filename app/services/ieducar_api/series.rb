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
        if serie = Serie.find_by(ieducar_code: result['cod_serie'])
          serie.update(
            name: result['nm_serie'],
            course_load: TimeConverter.hour2min(result['carga_horaria'].to_i),
            school_days: result['dias_letivos'],
            interval: result['intervalo']
          )
        elsif result['nm_serie'].present?
          Serie.create!(
            ieducar_code: result['cod_serie'],
            name: result['nm_serie'],
            course_load: TimeConverter.hour2min(result['carga_horaria'].to_i),
            school_days: result['dias_letivos'],
            interval: result['intervalo']
          )
        end
      end
    end

  end
end