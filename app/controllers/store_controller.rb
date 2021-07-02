class StoreController < ApplicationController
  before_action :set_count, only: [:index]

  def index
    @products = Product.order(:title)
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
