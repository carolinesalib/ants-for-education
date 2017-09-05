namespace :utils do
  desc "Generate the API configuration for sync with i-Educar"
  task generate_api_configuration: :environment do
    IeducarConfiguration.create(url: 'http://localhost:8080')
  end

  desc "Generate default class schedule configuration"
  task generate_class_schedule: :environment do
    ClassSchedule.create(name: 'Default')
  end
end
