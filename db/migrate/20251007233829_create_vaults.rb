# frozen_string_literal: true

class CreateVaults < ActiveRecord::Migration[8.0]
  def change
    create_table :vaults do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
