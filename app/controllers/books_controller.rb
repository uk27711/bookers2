class BooksController < ApplicationController

  def new
    @book_new = Book.new
    @user = current_user
  end

  # 投稿データの保存
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new), notice: 'Book was successfully created.'
    else
      render :show, alert: 'Failed to create the book.'
    end
  end

  def update
    # 更新処理
    @book = Book.find(params[:id])
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
    elsif @book.user == current_user
      @book_new = @book
    else
      flash[:alert] = "編集権限がありません"
      redirect_to book_path
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
    @user = current_user
    if @book.nil?
      flash[:alert] = "指定された本は存在しません"
      redirect_to book_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path, notice: 'Book was successfully deleted.'  # 削除後、indexにリダイレクト
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
