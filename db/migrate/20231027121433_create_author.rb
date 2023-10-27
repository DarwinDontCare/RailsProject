class CreateAuthor < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :email
      t.string :birth_date
      t.references :books, null: true, foreign_key: true
      t.references :newsletters, null: true, foreign_key: true

      t.timestamps
    end
  end
end