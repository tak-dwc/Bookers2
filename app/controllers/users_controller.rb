class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
    
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
     render :edit
    else
     redirect_to user_path(current_user)  
    end  
    # unless @user == current_user
    #   redirect_to  user_path(@user.id)
    # end 上記に
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

   private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  
  
end
