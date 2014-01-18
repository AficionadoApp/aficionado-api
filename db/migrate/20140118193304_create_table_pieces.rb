class CreateTablePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :accession_number
      t.timestamps
    end
  end
end
