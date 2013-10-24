PadrinoBlog::App.controllers :posts do

  layout :main
    
  get :index, :map => '/posts' do
    @posts = Post.published.posted_before(Date.today)
    render 'posts/index'
  end

  get :new, :map => '/posts/new' do
    @authors = Author.all.map{|a| [a.first_name , a.id ]}
    @tags = Tag.all.map{|t| [t.name , t.id ]}
    @post = Post.new
    render 'posts/new'
  end

  get :show, :with => :id, :map => '/posts' do
    @post = Post.published.find(params[:id])
    @comment = Comment.new
    @comment.post = @post
    render 'posts/show'
  end

  post :create do
    @post = Post.new(params[:post])
    if @post.save
      redirect to url_for(:posts, :show, :id => @post.id)
    else
      @authors = Author.all.map{|a| [a.first_name , a.id ]}
      render 'posts/new'
    end    
  end

  get :edit, :with => :id, :map => '/posts/edit' do
    @tags = Tag.all.map{|t| [t.name , t.id ]}
    @post = Post.find(params[:id])
    render 'posts/edit'
  end

  put :update, :with => :id, :map => '/posts/update' do
    p = Post.find(params[:id])
    p.update_attributes(params[:post])
    redirect to url_for(:posts, :show, :id => p.id)
  end

  delete :destroy, :with => :id, :map => '/posts' do
    @post = Post.find(params[:id])
    @post.destroy
    redirect to url_for(:posts, :index)
  end

  get :tagged, :with => :tag, :map => '/posts/tagged' do
    @posts = Post.includes(:tags).where("tags.name =?", params[:tag].capitalize!)
    render 'posts/index'
  #OR
  # get :tagged, :with => :tag, :map => '/posts/tagged' do
  #   @posts = Tag.where("name =?", params[:tag].capitalize!).first.posts
  #   render 'posts/index'
  end

  get :author, :with => :author_id, :map => 'posts/by' do
    @posts = Author.find_by_id(params[:author_id]).posts
    render 'posts/index'
  end

end
