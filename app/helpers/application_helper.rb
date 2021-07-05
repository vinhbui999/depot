module ApplicationHelper

    def hidden_div_if(condition, attributes = {}, &block)
        if condition
            attributes["style"] = "display: none"
        end
        content_tag("div", attributes, &block)
        # wrap the output created by a block in a tag
    end

    

end
