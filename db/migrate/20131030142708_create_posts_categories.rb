class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
    	t.integer :post_id
    	t.integer :category_id
    end

    add_index :posts_categories, :post_id
    add_index :posts_categories, :category_id
  end
end
