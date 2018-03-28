class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_integrity_of  :image
  validates_processing_of :image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]


  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id', :dependent => :destroy
  #posts they have written
  has_many :authored_comments, class_name: 'Comment', foreign_key: 'author_id', :dependent => :destroy
  #retuns the comments they wrote
  has_many :post_likes, :dependent => :destroy
  #returns the number of posts they like
  has_many :liked_posts, through: 'post_likes', source: 'post'
  #returns the actual posts they like.
  has_many :comment_likes
  has_many :liked_comments, through: 'comment_likes', source: 'comment'
  #Friend Requests
  #returns all the requests a user has sent
  has_many :issued_requests, class_name: "FriendRequest", foreign_key: "requester_id", :dependent => :destroy
  #returns all the requests a user has recieved
  has_many :received_requests, class_name: "FriendRequest", foreign_key: "requested_id", :dependent => :destroy
  #returns the names of the users a user wants to be friend with
  has_many :pending_friendees, through: :issued_requests, source: :requested
  #returns the names of the people who have requested friendships
  has_many :pending_frienders, through: :received_requests, source: :requester
  #Friendships
  has_many :friendships, foreign_key: 'friender_id', :dependent => :destroy
  has_many :friends, through: :friendships, source: :friendee
  default_scope -> { order(name: :asc) }

  def friends?(user)
    self.friends.include?(user)
  end

  def received_request_pending?(user)
    self.pending_frienders.include?(user)
  end

  def notifactions?
    pending_frienders.count
  end

  def sent_request_pending?(user)
    self.pending_friendees.include?(user)
  end

  def is?(user)
    true if self==user
  end
  private
    def image_size_validation
      errors[image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end

end
