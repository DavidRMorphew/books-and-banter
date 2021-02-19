class RemoveColumnRecommmendToReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :recommmend
  end
end
