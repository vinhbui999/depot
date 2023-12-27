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

    @products = Product.where('lower(title) LIKE ?', "%#{params[:search].downcase}%") if params[:search].present?
    if @products.empty?
      flash.now[:error] = "No products match \" #{params[:search]} \"."
      @products = Product.all
      # else
      # flash.now[:notice] = "There are #{@products.count} matches."
    end

    @products = product_filtered(params, @product)

    # end
  end

  def product_filtered(params, products)
    case params[:filter].to_i
    when 1
      products.order(price: :asc).page(params[:page])
    when 2
      products.order(price: :desc).page(params[:page])
    when 3
      products.order(title: :asc).page(params[:page])
    when 4
      products.order(title: :desc).page(params[:page])
    else
      products.order(:title).page(params[:page])
    end
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
