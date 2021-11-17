class BooksController < ApplicationController
  def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id #投稿時ログインしているユーザーのidを保存する記述
        if @book.save
           flash[:notice]="You have created book successfully."
           redirect_to book_path(@book) #詳細表示画面へ
        else
           @books = Book.all #renderでindexページを呼び出すなら、indexで定義されている変数も一緒に持ってくること
           @user = User.find(current_user.id)
           render "index"
        end
  end

  def show
        @book = Book.find(params[:id])
        @book_new = Book.new
        @user = @book.user
        @book_comment = BookComment.new
  end

  def index
    @books=Book.all
    @book=Book.new
    @user = User.find(current_user.id)
  end

  def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
  end

  def update
       @book = Book.find(params[:id])
        @book.user_id = current_user.id
        if @book.update(book_params)
           flash[:notice]="You have updated book successfully."
           redirect_to book_path(@book), notice: 'You have updated book successfully.'
        else
           render "edit"
        end
  end

  def edit
        @book = Book.find(params[:id])
        if @book.user == current_user #URLを入力しても画面に飛ばせない
           render "edit"
        else
           redirect_to books_path
        end
  end

    private

    def book_params
        params.require(:book).permit(:title, :body)
    end
end
