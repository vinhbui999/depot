class StoreController < ApplicationController
  before_action :set_count, only: [:index]
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize
  def index
    if params[:set_locale]
      I18n.locale = params[:set_locale]
      redirect_to store_index_url(locale: I18n.locale)
    else
    @products = Product.order(:title)
    end
  end

  def get_time
    @time = Time.now.to_s(:db)
    render partial: "shared/time"
  end

  private
  def set_count
    if session[:count].nil?
      session[:count] = 0
    else
      session[:count]+=1
    end    
  end

end
