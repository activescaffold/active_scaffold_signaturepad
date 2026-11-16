# frozen_string_literal: true

SimpleCov.configure do
  skip '/test/'
  skip '/version.rb'
  cover '{app,lib}/**/*.rb'
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter
]
