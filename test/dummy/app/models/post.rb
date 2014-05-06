class Post < ActiveRecord::Base
  has_many :comments

  validates :title, :body , presence: true

end
