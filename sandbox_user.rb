# This implementation does not seem to work
# Checking for existing sandbox user...
# Error occurred: The URL path is not valid - The resource 'v1/sandboxTesters' does not exist

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
  # Delete the existing sandbox user if they exist - Not supported.
#   puts "Checking for existing sandbox user..."
#   sandbox_users = Spaceship::ConnectAPI::SandboxTester.all
#   user = sandbox_users.find { |u| u.email == sandbox_email }

# Fetch all sandbox testers and check if the specified user exists
    puts "Listing all existing sandbox testers..."
    sandbox_users = Spaceship::ConnectAPI::SandboxTester.all
    existing_user = sandbox_users.find { |user| user.email == sandbox_email }

    if user
        puts "Sandbox tester with email #{sandbox_email} already exists."
        # user.delete!
        # puts "User deleted."
    else
        # Create new sandbox tester since one with the specified email doesn't exist
        puts "Creating a new sandbox tester..."
        new_tester = Spaceship::ConnectAPI::SandboxTester.create(
        first_name: 'Test',
        last_name: 'User',
        email: sandbox_email,
        password: 'YourPassword123',
        confirm_password: 'YourPassword123',
        secret_question: 'What is your pet’s name?',
        secret_answer: 'Fluffy',
        birth_date: '1980-03-01',
        app_store_territory: 'US'
        )
        puts "Sandbox tester created successfully with email: #{new_tester.email}"
    end

    rescue => e
        puts "Error occurred: #{e.message}"
    end