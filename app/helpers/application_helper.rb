# frozen_string_literal: true

module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    attributes['style'] = 'display: none' if condition
    content_tag('div', attributes, &block)
    # wrap the output created by a block in a tag
  end
end
