class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :status, null: false, default: 'staff'

      t.timestamps
    end
  end
end
