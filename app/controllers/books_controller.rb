class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def new
    @book = Book.new
    @book_new = Book.new
    @user = current_user
  end

  # 投稿データの保存
  def create
    @book_new = Book.new(book_params)
    if @book_new.save
      redirect_to book_path(@book_new), notice: 'Book was successfully created.'
    else
      render :show, alert: 'Failed to create the book.'
    end
  end

  def update
    # 更新処理
    if @book.update(book_params)
      redirect_to book_path, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    @user = current_user
    @books = Book.all
    @book = Book.find(params[:id]) # find_by で検索してレコードがなければ nil を返す
    if @book.nil?
      flash[:alert] = "指定された本は存在しません"
      redirect_to books_path # 本が見つからなかった場合、一覧ページにリダイレクト
    end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])  # 既存の本を表示
    @book_new = Book.new  #本来はBook.newにしていた。# 新しい本のインスタンスを作成
    @user = @book.user #メンターが追記
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'  # 削除後、indexにリダイレクト
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
