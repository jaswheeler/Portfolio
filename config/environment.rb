APP_VERSION = `git describe --always` unless defined? APP_VERSION

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PortfolioManager::Application.initialize!
