require "active_scaffold_signaturepad/engine.rb"

module ActiveScaffoldSignaturepad
  def self.root
    File.dirname(__FILE__) + "/.."
  end
  autoload 'ViewHelpers', 'active_scaffold_signaturepad/view_helpers.rb'
end

ActionView::Base.send :include, ActiveScaffoldSignaturepad::ViewHelpers
ActiveScaffold.stylesheets << 'active_scaffold_signaturepad'
ActiveScaffold.javascripts << 'active_scaffold_signaturepad'
