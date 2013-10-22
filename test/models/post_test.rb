require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PostTest < Test::Unit::TestCase
  context "Post Model" do
    setup do
      @post = Post.new(:title => "My amazing blog", :content => "Blah",
      :post_date => Time.now)

      @post.author = Author.new(:first_name =>"Dan", :last_name => "Garland",
       :twitter => "@dmgarland")

      @post.tags << Tag.new(:name => "Active Record")
      @post.comments << Comment.new(:content => "What a great post", 
        :post_date => Time.now)

      @post.save!
      @post.reload
    end

    should "save a post correctly" do
      assert_equal "My amazing blog", @post.title
      assert_equal "Blah", @post.content
      assert_equal "Dan", @post.author.first_name
      assert_equal "Garland", @post.author.last_name
      assert_equal "@dmgarland", @post.author.twitter
      assert_equal "Active Record", @post.tags.first.name
      assert_equal "What a great post", @post.comments.first.content
    end
  end
end
