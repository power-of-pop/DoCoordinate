class GroupComment < ActiveRecord::Migration[6.1]
  def change
    drop_table :group_comments
  end
end
