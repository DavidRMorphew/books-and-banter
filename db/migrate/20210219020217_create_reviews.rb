class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewed_book_id
      t.integer :rating
      t.string :title
      t.text :content
      t.boolean :recommmend
      t.boolean :kid_friendly

      t.timestamps
    end
  end
end
