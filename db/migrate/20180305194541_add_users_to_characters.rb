class AddUsersToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_reference :characters, :user, index: true
  end
end
