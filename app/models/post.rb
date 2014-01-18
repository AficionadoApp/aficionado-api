class Post < ActiveRecord::Base
  belongs_to :piece

  def to_json
    {
      name: name,
      comment: comment,
      time: created_at.to_s
    }
  end

end
