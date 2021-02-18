class CreateCheckouts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkouts do |t|
      t.integer :borrower_id
      t.integer :borrowed_book_id
      t.datetime :checkout_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
