class QuitsController < ApplicationController
  def new
    @user = User.find params[:user_id]
    @quit = @user.quits.build
  end

  def create
    @quit = Quit.new quit_params
    puts 'hi'
    puts params['quit']['user_id']
    puts current_user['id']
    puts 'bye'
    if params['quit']['user_id'].to_s == current_user['id'].to_s
      puts 'here'
      if @quit.save
        flash[:success] = 'Created!'
        redirect_to @quit.user
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

  def edit
    @quit = Quit.find params[:id]
  end

  def update
    @quit = Quit.find params[:id]
    if @quit.update quit_params
      flash[:success] = 'Updated!'
      redirect_to @quit.user
    else
      render 'edit'
    end
  end

  private

  def quit_params
    params.require(:quit).permit(:user_id, :text)
  end
end
