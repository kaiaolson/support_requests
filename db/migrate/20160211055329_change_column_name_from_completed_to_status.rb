class ChangeColumnNameFromCompletedToStatus < ActiveRecord::Migration
  def change
    rename_column :support_requests, :completed, :status
  end
end
