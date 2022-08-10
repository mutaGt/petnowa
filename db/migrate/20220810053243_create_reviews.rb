class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :member_id, null: false
      t.string :product_name, null: false
      t.string :title, null: false
      t.integer :evaluation, null: false
      t.text :review_content, null: false

      t.timestamps
    end
  end
end
