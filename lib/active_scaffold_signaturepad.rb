# frozen_string_literal: true

require 'active_scaffold_signaturepad/engine'

module ActiveScaffoldSignaturepad
  def self.root
    "#{File.dirname(__FILE__)}/.."
  end
  autoload :ViewHelpers, 'active_scaffold_signaturepad/view_helpers.rb'
end

ActiveScaffold.stylesheets << 'active_scaffold_signaturepad'
ActiveScaffold.javascripts.push(
  'jquery.signaturepad/jquery.signaturepad', 'active_scaffold_signaturepad'
)
