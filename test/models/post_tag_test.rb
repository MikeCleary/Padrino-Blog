require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PostTagTest < Test::Unit::TestCase
  context "PostTag Model" do
    should 'construct new instance' do
      @post_tag = PostTag.new
      assert_not_nil @post_tag
    end
  end
end
