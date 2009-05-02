class Writing
  include DataMapper::Resource
  
  property :id, Serial

  property :title, String
  property :piece, Text

  belongs_to :article
  belongs_to :user
  has n, :comments
end
