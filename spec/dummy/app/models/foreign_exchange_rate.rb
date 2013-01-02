class ForeignExchangeRate < ActiveRecord::Base
  attr_accessible :currency, :fxdate, :rate
end
