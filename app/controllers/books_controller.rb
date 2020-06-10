class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_book, {only:[:edit]}
  def create
      @user = User.find(current_user.id)
      @book = current_user.books.new(book_params)
      if @book.save
        flash[:notice] = "Book was successfully"
        redirect_to book_path(@book)
      else
        @books = Book.all
        render "index"
      end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @user = Book.find(params[:id]).user
    @book_detail = Book.find(params[:id])
    @books = Book.all
    @book = Book.new
  end

  def new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully"
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  def authenticate_book
      book = Book.find(params[:id])
      if book.user_id != current_user.id
      redirect_to books_path
      end
  end
end
