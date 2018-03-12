class AddPhotosToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :photo, :string
  end
end
