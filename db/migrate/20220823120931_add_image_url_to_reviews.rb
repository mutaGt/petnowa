class AddImageUrlToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :image_url, :string
  end
end
