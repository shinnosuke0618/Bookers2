class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @book = Book.new
    @books = Book.all
  end


  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
    flash[:complete] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
    @books.user_id = current_user.id
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to '/books'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:complete] = "You have updated book successfully."
     redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
