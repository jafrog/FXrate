class IndexController < ApplicationController
  def show
    @currencies = [Struct.new(:id, :name).new(1, "USD")]
  end
end
