require 'fastlane'
require 'spaceship'


# Set up the token for App Store Connect API
token = Spaceship::ConnectAPI::Token.create(
    key_id: ENV['APP_STORE_CONNECT_KEY_ID'],
    issuer_id: ENV['APP_STORE_CONNECT_ISSUER_ID'],
    filepath: File.absolute_path(ENV['APP_STORE_CONNECT_P8_PATH']) 
)

# Authenticate using the token
Spaceship::ConnectAPI.token = token

# Set your sandbox tester email
sandbox_email = 'sandboxtester2345+gold@gmail.com'

begin
  # Delete the existing sandbox user if they exist
  puts "Checking for existing sandbox user..."
  sandbox_users = Spaceship::ConnectAPI::SandboxTester.all
  user = sandbox_users.find { |u| u.email == sandbox_email }

  if user
    puts "Existing sandbox user found, deleting..."
    user.delete!
    puts "User deleted."
  else
    puts "No existing sandbox user found."
  end

  # Create new sandbox user
  puts "Creating a new sandbox user..."
  Spaceship::ConnectAPI::SandboxTester.create!(
    first_name: 'Test',
    last_name: 'User',
    email: sandbox_email,
    password: 'YourPassword123',
    confirm_password: 'YourPassword123',
    secret_question: 'What is your pet’s name?',
    secret_answer: 'Fluffy',
    birth_date: '1980-03-01',
    app_store_territory: 'DEU'
  )
  puts "Sandbox user created successfully."

rescue => e
  puts "Error occurred: #{e.message}"
end