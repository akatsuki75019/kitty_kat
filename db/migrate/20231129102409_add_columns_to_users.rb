class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email_notification_enabled, :boolean
    add_column :users, :last_notified_at, :datetime
  end
end
