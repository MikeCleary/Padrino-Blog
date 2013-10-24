# Creating active record models

#two options for preventing duplicates. 
#Tag.destroy_all
#Tag.find_or_create_by_name("Ruby")

# Shorthand for :
# t= Tag,new(:name => 'Ruby')
# t.save

Tag.find_or_create_by_name('Ruby')
padrino = Tag.find_or_create_by_name('Padrino')
Tag.find_or_create_by_name('ActiveRecord')
Tag.find_or_create_by_name('SQL')
Tag.find_or_create_by_name('wegotcoders')

Author.destroy_all
Post.destroy_all
Comment.destroy_all

dan = Author.create(:first_name => 'Dan', :last_name => 'Garland', 
  :twitter => '@dmgarland', :email => 'dan@wegotcoders.com', 
  :github => 'dmgarland')

mike = Author.create(:first_name => 'mike', :last_name => 'cleary', 
  :twitter => '@magnifico', :email => 'mike@wegotcoders.com', 
  :github => 'mikeCleary')

joe = Author.create(:first_name => 'Joe', :last_name => 'Dickinson', 
  :twitter => '@joeheadycus', :email => 'joe@wegotcoders.com', 
  :github => 'JoeDicky')


5.times {
  Post.create(:title =>  Faker::Lorem.words(10).join(" "), :content => Faker::Lorem.words(50).join(" "), 
  :post_date => Date.today, :author => dan, :published => true)
}

post = Post.new(:title =>  "With comments", :content => Faker::Lorem.words(50).join(" "), 
  :post_date => Date.today, :author => dan, :published => true)
binding.pry
3.times {
  post.comments << Comment.create(:content => 'Nice', :comment_date => Date.today)
}

post.tags << padrino
post.save