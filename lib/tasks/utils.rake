namespace :utils do
  desc "Generate the API configuration for sync with i-Educar"
  task generate_api_configuration: :environment do
    IeducarConfiguration.create(url: 'http://localhost:8080')
  end

end
