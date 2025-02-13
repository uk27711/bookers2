class BooksController < ApplicationController

  def new
    @new_book = Books.new
  end

  # 投稿データの保存
  def create
    @books = Books.new(books_params)
    @books.user_id = current_user.id
    if @books.save
      redirect_to books_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @books = Book.all
    @book = Book.find_by(id: params[:id]) # find_by で検索してレコードがなければ nil を返す
    if @book.nil?
      flash[:alert] = "指定された本は存在しません"
      redirect_to books_path # 本が見つからなかった場合、一覧ページにリダイレクト
    end
    @books = Book.page(params[:page]).per(10)
    end
  end

  def index
    @user = current_user
    @book = Book.page(params[:page])
    @books = Book.all
  end

  def show
    @book_id = Books.find(params[:id])
    @book = Books.new
    @books = Book.all
  end

  def destroy
    books = Books.find(params[:id])
    books.destroy
    redirect_to books_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:books).permit(:shop_name, :image, :caption)
  end

