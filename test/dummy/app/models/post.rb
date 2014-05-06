class Post < ActiveRecord::Base
  has_many :comments

  validates :title, :body , presence: true


  def valid?(ccc)
    false
  end

end
