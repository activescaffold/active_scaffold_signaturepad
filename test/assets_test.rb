# frozen_string_literal: true

require 'test_helper'

class AssetsTest < Minitest::Test
  def test_registers_plain_javascript_assets_in_dependency_order
    assert_equal(
      ['jquery.signaturepad/jquery.signaturepad', 'active_scaffold_signaturepad'],
      ActiveScaffold.javascripts
    )

    ActiveScaffold.javascripts.each do |logical_path|
      path = File.expand_path("../app/assets/javascripts/#{logical_path}.js", __dir__)

      assert_path_exists path
    end
  end

  def test_integration_asset_does_not_require_asset_processing
    path = File.expand_path('../app/assets/javascripts/active_scaffold_signaturepad.js', __dir__)
    source = File.read(path)

    assert_equal false, source.include?('<%')
    assert_equal false, source.include?('//= require')
  end
end
