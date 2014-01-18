class Post < ActiveRecord::Base
  belongs_to :piece
  attr_accessible :name, :comment, :accession_number

  def to_json
    {
      name: name,
      comment: comment,
      time: created_at.to_s
    }
  end

end
