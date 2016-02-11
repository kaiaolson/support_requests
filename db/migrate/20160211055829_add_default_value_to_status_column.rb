class AddDefaultValueToStatusColumn < ActiveRecord::Migration
  def change
    change_column :support_requests, :status, :string, default: "Not Done"
  end
end
