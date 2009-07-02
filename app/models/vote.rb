class Vote
  include DataMapper::Resource
  
  property :id, Serial
  property :user_id, Integer, :nullable => false, :index => [:user_id_votable_id_votable_type, true]
  property :votable_id, Integer, :nullable => false, :index => [:user_id_votable_id_votable_type, :votable_id_votable_type]
  property :votable_type, String, :nullable => false, :index => [:user_id_votable_id_votable_type, :votable_id_votable_type]
  property :vote, Integer, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :article, :class_name => "Article", :child_key => [:votable_id]
  belongs_to :user

end