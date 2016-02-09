class AddColumnToSupportRequests < ActiveRecord::Migration
  def change
    add_column :support_requests, :completed, :string
  end
end
