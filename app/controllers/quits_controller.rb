class QuitsController < ApplicationController
  def new
    @user = User.find params[:user_id]
    @quit = @user.quits.build
  end

  def create
    @quit = Quit.new quit_params
    if @quit.save
      if @quit.user_id == current_user
        flash[:success] = 'Created!'
        redirect_to @quit.user
      else
        render root_path
      end
    else
      render 'new'
    end
  end

  def edit
    @quit = Quit.find params[:id]
  end

  def update
    @quit = Quit.find params[:id]
    if @quit.update quit_params
      if @quit.user_id == current_user
        flash[:success] = 'Updated!'
        redirect_to @quit.user
      else
        flash[:error] = 'Cant edit/create a quit for another user'
        render root_path
      end
    else
      render 'edit'
    end
  end

  private

  def quit_params
    params.require(:quit).permit(:user_id, :text)
  end
end
