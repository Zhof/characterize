class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :job
      t.string :location
      t.text :story
      t.integer :rating
      t.string :alignment
      t.string :background
      t.string :trait
      t.string :quirk
      t.boolean :full

      t.timestamps
    end
  end
end
