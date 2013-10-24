PadrinoBlog::App.controllers :posts do

  layout :main
    
  get :index, :map => '/posts' do
    @posts = Post.published.posted_before(Date.today)
    render 'posts/index'
  end

  get :new, :map => '/posts/new' do
    @authors = Author.all.map{|a| [a.first_name , a.id ]}
    @post = Post.new
    render 'posts/new'
  end

  get :show, :with => :id, :map => '/posts' do
    @post = Post.published.find(params[:id])
    render 'posts/show'
  end

  post :create do
    p = Post.new(params[:post])
    p.post_date = Date.today
    p.slug = p.get_slug(p.title)
    p.save
    p.reload
    redirect to url_for(:posts, :show, :id => p.id)
  end

  get :edit, :with => :id, :map => '/posts/edit' do
    @post = Post.find(params[:id])
    render 'posts/edit'
  end

  put :update, :with => :id, :map => '/posts/update' do
    p = Post.find(params[:id])
    p.slug = p.get_slug(params[:post][:title])
    p.update_attributes(params[:post])
    p.save
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
  end

  # get 'tagged/by/', :with => :tag do
  #   @posts = Tag.where(:name => ?, params[:tag]).posts.publihsed
  #   render 'post/index'
  # end
end
