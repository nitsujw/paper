class Vote
  include DataMapper::Resource
  after :destroy, :calculate_new_rating
  
  property :id, Serial
  property :user_id, Integer, :nullable => false, :index => [:user_id_votable_id_votable_type, true]
  property :votable_id, Integer, :nullable => false, :index => [:user_id_votable_id_votable_type, :votable_id_votable_type]
  property :votable_type, String, :nullable => false, :index => [:user_id_votable_id_votable_type, :votable_id_votable_type]
  property :vote, Integer, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :article, :class_name => "Article", :child_key => [:votable_id]
  belongs_to :user
  
  def calculate_new_rating
    parent = Kernel.const_get(votable_type).get(votable_id)
    up_votes = Vote.all(:votable_type => parent.class, :votable_id => parent.id, :vote => 1).count
    down_votes = Vote.all(:votable_type => parent.class, :votable_id => parent.id, :vote => -1).count
    parent.up_votes, parent.down_votes, parent.points = up_votes, down_votes, (up_votes-down_votes)
    parent.save
  end
end