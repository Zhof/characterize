class AddBackgroundsToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :personality_traits, :text
    add_column :characters, :ideal, :string
    add_column :characters, :bond, :string
    add_column :characters, :flaw, :string
  end
end
