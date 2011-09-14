class AddStatusToMembers < ActiveRecord::Migration
  def change
    add_column :members, :status, :string
  end
end
