require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class PostsControllerTest < Test::Unit::TestCase
  context "PostsController" do
    setup do
      3.times {Post.create(:title => 'My Amazing Post') }

      get '/posts'
    end

    should "return Posts text" do
      assert_match "All 3 Posts", last_response.body
      assert_match "My Amazing Post", last_response.body
    end
  end

  context "An individual post" do

  end

end
