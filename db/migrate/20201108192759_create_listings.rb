class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.decimal :default_daily_rate, default: 0
      t.timestamps
    end
  end
end
