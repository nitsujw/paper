class Comment
  include DataMapper::Resource
  
  property :id, Serial

  property :votes, Integer
  property :words, Text
  property :parent, Integer

  belongs_to :article
  has n, :votes
  
  is :tree, :order => :votes
end
