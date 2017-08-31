module IeducarApi
  class Api
    def url
      IeducarConfiguration.first[:url]
    end

    def resource_url(params)
      "#{url}/#{params[:path]}?&resource=#{params[:resource]}&oper=get&access_key=#{ACCESS_KEY}"
    end

    def api_fetch(params)
      resource = RestClient.get(resource_url(params))
      JSON.parse(resource)[params[:resource]]
    end
  end
end