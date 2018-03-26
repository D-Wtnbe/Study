class AddPrefectureCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :prefecture_code, :integer
    add_column :users, :prefecture_name, :integer
  end
end
