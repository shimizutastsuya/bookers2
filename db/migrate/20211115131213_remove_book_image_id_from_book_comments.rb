class RemoveBookImageIdFromBookComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_comments, :book_image_id, :integer
  end
end
