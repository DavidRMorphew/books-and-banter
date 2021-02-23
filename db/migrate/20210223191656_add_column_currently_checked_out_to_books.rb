class AddColumnCurrentlyCheckedOutToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :currently_checked_out, :boolean
  end
end
