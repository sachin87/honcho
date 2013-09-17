# desc "Explaining what the task does"
# task :honcho do
#   # Task goes here
# end
namespace :honcho do
  desc "Install Honcho in your application"
  task :install do
  	system 'rails g honcho:install'
  end
end