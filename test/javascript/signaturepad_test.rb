# frozen_string_literal: true

require 'javascript_test_helper'

class SignaturepadJavascriptTest < ActiveScaffold::TestSupport::Javascript::TestCase
  def test_loads_signaturepad_library_before_adapter
    visit_javascript_fixture

    assert_javascript 'typeof jQuery.fn.signaturePad === "function"'
    assert_javascript 'typeof ActiveScaffold.signaturepad === "function"'
    assert_no_javascript_errors
  end

  def test_initializes_existing_and_dynamically_inserted_signature_pads
    with_plugin_assets('active_scaffold_signaturepad') do
      visit_javascript_fixture signaturepad_fixture

      assert_javascript 'window.signaturePadCalls.length === 1'
      assert_javascript 'window.signaturePadCalls[0].options.penColour === "#123456"'
      assert_javascript 'window.signaturePadCalls[0].options.drawOnly === false'
      assert_javascript 'window.signaturePadCalls[0].regenerated === "existing-signature"'

      insert_fixture_html signaturepad('dynamic-pad'), into: '#dynamic-container'
      trigger_active_scaffold_event :element_updated, target: '#dynamic-container'

      assert_javascript 'window.signaturePadCalls.length === 2'
      assert_javascript 'window.signaturePadCalls[1].id === "dynamic-pad"'
      assert_no_javascript_errors
    end
  end

  private

  def signaturepad_fixture
    <<~HTML
      <script>
        window.signaturePadCalls = [];
        jQuery.fn.signaturePad = function(options) {
          var call = {id: this.attr('id'), options: options};
          window.signaturePadCalls.push(call);
          return {
            regenerate: function(signature) { call.regenerated = signature; }
          };
        };
      </script>
      <div class="active-scaffold">
        #{signaturepad('initial-pad', signature: 'existing-signature', type: true)}
        <div id="dynamic-container"></div>
      </div>
    HTML
  end

  def signaturepad(id, signature: '', type: false)
    <<~HTML
      <div id="#{id}" class="sigPad" data-pen-colour="#123456"#{' data-type="true"' if type}>
        <div class="sigWrapper"><canvas width="250" height="100"></canvas></div>
        <input type="hidden" value="#{signature}">
      </div>
    HTML
  end

  def with_plugin_assets(*assets)
    original = ActiveScaffold.javascripts.dup
    ActiveScaffold.javascripts.replace(assets)
    yield
  ensure
    ActiveScaffold.javascripts.replace(original)
  end
end
