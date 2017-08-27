module IeducarApi
  class Api
    def access_key
      'kXol8EPSFgd1WsXSqlaUMMa2XYY23D'
    end

    def url
      IeducarConfiguration.first[:url]
    end

    def resource_url(params)
      "#{url}/#{params[:path]}?&resource=#{params[:resource]}&oper=get&access_key=#{access_key}"
    end

    def api_fetch(params)
      resource = RestClient.get(resource_url(params))
      JSON.parse(resource)[params[:resource]]
    end

  end
end