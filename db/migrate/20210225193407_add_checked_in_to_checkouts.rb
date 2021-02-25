class AddCheckedInToCheckouts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkouts, :checked_in, :boolean, default: false
  end
end
