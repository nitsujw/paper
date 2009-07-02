# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see merb/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
class User
  include DataMapper::Resource
  
  property :id,     Serial
  property :login,  String
  property :email, String, :nullable => false, :unique => true, :format => :email_address,
                             :messages => {
                               :presence => "Email address is blank.",
                               :is_unique => "We already have that email.",
                               :format => "Email address is not in the correct format"
                             }
  has n, :roles
  has n, :writings
  has n, :articles
  has n, :votes
  
  def vote_for(votable_thing)
    vote = Vote.first(:user_id => self.id, :votable_id => votable_thing.id, :votable_type => votable_thing.class.to_s)
    vote.vote if vote
  end
end
