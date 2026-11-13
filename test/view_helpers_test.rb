# frozen_string_literal: true

require 'test_helper'

# Tests the signaturepad form UI and display helpers.
class ViewHelpersTest < Minitest::Test
  Column = Struct.new(:name, :options)
  Record = Struct.new(:signature)

  def setup
    lookup_context = ActionView::LookupContext.new([])
    @helper = ActionView::Base.with_empty_template_cache.new(lookup_context, {}, nil)
    @helper.extend ActiveScaffoldSignaturepad::ViewHelpers
    @helper.define_singleton_method(:as_) { |key| "translated #{key}" }
    @column = Column.new(:signature, {})
  end

  def test_signaturepad_attributes_translate_the_default_error_and_filter_options
    attributes = @helper.signaturepad_attributes(
      @column,
      ui_options: {line_colour: '#123456', width: 500, unknown: 'ignored'}
    )

    assert_equal '#123456', attributes[:line_colour]
    assert_equal 'translated sign_document', attributes[:error_message_draw]
    assert_equal false, attributes.key?(:width)
    assert_equal false, attributes.key?(:unknown)
  end

  def test_signaturepad_attributes_preserve_literal_errors_and_type
    attributes = @helper.signaturepad_attributes(
      @column,
      ui_options: {error_message_draw: 'Please sign', type: true}
    )

    assert_equal 'Please sign', attributes[:error_message_draw]
    assert attributes[:type]
  end

  def test_input_renders_canvas_hidden_value_and_clear_action
    html = @helper.active_scaffold_input_signaturepad(
      @column,
      {name: 'record[signature]', class: 'custom'},
      ui_options: {width: 320, height: 120}
    )

    assert_includes html, 'class="sigPad custom"'
    assert_includes html, '<canvas width="320" height="120"></canvas>'
    assert_includes html, 'class="output"'
    assert_includes html, 'name="record[signature]"'
    assert_includes html, 'translated clear'
    assert_equal false, html.include?('class="typed"')
  end

  def test_typed_input_renders_type_and_draw_controls
    html = @helper.active_scaffold_input_signaturepad(@column, {}, ui_options: {type: true})

    assert_includes html, 'class="typeIt"'
    assert_includes html, 'translated type_it'
    assert_includes html, 'class="drawIt"'
    assert_includes html, 'translated draw_it'
    assert_includes html, 'class="typed"'
  end

  def test_display_renders_signature_data_and_custom_canvas_size
    html = @helper.active_scaffold_column_signaturepad(
      Record.new('[{"lx":1,"ly":2}]'),
      @column,
      ui_options: {width: 400, height: 150}
    )

    assert_includes html, 'data-display-only="true"'
    assert_includes html, 'data-signature="[{&quot;lx&quot;:1,&quot;ly&quot;:2}]"'
    assert_includes html, '<canvas width="400" height="150"></canvas>'
  end
end
