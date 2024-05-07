module ActiveScaffoldSignaturepad
  class Engine < ::Rails::Engine
    initializer 'active_scaffold_signaturepad.action_view' do
      ActiveSupport.on_load :action_view do
        include ActiveScaffoldSignaturepad::ViewHelpers
      end
    end

    initializer "active_scaffold_signaturepad.assets" do
      ActiveSupport.on_load :active_scaffold do
        self.stylesheets << 'active_scaffold_signaturepad'
        self.javascripts << 'active_scaffold_signaturepad'
      end
    end
  end
end
