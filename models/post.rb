class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags, :order => "tags.created_at DESC, tags.id DESC"

  def get_slug(title)
    title.downcase.gsub(" ", "-")
  end

  scope :published, where(:published => true).order("post_date DESC")
  scope :posted_before, Proc.new{ |time| where('post_date <= ?', time)}
end
