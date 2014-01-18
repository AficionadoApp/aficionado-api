class CreateTablePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :piece
      t.string :name
      t.text :comment
      t.string :accession_number

      t.timestamps
    end
  end
end
