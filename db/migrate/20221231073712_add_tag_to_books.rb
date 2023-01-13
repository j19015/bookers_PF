class AddTagToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :tag_id, :integer
  end
end
