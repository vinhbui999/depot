class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
  end

  def get_time
    @time = Time.now.to_s(:db)
    render partial: "shared/time"
  end
end
