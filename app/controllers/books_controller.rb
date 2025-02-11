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

  def index
    @user = current_user
    @books = Book.page(params[:page])
  end

  def show
    @books = Books.find(params[:id])
    @books = Books.new
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

end