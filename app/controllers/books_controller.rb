class BooksController < ApplicationController
  impressionist :actions=> [:index,:show]
  
  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
    
    @ranks = Book.includes(:favorite_users).sort {|a,b| 
    (b.favorite_users.includes(:favorites).size) <=> (a.favorite_users.includes(:favorites).size)}
    
    @books.each do |book|
    impressionist(book, nil, unique: [:ip_address])
    end
  end

  def create
    @books = Book.all
    @book_new = Book.new(book_params)
    @book_new.user_id= current_user.id
   if @book_new.save
      flash[:notice]="You have created book successfully."
       redirect_to book_path(@book_new.id)
   else
       @user = current_user
       render :index
   end
  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @book_new = Book.new
     @comment = BookComment.new
     impressionist(@book, nil, unique: [:ip_address])
  end

  def edit
     @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
   if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
   else
    render :edit
   end
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

   private

  def book_params
    params.require(:book).permit(:title,:body,:user_id)
  end

end
