class CreateForeignExchangeRates < ActiveRecord::Migration
  def change
    create_table :foreign_exchange_rates do |t|
      t.date :fxdate
      t.float :rate
      t.string :currency

      t.timestamps
    end
  end
end
