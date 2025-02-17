class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
    @book_new = Book.new
    @book = Book.find_by(id: params[:book_id])
  end

  def index
    @user = current_user
    @books = Book.page(params[:page])
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
    @books = Book.all
    @books = Book.page(params[:page]).per(10)
  end

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
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id) 
    else 
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end

end
