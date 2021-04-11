class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :description, null: false
      t.datetime :clock_in, null: false
      t.datetime :clock_out
      t.boolean :visible, null: false, default: true
      t.references :user_profession, null: false, foreign_key: true

      t.timestamps
    end
  end
end
