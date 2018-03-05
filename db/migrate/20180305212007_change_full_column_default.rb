class ChangeFullColumnDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :characters, :full, false
    change_column_null :characters, :full, false
  end
end
