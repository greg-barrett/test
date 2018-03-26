# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Comment.delete_all
CommentLike.delete_all
FriendRequest.delete_all
Friendship.delete_all
PostLike.delete_all
Post.delete_all

greg=User.create(name:"Gregory Barrett", email:"greg@msn.com", password: "123456" )
adam= User.create(name:"Adam Wells-Burrow", email:"adam@msn.com", password: "123456" )
mary= User.create(name:"Mary Smith", email:"mary@msn.com", password: "123456" )
ingrid=User.create(name:"Ingrid March", email:"ingrid@msn.com", password: "123456" )
jose=User.create(name:"Jose Ignesias", email:"jose@msn.com", password: "123456" )
jane=User.create(name:"Jane dot", email:"jane@msn.com", password: "123456" )

people=[ mary, ingrid, jose, jane]
other_people=[greg, adam]
one=Post.create(content: "This is my first post", author_id:greg.id)
two=Post.create(content: "This is a nice story", author_id:adam.id)
three=Post.create(content: "Gardening diaries", author_id:mary.id)
four=Post.create(content: "Books about oranges", author_id:ingrid.id)
five=Post.create(content: "I want to watch something ", author_id:jose.id)
six=Post.create(content: "Stories are lots of words", author_id:jane.id)
posts=[one, two, three, four, five, six]
#create likes
people.each do |person|
  posts.each do |post|
    PostLike.create(post_id:post.id, user_id:person.id)
    Comment.create(content:"Wow this is inspired", post_id:post.id, author_id:person.id)
  end
end
#create comments

other_people.each do |people|
  posts.each do |post|
    Comment.create(content:"I don't like it", post_id:post.id, author_id:people.id)
  end
end

comments=Comment.all

comments.each do |comment|
  people.each do |person|
    CommentLike.create(comment_id:comment.id, user_id:person.id)
  end
end

other_people.each do |us|
  people.each do |person|
    FriendRequest.create(requester_id: us.id, requested_id: person.id)
  end
end

other_people.each do |us|
  people.each do |person|
    Friendship.create(friender_id: us.id, friendee_id: person.id)
    Friendship.create(friender_id: person.id, friendee_id: us.id)
  end
end
