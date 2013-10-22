class Comment < ActiveRecord::Base
  belongs_to :post
  has_many :replies, :class_name => 'Comment'
end
