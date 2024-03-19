class CreateTrails < ActiveRecord::Migration[7.1]
  def change
    create_table :trails do |t|
      t.string :name
      t.boolean :paved
      t.integer :total_length
      t.references :asheville_park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
