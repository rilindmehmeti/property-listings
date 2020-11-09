class CreateSeasonalRates < ActiveRecord::Migration[6.0]
  def change
    create_table :seasonal_rates do |t|
      t.references :listing, index: true, foreign_key: true
      t.date :start_date, index: true
      t.date :end_date, index: true
      t.decimal :daily_rate, default: 0
      t.timestamps
    end
  end
end
