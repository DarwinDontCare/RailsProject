class CreateBook < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.references :author, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end