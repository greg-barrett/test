class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  has_many :likes, class_name: 'CommentLike', :dependent => :destroy
  #comment.likes- number of likes
  has_many :likers, through: 'likes', source: 'user'
  #comment.likers=users how liked it
end
