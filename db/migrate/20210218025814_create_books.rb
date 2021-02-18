class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :authors
      t.string :isbn
      t.string :title
      t.string :description
      t.string :publisher
      t.string :publication_date
      t.string :categories

      t.timestamps
    end
  end
end
