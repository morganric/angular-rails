class AddEmbedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :embed_code, :text
  end
end
