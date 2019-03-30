class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :status, default: 0, null: false
      t.string :token, index: { unique: true}, null: true

      t.timestamps
    end
  end
end
