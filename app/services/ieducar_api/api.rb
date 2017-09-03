module IeducarApi
  class Api
    def url
      IeducarConfiguration.first[:url]
    end

    def resource_url(params)
      args = ""
      if params[:args]
        params[:args].each do |arg|
          args += "&#{arg[0]}=#{arg[1]}"
        end
      end

      "#{url}/#{params[:path]}?&resource=#{params[:resource]}&oper=get&access_key=#{ACCESS_KEY}#{args}"
    end

    def api_fetch(params)
      resource = RestClient.get(resource_url(params))
      JSON.parse(resource)[params[:resource]]
    end
  end
end