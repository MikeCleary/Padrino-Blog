require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class PostsControllerTest < Test::Unit::TestCase
  context "PostsController" do
    setup do
      Post.create(:title => 'My Amazing Post', :post_date => Date.today)
      Post.create(:title => 'My Amazinger Post', :post_date => Date.today + 1)
      Post.create(:title => 'The Most Amazingest Post', :post_date => Date.today + 2)

      get '/posts'
    end

    should "return Posts text" do
      assert_match /All 3 Posts/, last_response.body
      assert_match /3. My Amazing Post/, last_response.body
      assert_match /2. My Amazinger Post/, last_response.body
      assert_match /1. The Most Amazingest Post/, last_response.body

    end
  end

  context "An individual post" do
    setup do 
      @post = Post.create(:title => 'My Incredible Post', 
        :content => Faker::Lorem.words(50).join(" ") + "Hello World")

      get "/posts/#{@post.id}"
    end
    
    should "show that post" do
      assert_match /My Incredible Post/, last_response.body
      assert_match /<div id=\"content\">/, last_response.body
      assert_match /Hello World/, last_response.body
    end
  end

  context "The new post page" do
    should "work" do
      get '/posts/new'
      assert last_response.ok?
    end
  end
 
  context "Creating a post" do
      setup do
        @dan = Author.create(:first_name => "Dan",
        :last_name => "Garland", :twitter => "@dmgarland")

      form_parameters = { :post => {
        :title => "My Amazing Blog Post",
        :content => Faker::Lorem.words(50).join(" "),
        :author_id => @dan.id
        }
      }

      post '/posts/create', form_parameters
    end

    should "create a post" do

      assert_equal 1, Post.count

      @post = Post.first
      assert_equal "My Amazing Blog Post", @post.title
      assert_not_nil @post.content
      assert_equal @dan, @post.author
      assert_equal Date.today, @post.post_date
      assert_equal 'my-amazing-blog-post', @post.slug
    end

    should "Redirect yout to the posts page" do
      assert_equal 302, last_response.status
      follow_redirect!
      assert_equal '/posts/1', last_request.path
    end
  end
end
