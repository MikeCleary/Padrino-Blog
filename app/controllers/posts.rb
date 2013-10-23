PadrinoBlog::App.controllers :posts do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :index, :map => '/posts' do
    @posts = Post.all
    render 'posts/index'
  end

  get :show, :with => :id, :map => '/post' do
    @post = Post.find(params[:id])
    render 'posts/show'
  end

  get :new do
    @post = Post.new
    erb :new
  end

  post :create do

  end

  get :edit do

  end

  put :update do

  end

  delete :destroy do

  end

end
