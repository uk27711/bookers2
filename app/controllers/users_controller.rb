class UsersController < ApplicationController

  def new
    @book = Book.new
    @book_new = Book.new
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to book_path(@book_new), notice: 'You have updated user successfully.'
    else
      render :show, alert: 'Failed to update user.'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else 
      render :edit, alert: 'Failed to update user.'
    end
  end

  def edit
    @user = User.find(params[:id])
    @books = Book.all
    @books = Book.page(params[:page]).per(10)
  end

  def index
    @user = current_user
    @books = Book.all
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
    @book = Book.find_by(id: params[:book_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end

