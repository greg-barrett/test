class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  #post.author= author
  has_many :comments, :dependent => :destroy
  #post.comments- all the comments
  has_many :likes, class_name: 'PostLike', :dependent => :destroy
  #post.likes- number of likes
  has_many :likers, through: 'likes', source: 'user'
  #post.likers=users how liked it
  default_scope -> { order(created_at: :desc) }

  def liked?(user)
    likers.include?(user)
  end
end
