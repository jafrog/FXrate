require 'FXrate'
require 'active_record_storage'

class IndexController < ApplicationController
  def show
    FXrate.setup :storage => ActiveRecordStorage.new
    @currencies = ForeignExchangeRate.all.map(&:currency)

    if params[:date]
      @result = FXrate.at(Date.parse(params[:date]), params[:from], params[:to])
      @result = @result * params[:amount].to_f if @result
    end
  end
end
