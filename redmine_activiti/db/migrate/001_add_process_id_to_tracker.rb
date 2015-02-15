class AddProcessIdToTracker < ActiveRecord::Migration
  def change
    add_column :trackers, :process_id, :integer
  end
end