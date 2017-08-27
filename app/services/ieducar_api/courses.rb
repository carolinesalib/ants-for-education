module IeducarApi
  class Courses < Api
    def api_fetch(params = {})
      params = {
        path: "module/Api/Curso",
        resource: "cursos"
      }
      super
    end

    def sync!
      update_records api_fetch
    end

    private

    def update_records(results)
      results.each do |result|
        if course = Course.find_by(ieducar_code: result['cod_curso'])
          course.update(name: result['nm_curso'])
        elsif result['nm_curso'].present?
          Course.create!(
            ieducar_code: result['cod_curso'],
            name: result['nm_curso']
          )
        end
      end
    end

  end
end