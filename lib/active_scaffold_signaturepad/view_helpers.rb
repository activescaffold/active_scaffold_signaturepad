# frozen_string_literal: true

module ActiveScaffoldSignaturepad
  module ViewHelpers
    ATTRIBUTES = %i[line_colour line_width line_margin line_top bg_colour pen_colour pen_width pen_cap
                    display_only error_message_draw].freeze
    def signaturepad_attributes(column, ui_options: column.options)
      attributes = ATTRIBUTES.filter_map { |attr| [attr, ui_options[attr]] if ui_options[attr] }.to_h
      attributes.reverse_merge!(error_message_draw: :sign_document)
      attributes[:type] = ui_options[:type] if ui_options[:type]
      if attributes[:error_message_draw].is_a? Symbol
        attributes[:error_message_draw] =
          as_(attributes[:error_message_draw])
      end
      attributes
    end

    def active_scaffold_input_signaturepad(column, html_options, ui_options: column.options)
      content_tag(:div, class: "sigPad #{html_options[:class]}",
                        data: signaturepad_attributes(column, ui_options: ui_options)) do
        content_tag(:ul, _as_signaturepad_nav(column, ui_options), class: 'sigNav') <<
          content_tag(:div, _as_signaturepad_sig(column, html_options, ui_options), class: 'sig sigWrapper')
      end
    end

    def _as_signaturepad_nav(column, ui_options)
      content = []
      if ui_options[:type]
        content << content_tag(:li, link_to(as_(:type_it), '#type-it'), class: 'typeIt') <<
          content_tag(:li, link_to(as_(:draw_it), '#draw-it'), class: 'drawIt')
      end
      content << content_tag(:li, link_to(as_(:clear), '#clear'), class: 'clearButton')
      safe_join(content)
    end

    def _as_signaturepad_sig(column, html_options, ui_options)
      content = []
      content << content_tag(:div, '', class: 'typed') if ui_options[:type]
      content << _as_signaturepad_canvas(column, ui_options) <<
        hidden_field(:record, column.name, html_options.merge(class: 'output'))
      safe_join(content)
    end

    def _as_signaturepad_canvas(column, ui_options)
      content_tag(:canvas, '', width: ui_options[:width] || 250, height: ui_options[:height] || 100)
    end
    private :_as_signaturepad_nav, :_as_signaturepad_sig, :_as_signaturepad_canvas

    def active_scaffold_column_signaturepad(record, column, ui_options: column.options)
      data = signaturepad_attributes(column, ui_options: ui_options).merge(display_only: true,
                                                                           signature: record.send(column.name))
      content_tag :div, class: 'sigPad', data: data do
        content_tag :div, class: 'sigWrapper' do
          _as_signaturepad_canvas(column, ui_options)
        end
      end
    end
    alias active_scaffold_show_signaturepad active_scaffold_column_signaturepad
  end
end
