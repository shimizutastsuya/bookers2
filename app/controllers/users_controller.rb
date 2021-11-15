class UsersController < ApplicationController
  def show
        @user = User.find(params[:id])
        @book = Book.new
        @books = @user.books
  end

  def edit
        @user = User.find(params[:id])
        if @user == current_user
            render "edit"
        else
            redirect_to user_path(current_user)
        end
  end

  def update
        @user = User.find(params[:id])
        @user.id = current_user.id
        if @user.update(user_params)
            flash[:notice]="You have updated user successfully."
            redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
        else
            render "edit"
        end
  end

  def index
        @users = User.all
        @book = Book.new
        @user = User.find(current_user.id)
  end

    def user_params
        params.require(:user).permit(:profile_image, :name, :introduction)
    end

    def ensure_correct_user #[]にはURLを打ったらユーザー詳細に返す
        @user = User.find(params[:id])
        unless @user == current_user
            redirect_to user_path(current_user)
        end
    end
end
