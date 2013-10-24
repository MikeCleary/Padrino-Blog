class Post < ActiveRecord::Base

  belongs_to :author
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags

  scope :published, where(:published => true).order("post_date DESC")
  scope :posted_before, Proc.new{ |time| where('post_date <= ?', time)}

  validates :title, :presence => true
  validates :title, :length => { :minimum => 10, :maximum => 255 } 
  # OR
  # validates :title, :length => { :in => 10..255 }
  validates_each :post_date do |post, post_date, date|
    if date 
      if date >= Date.today
        true
      else
        post.errors.add(post_date, 'Publishing date must be today or later')
      end
    else
      post.errors.add(post_date, 'Post must have publishing date')
    end
  end

  validates_each :author_id do |record, attribute, value|
    if Author.find_by_id(value)
      true
    else
      record.errors.add(attribute, 'Must be a registered author')
    end
  end

  def get_slug
    self.slug = self.title.downcase.gsub(" ", "-")
  end
  
  before_create do  
    get_slug
  end

  before_validation do
    self.post_date = Date.today
  end


# has title 
# has to post_date atleast today
# has author


end
