class CreateAirQualityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :air_quality_logs do |t|
      t.references :city, null: false, foreign_key: true
      t.integer :index, null: false
      t.jsonb :concentrations, default: {}
      t.datetime :recorded_on

      t.timestamps
    end
  end
end
