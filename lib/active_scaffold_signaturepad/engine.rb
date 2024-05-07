module ActiveScaffoldSignaturepad
  class Engine < ::Rails::Engine
    initializer 'active_scaffold_signaturepad.action_view' do
      ActiveSupport.on_load :action_view do
        include ActiveScaffoldSignaturepad::ViewHelpers
      end
    end
  end
end
