class SessionsController < ApplicationController
    protect_from_forgery :except => [:create]
    skip_before_action :require_login, only: [:new, :create]
    
    def new
    end

    def create
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            log_in user
            render :json => {
                status:true,
                message:'Login success',
                url: user_path(user)
            }
        else
            flash[:warning] = 'email or passowrd wrong'
            render :json => {
                status:false,
                message:'Login error'
            }
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end
end