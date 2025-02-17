class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def new
    @book = Book.new
    @user = current_user
  end

  # 投稿データの保存
  def create
    @book = current_user.books.build(book_params)
    @book.user_id = current_user.id
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path, notice: 'Book was successfully created.'
    else
      redirect_to user_path(current_user), alert: 'Failed to create the book.'
    end
  end

  def update
    # 更新処理
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
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
    @books = Book.all
    @book = Book.find(params[:id])
    @book_new = Book.new  #本来はBook.newにしていた。
    @user = @book.user #メンターが追記
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'  # 削除後、indexにリダイレクト
  end

  # 投稿データのストロングパラメータ
  private
  
  def set_book
    @book = Book.find(params[:id])  # BookのIDを基に取得
  end

  def book_params
    params.require(:book).permit(:body, :title)
  end
end
