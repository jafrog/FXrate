require 'date'

require 'sources/ecbfeed'

require 'storages/fx_storage'
require 'storages/sqlite_storage'

class FXrate
  class << self
    attr_accessor :storage, :source

    def setup(options = {})
      @storage = options[:storage] ||= SQLiteStorage.new
      @source  = options[:source]  ||= ECBfeed.new
    end

    def at date, base_currency, counter_currency
      base_currency_rate = @storage.get(base_currency, date)
      counter_currency_rate = @storage.get(counter_currency, date)

      if counter_currency_rate && base_currency_rate && !counter_currency_rate.empty? && !base_currency_rate.empty?
        (counter_currency_rate.first / base_currency_rate.first).round(2)
      else
        nil
      end
    end

    def update
      data = @source.fetch
      @storage.save(data)
    end
  end
end
