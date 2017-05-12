class AppearancesController < ApplicationController
  before_action :validates, only: [:create, :update]
  def new
    @appearance = Appearance.new
    set_user

  end

  def create
    @appearance = Appearance.new(appearance_params)
    if @appearance.save
      redirect_to @appearance.episode
    else
      redirect_to new_appearance_path
    end
  end

  def edit
    find_appearance_by_params
    set_user
  end

  def update
    find_appearance_by_params
    @appearance.update(appearance_params)
    redirect_to @appearance.episode
  end

  private

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  def appearance_params
    params.require(:appearance).permit(:guest_id, :episode_id, :rating, :user_id)
  end

  def find_appearance_by_params
    @appearance = Appearance.find_by(id: params[:id])
  end

  def valid?
    Appearance.new(appearance_params).valid?
  end

  def validates
    unless valid?
      flash[:message] = "Invalid Entry"
      render :edit
    end
  end

end
