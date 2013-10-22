require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class TagTest < Test::Unit::TestCase
  context "Tag Model" do
    setup do
      @post = Post.new(:title => "My amazing blog", :content => "Blah",
       :post_date => Time.now)

      @ar = Tag.new(:name => "Active Record")
      @ruby = Tag.new(:name => "Ruby")
      @sql = Tag.new(:name => "SQL")

      @ar.save!
      @ar.reload

      @ruby.save!
      @ruby.reload

      @sql.save!
      @sql.reload
    end

    should "be able to add multiple tags to a Post" do
      @post.tags << @ar
      @post.tags << @ruby
      @post.tags << @sql
      @post.save!
      @post.reload

      assert_equal 3, @post.tags.length
      binding.pry
      assert_equal @sql, @post.tags[0]
      assert_equal @ruby, @post.tags[1]
      assert_equal @ar, @post.tags[2]
      ##read about order option
    end
  end
end
