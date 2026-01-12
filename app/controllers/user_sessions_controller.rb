class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    puts "Email: #{params[:email]}"
    puts "Password: #{params[:password]}"
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, success: "ログインしました。"
    else
      flash.now[:alert] = "ログインに失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: "ログアウトしました。", status: :see_other
  end
end
