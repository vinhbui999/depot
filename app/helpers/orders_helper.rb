# frozen_string_literal: true

module OrdersHelper
  def disabled_button_if(condition, attributes = {}, &block)
    attributes['input'] = 'disabled' if condition
    content_tag('div', attributes, &block)
  end
end
