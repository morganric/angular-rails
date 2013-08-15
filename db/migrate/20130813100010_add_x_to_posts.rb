class AddXToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :text
    add_column :posts, :thumbnail_url, :string
    add_column :posts, :provider_url, :string
    add_column :posts, :author_name, :string
  end
end
