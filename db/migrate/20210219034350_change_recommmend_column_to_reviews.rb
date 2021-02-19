class ChangeRecommmendColumnToReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :recommmend
  end

  def change
    add_column :reviews, :recommend, :boolean
  end
end
