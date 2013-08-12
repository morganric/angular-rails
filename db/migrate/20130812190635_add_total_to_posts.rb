class AddTotalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :total, :integer
    add_column :posts, :increases, :integer
  end
end
