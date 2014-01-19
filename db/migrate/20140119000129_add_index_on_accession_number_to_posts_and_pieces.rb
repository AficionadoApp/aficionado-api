class AddIndexOnAccessionNumberToPostsAndPieces < ActiveRecord::Migration
  def change
    add_index :posts, :accession_number
    add_index :pieces, :accession_number
  end
end
