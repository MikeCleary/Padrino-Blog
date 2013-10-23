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

post = Post.new(:title => 'About Active Record Queries', :content => 'WIP', 
  :post_date => Date.today, :author => dan)

3.times {
  post.comments << Comment.create(:content => 'Nice', :comment_date => Date.today)
}

post.tags << padrino
post.save