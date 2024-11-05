#Login with usercredentials

require 'fastlane'
require 'spaceship'

# Log in with Apple ID credentials using Spaceship::Tunes
Spaceship::Tunes.login(ENV['FASTLANE_USER'], ENV['FASTLANE_PASSWORD'])
Spaceship::Tunes.select_team

# Set your sandbox tester email
sandbox_email = 'sandboxtester2345+gold@gmail.com'

begin
  # Fetch all sandbox testers and check if the specified user exists
  puts "Listing all existing sandbox testers..."
  sandbox_users = Spaceship::Tunes::SandboxTester.all
  existing_user = sandbox_users.find { |user| user.email == sandbox_email }

  if existing_user
    puts "Sandbox tester with email #{sandbox_email} already exists."
  else
    # Create new sandbox tester if one with the specified email doesn't exist
    puts "Creating a new sandbox tester..."
    new_tester = Spaceship::Tunes::SandboxTester.create!(
      email: sandbox_email,
      password: 'YourPassword123',
      first_name: 'Test',
      last_name: 'User',
      country: 'US'
    )
    puts "Sandbox tester created successfully with email: #{new_tester.email}"
  end

rescue => e
  puts "Error occurred: #{e.message}"
end