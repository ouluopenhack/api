class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :token, index: { unique: true}, null: true
      t.integer :status, default: 0, null: false
      t.references :team, foreign_key: true, null: false

      t.timestamps
    end
  end
end
