class StoreController < ApplicationController
  before_action :set_count, only: [:index]
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.all
    if params[:set_locale]
      I18n.locale = params[:set_locale]
      redirect_to store_index_url(locale: I18n.locale)
      # else
    end

    if params[:search].present?
      @products = Product.where("title LIKE ?", "%#{params[:search]}%")
    end
    if @products.empty?
      flash.now[:error] = "No products match \" #{params[:search]} \"."
      @products = Product.all
    # else
      # flash.now[:notice] = "There are #{@products.count} matches."
    end
    @products = @products.order(:title).page(params[:page])
    # end
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
      session[:count] += 1
    end
  end
end
