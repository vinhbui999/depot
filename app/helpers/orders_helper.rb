module OrdersHelper
    def disabled_button_if(condition, attributes = {}, &block)
        if condition
            attributes["input"] = "disabled"
        end
        content_tag("div", attributes, &block)
    end
end
