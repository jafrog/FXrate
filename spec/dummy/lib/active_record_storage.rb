class ActiveRecordStorage < FXStorage
  def get currency, date = Date.today
    ForeignExchangeRate.all(:conditions => {:fxdate => date, :currency => currency}).map(&:rate)
  end

  def save data
    super do |date, currency, rate|
      ForeignExchangeRate.create :fxdate => date, :currency => currency, :rate => rate
    end
  end
end
