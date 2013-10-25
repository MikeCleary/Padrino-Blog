PadrinoBlog::App.controllers :comments do
  
  get :new do
    @comment = Comment.new
  end

  post :create do
    @comment = Comment.new(params[:comment])
    @comment.save
    redirect to url_for(:posts, :show, :id => params[:comment][:post_id])
  end

  delete :destroy do

  end
end