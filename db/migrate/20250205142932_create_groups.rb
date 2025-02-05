class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer "user_id", null: false
      t.string :name, null: false
      t.string :introduction, null: false

      t.timestamps
    end
  end
end
