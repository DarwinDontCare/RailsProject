class CreateNewsletter < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletters do |t|
      t.boolean :active
      t.string :title
      t.text :content
      t.references :subscription, null: true, foreign_key: true
      t.references :author, null: false, foreign_key: { on_delete: :cascade }
      t.references :book, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end