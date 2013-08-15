class AddTweetsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tweets, :integer
  end
end
