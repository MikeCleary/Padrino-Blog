require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class AuthorTest < Test::Unit::TestCase
  context "Author Model" do

    setup do
      @author = Author.new(:first_name =>"Dan", :last_name => "Garland",
       :twitter => "@dmgarland")
      @author.posts << Post.new(:title => "My amazing blog", :content => "Blah",
       :post_date => Time.now)
      @author.save!
      @author.reload
    end

    should 'save to the database correctly' do
      assert_equal "Dan", @author.first_name
      assert_equal "Garland", @author.last_name
      assert_equal "@dmgarland", @author.twitter
      assert_equal 1, @author.posts.length
      assert_equal Post, @author.posts.first.class
      assert_equal @author, @author,posts.first.author

    end
  end
end
