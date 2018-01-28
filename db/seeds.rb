# Create default i-educar configuration
IeducarConfiguration.find_or_create_by!(url: 'http://comunidade.ieducar.com.br')

# Create default schedule
ClassSchedule.find_or_create_by!(name: 'Default')