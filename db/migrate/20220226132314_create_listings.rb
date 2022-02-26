class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.integer :number_of_rooms

      t.timestamps
    end
  end
end
