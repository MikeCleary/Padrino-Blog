require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class CommentsControllerTest < Test::Unit::TestCase
  context "CommentsController" do
    setup do
      
      form_parameters = { :comment => {
        :content => 'Nice', 
        :comment_date => Date.today
        }
      }
       post '/comments/create', form_parameters
    end

    should "be a comment" do
      assert_equal 1, Comment.count
    end
  end
end
