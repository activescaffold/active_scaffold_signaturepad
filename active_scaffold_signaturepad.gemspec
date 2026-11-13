# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'active_scaffold_signaturepad/version'

Gem::Specification.new do |s|
  s.name = 'active_scaffold_signaturepad'
  s.version = ActiveScaffoldSignaturepad::Version::STRING

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Sergio Cambra', 'Volker Hochstein']
  s.summary = 'Signaturepad form_ui using jquery.signaturepad'
  s.description = 'Helper to display a signature zone on ActiveScaffold forms, using jquery.signaturepad'
  s.email = 'activescaffold@googlegroups.com'
  s.homepage = 'http://github.com/activescaffold/active_scaffold_signaturepad'
  s.extra_rdoc_files = [
    'LICENSE.txt',
    'README.textile'
  ]
  s.files = Dir['{app,config,lib}/**/*'] + %w[LICENSE.txt README.textile]
  s.licenses = ['MIT']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 3.2'

  s.add_dependency('active_scaffold', ['>= 3.4.0'])
  s.metadata['rubygems_mfa_required'] = 'true'
end
