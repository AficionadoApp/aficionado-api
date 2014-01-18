class Post < ActiveRecord::Base
  belongs_to :piece
  attr_accessible :name, :comment, :accession_number

  validates :piece_id, presence: true
  validates :name, presence: true
  validates :comment, presence: true, length: { maximum: 140 }

  def to_json
    {
      name: name,
      comment: comment,
      time: created_at.to_s
    }
  end
end
