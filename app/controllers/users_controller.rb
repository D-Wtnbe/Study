class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

   def index
     @users = User.page(params[:page]).per(10)
     @micropost = current_user.microposts.build if logged_in?

      @users = User.all

      @search = User.search(params[:q])
      @users = @search.result(distinct: true)
      end


   def show
     @user = User.find(params[:id])
     @micropost = current_user.microposts.build if logged_in?
     @microposts = @user.microposts.paginate(page: params[:page])
   end
   def new
     @user = User.new
   end
   def edit
     @user = User.find(params[:id])
   end
   def create
     @user = User.new(user_params)
     if @user.save
       log_in @user
       flash[:success] = "ようこそ！"
       redirect_to @user
     else
       render 'new'
     end
   end

#プロフィール更新
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
    render 'edit'
  end

  end

  def destroy
 @user = User.find(params[:id])
 @user.destroy
 redirect_to login_url
 end

#ログインしているかを確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
end


 private
 def user_params
  params.require(:user).permit(:userid,:name,:gender,:birthday,:email,:password, :password_confirmation, :image, :image_cache, :remove_image, :prefecture_code, :prefecture_name)
end

end
