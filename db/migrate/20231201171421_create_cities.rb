class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.string :country_code, null: false
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
