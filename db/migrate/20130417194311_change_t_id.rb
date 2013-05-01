class ChangeTId < ActiveRecord::Migration
  def change
    change_column :tweets, :t_id, :integer, limit: 8
  end
end
