PadrinoBlog::App.controllers :comments do
  
  get :new do
    @comment = Comment.new
  end

  post :create do
    binding.pry
    @comment = Comment.new(params[:comment])
    binding.pry
    @comment.save
    binding.pry
    redirect to url_for(:posts, :show, :id => params[:post_id])
  end

  delete :destroy do

  end
end