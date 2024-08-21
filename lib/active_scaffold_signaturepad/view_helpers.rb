module ActiveScaffoldSignaturepad
  module ViewHelpers
    ATTRIBUTES = [:line_colour, :line_width, :line_margin, :line_top, :bg_colour, :pen_colour, :pen_width, :pen_cap, :display_only, :error_message_draw]
    def signaturepad_attributes(column, ui_options: column.options)
      attributes = ATTRIBUTES.map{ |attr| [attr, ui_options[attr]] if ui_options[attr] }.compact.to_h
      attributes.reverse_merge!(:error_message_draw => :sign_document)
      attributes[:type] = ui_options[:type] if ui_options[:type]
      attributes[:error_message_draw] = as_(attributes[:error_message_draw]) if attributes[:error_message_draw].is_a? Symbol
      attributes
    end

    def active_scaffold_input_signaturepad(column, html_options, ui_options: column.options)
      content_tag(:div, class: "sigPad #{html_options[:class]}", data: signaturepad_attributes(column, ui_options: ui_options)) do
        content_tag(:ul, class: 'sigNav') do
          if ui_options[:type]
            content_tag(:li, link_to(as_(:type_it), '#type-it'), class: 'typeIt') <<
            content_tag(:li, link_to(as_(:draw_it), '#draw-it'), class: 'drawIt')
          else
            ''.html_safe
          end <<
          content_tag(:li, link_to(as_(:clear), '#clear'), class: 'clearButton')
        end <<
        content_tag(:div, class: 'sig sigWrapper') do
          (ui_options[:type] ? content_tag(:div, '', class: 'typed') : ''.html_safe) <<
          content_tag(:canvas, '', width: ui_options[:width] || 250, height: ui_options[:height] || 100) <<
          hidden_field(:record, column.name, html_options.merge(class: 'output'))
        end
      end
    end

    def active_scaffold_column_signaturepad(record, column, ui_options: column.options)
      data = signaturepad_attributes(column, ui_options: ui_options).merge(display_only: true, signature: record.send(column.name))
      content_tag :div, class: 'sigPad', data: data do
        content_tag :div, class: 'sigWrapper' do
          content_tag :canvas, '', width: ui_options[:width] || 250, height: ui_options[:height] || 100
        end
      end
    end
    alias_method :active_scaffold_show_signaturepad, :active_scaffold_column_signaturepad

    def self.json_attributes
      ATTRIBUTES.map { |attr| attr.to_s.camelize(:lower) }.to_json.html_safe
    end
  end
end
