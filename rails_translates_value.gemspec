$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_translates_value/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails_translates_value'
  s.version     = RailsTranslatesValue::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://www.github.com/robotex82/rails_translates_value'
  s.summary     = 'Translate rails active model values with i18n.'
  s.description = 'Translate rails active model values with i18n.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '>= 4.0'

  s.add_development_dependency 'sqlite3'

  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'rubocop'
end
