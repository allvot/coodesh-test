class CreateApiKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :api_keys do |t|
      t.text :key
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
