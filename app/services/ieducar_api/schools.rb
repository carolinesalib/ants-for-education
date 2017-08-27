module IeducarApi
  class Schools
    def url
      IeducarConfiguration.first[:url]
    end

    def access_key
      '&access_key=kXol8EPSFgd1WsXSqlaUMMa2XYY23D'
    end

    def resource_url
      url + '/module/Api/Escola?&resource=escolas&oper=get' + access_key
    end

    def api_fetch
      resource = RestClient.get resource_url
      JSON.parse(resource)["escolas"]
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