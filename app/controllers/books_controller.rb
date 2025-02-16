class BooksController < ApplicationController

  def new
    @book = Book.new
    @user = current_user
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def book_params
    params.require(:book).permit(:title, :body) # Replace with actual book fields
  end


  def edit
    @user = current_user
    @books = Book.all
    @book = Book.find_by(id: params[:id]) # find_by で検索してレコードがなければ nil を返す
    if @book.nil?
      flash[:alert] = "指定された本は存在しません"
      redirect_to books_path # 本が見つからなかった場合、一覧ページにリダイレクト
    end
    @book = Book.page(params[:page]).per(10)
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book_id = Book.find(params[:id])
    @book = Book.new
    @books = Book.all
  end

  def destroy
    books = Book.find(params[:id])
    books.destroy
    redirect_to books_path
  end

  # 投稿データのストロングパラメータ
  private
  
  def book_params
    params.require(:book).permit(:body, :title)
  end
end
