class FXStorage
  def save data
    data.each do |date, currencies|
      currencies.each do |currency, rate|
        yield(date, currency, rate)
      end
    end
  end
end
