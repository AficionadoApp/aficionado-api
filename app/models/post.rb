class Post < ActiveRecord::Base
  belongs_to :piece

  attr_accessible :accession_number, :name, :comment, :piece_id

  validates :piece_id, presence: true
  validates :name, presence: true
  validates :comment, presence: true, length: { maximum: 140 }
end
