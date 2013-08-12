class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :provider
      t.string :media_type
      t.string :title
      t.integer :views

      t.timestamps
    end
  end
end
