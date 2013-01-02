class CreateFxrates < ActiveRecord::Migration
  def change
    create_table :fxrates do |t|
      t.date :fxdate
      t.string :currency
      t.float :rate

      t.timestamps
    end
  end
end
