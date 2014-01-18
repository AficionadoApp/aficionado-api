class Piece < ActiveRecord::Base
  has_many :posts

  attr_accessible :accession_number

end
