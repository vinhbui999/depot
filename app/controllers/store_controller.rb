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
      @products = Product.where("lower(title) LIKE ?", "%#{params[:search].downcase}%")
    end
    if @products.empty?
      flash.now[:error] = "No products match \" #{params[:search]} \"."
      @products = Product.all
      # else
      # flash.now[:notice] = "There are #{@products.count} matches."
    end

    case params[:filter].to_i
    when 1
      @products = @products.order(price: :asc).page(params[:page])
    when 2
      @products = @products.order(price: :desc).page(params[:page])
    when 3
      @products = @products.order(title: :asc).page(params[:page])
    when 4
      @products = @products.order(title: :desc).page(params[:page])
    else
      @products = @products.order(:title).page(params[:page])
    end

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
