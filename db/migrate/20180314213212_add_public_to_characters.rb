class AddPublicToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :shared, :boolean
  end
end
