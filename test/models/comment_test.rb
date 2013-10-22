require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CommentTest < Test::Unit::TestCase
  context "Comment Model" do
    setup do
      @comment = Comment.new(:content => "What a great post", :comment_date => Time.now)
      
      @post = Post.new(:title => "My amazing blog", :post_date => Time.now)
      @post.comments << @comment
      @post.save!
      @post.reload
    end

    should 'save to the database correctly' do
      assert_equal "What a great post", @comment.content
      assert_equal @post, @comment.post
    end

    context "replies" do
      setup do
        @reply = Comment.new(:content => "ur Hitler", :comment_date => Time.now)
        @comment.replies << @reply 
        @comment.save!
        @comment.reload
      end

      should "be listed as a reply" do
        assert_equal 1,  @comment.replies.length
        assert_equal Comment, @comment.replies.first.class
        assert_equal "ur Hitler", @comment.replies.first.content
      end
    end
  end
end