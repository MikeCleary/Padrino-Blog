class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  #validates :popularity, :numericality => {:only_integer => true, :greater_than => 0, :less_than_or_equal_to => 10}

end


