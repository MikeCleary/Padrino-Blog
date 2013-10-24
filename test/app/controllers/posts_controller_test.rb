require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class PostsControllerTest < Test::Unit::TestCase
  context "PostsController" do
    setup do
      @dan = Author.create(:first_name => "Dan",
        :last_name => "Garland", :twitter => "@dmgarland")
      Post.create(:title => 'My Amazing Post', :post_date => Date.today,  
        :published => true,
        :author => @dan)
      Post.create(:title => 'My Amazinger Post', 
        :post_date => Date.today + 1, 
        :author => @dan)
      Post.create(:title => 'The Most Amazingest Post', 
        :post_date => Date.today + 2, 
        :published => true,
        :author => @dan)

      get '/posts'
    end

    should "return Posts text" do
      #assert_match /All 2 Posts/, last_response.body
      assert_match /1. My Amazing Post/, last_response.body
      #assert_match /1. The Most Amazingest Post/, last_response.body

    end
  end

  context "An individual post" do
    setup do 
      @dan = Author.create(:first_name => "Dan",
        :last_name => "Garland", :twitter => "@dmgarland")
      @post = Post.create(:title => 'My Incredible Post', 
        :content => Faker::Lorem.words(50).join(" ") + "Hello World",
        :published => true, :author => @dan)
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
        :author_id => @dan.id,
        :published => true
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

  context "Updating a post" do
    setup do
      @dan = Author.create(:first_name => "Dan",
        :last_name => "Garland", :twitter => "@dmgarland")

      @post = Post.create(
        :title => 'My Incredible Post', 
        :content => Faker::Lorem.words(50).join(" ") + "Hello World",
        :author => @dan,
        :post_date => Date.today,
        :published => true
        )

      form_parameters = { :post => {
        :title => "My Amazing Blog Post",
        :content => Faker::Lorem.words(50).join(" "),
        :author_id => @dan.id
        }
      }  
      put "/posts/update/#{@post.id}" , form_parameters
    end

    should "update a post" do
      assert_equal 1, Post.count

      @post = Post.first
      assert_equal "My Amazing Blog Post", @post.title
      assert_not_nil @post.content
      assert_equal @dan, @post.author
      assert_equal Date.today, @post.post_date
      assert_equal Date.today, @post.post_date
      assert_equal 'my-incredible-post', @post.slug
    end

    should "Redirect yout to the posts page" do
      assert_equal 302, last_response.status
      follow_redirect!
      assert_equal '/posts/1', last_request.path
    end
  end

  context "Destroy a post" do
    setup do
      @dan = Author.create(:first_name => "Dan",
        :last_name => "Garland", :twitter => "@dmgarland")
      @post = Post.create(:title => 'My Incredible Post', 
        :content => Faker::Lorem.words(50).join(" ") + "Hello World", 
        :author_id => @dan.id)

      delete "/posts/#{@post.id}"
    end

    should "Redirect to the posts index page" do
      assert_equal 302, last_response.status
      follow_redirect!
      assert_equal '/posts', last_request.path
    end

    should "delete post" do
      assert_equal 0, Post.count
    end
  end

  context "List all Posts by Tag" do
    setup do
      @dan = Author.create(
        :first_name => "Dan",
        :last_name => "Garland", 
        :twitter => "@dmgarland")
      @amazing_post = Post.create(
        :title => 'My Amazing Post',
        :post_date => Date.today, 
        :author => @dan)
      @amazing_post.tags << Tag.create(:name => "Ruby", :popularity => 1)
      @amazing_post.save

      @astounding_post = Post.new(:title => "My Astounding Post",
        :post_date => Date.today)
      @astounding_post.tags << Tag.create(:name => "Active Record", :popularity => 1)
      @astounding_post.save

      get '/posts/tagged/ruby'
    end

    should "show me the post tagged Ruby" do 
      assert_match /My Amazing Post/, last_response.body
      assert_no_match /My Astounding Post/, last_response.body
    end
  end
     
   context "List all Posts by Author" do
     setup do
       @dan = Author.create(
         :first_name => "Dan",
         :last_name => "Garland", 
         :twitter => "@dmgarland",)

       @post = Post.create(
         :title => "My Incredible Post",
         :content => "Hello World", 
         :author => @dan, 
         :published => true)
      
       get "/posts/by/#{@dan.id}"
     end

     should "show me Dan's posts" do 
       assert_match /My Incredible Post/, last_response.body
     end
   end   
end