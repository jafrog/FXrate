class ActiveRecordStorage
  def get currency, date = Date.today
    FXrate.all :conditions => {:fxdate => date, :currency => currency}
  end

  def save data
    super do |date, currency, rate|
      FXrate.create :fxdate => date, :currency => currency, :rate => rate
    end
  end
end
