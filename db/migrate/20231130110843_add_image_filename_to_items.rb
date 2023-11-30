class AddImageFilenameToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :image_filename, :string
  end
end
