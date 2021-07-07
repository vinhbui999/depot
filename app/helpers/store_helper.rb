module StoreHelper
    def exchange(price, locale)
        logger.debug(I18n.locale)
        case locale.to_s
        when "vn"
            return (price*23048.39).ceil(2)
        else return price
        end
    end
end
