class Comment
  include DataMapper::Resource
  
  property :id, Serial

  property :votes, Integer
  property :words, Text
  property :points, Integer

  belongs_to :article
  has n, :votes
  
  is :tree, :order => :votes
end