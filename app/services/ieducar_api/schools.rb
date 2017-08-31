module IeducarApi
  class Schools < Api
    def api_fetch(params = {})
      params = {
        path: "module/Api/Escola",
        resource: "escolas"
      }
      super
    end

    def sync!
      update_records api_fetch
    end

    private

    def update_records(results)
      results.each do |result|
        if school = School.find_by(ieducar_code: result['cod_escola'])
          school.update(name: result['nome'])
        elsif result['nome'].present?
          School.create!(
            ieducar_code: result['cod_escola'],
            name: result['nome']
          )
        end
      end
    end
  end
end