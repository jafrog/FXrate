require 'sqlite3'

class SQLiteStorage
  attr_accessor :db

  def initialize db_name = 'fxrate.db'
    @db = SQLite3::Database.new db_name
  end

  def get currency, date = Date.today
    @db.execute("SELECT rate FROM fx_rates WHERE fxdate = ? AND currency = ?;", [date.to_time.to_i, currency]).first
  end

  def save data
    data.each do |date, currencies|
      currencies.each do |currency, rate|
        @db.execute("INSERT INTO fx_rates (fxdate, currency, rate) VALUES (?, ?, ?)",
                    [date.to_time.to_i, currency, rate])
      end
    end
  end
end
