class RemoveCountFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :likes_count, :integer
  end
end
