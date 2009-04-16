class Article
  include DataMapper::Resource
  
  property :id, Serial

  property :title, String
  property :description, Text
  property :link, Text
  property :points, Integer, :nullable => false, :default => 0
  property :up_votes, Integer, :nullable => false, :default => 0
  property :down_votes, Integer, :nullable => false, :default => 0

  belongs_to :user
  has n, :writings
  has n, :comments
  has n, :votes, :class_name => "Vote", :child_key => [:votable_id], :votable_type => self.to_s
end