class CreateAshevilleParks < ActiveRecord::Migration[7.1]
  def change
    create_table :asheville_parks do |t|
      t.string :name
      t.integer :fee
      t.boolean :pets_allowed

      t.timestamps
    end
  end
end
