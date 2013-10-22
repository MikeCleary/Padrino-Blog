require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class AuthorTest < Test::Unit::TestCase
  context "Author Model" do
    should 'construct new instance' do
      @author = Author.new
      assert_not_nil @author
    end
  end
end
