# Honcho config file. Generated on September 17, 2013 14:47
# See github.com/hitendrasingh/honcho for more informations

Honcho.config do |config|

  ########## Honcho Configuration #############

  # set browser title of admin panel

  config.browser_title "Honcho"

  # set title of admin panel

  config.title "Admin Panel"

  # you can set the default theme of your application over here

  config.default_theme :blue

  # Set the resources which you need to be under admin panel

  config.admin_models  [:post, :comment, :user]

  # show auto managed columns on index pages

  config.auto_managed false

  # show import csv/excel form for following resources

  config.import_form_for [:post]

  # support html5 validations

  config.html5_validations false

  # support download formats

  config.supported_formats :all

end
