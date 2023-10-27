class CreateReader < ActiveRecord::Migration[7.0]
  def change
    create_table :readers do |t|
      t.string :email
      t.string :password
      t.string :password_digest
      t.references :subscriptions, null: true, foreign_key: true

      t.timestamps
    end
  end
end