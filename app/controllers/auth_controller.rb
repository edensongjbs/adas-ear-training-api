class AuthController < ApplicationController

    skip_before_action :logged_in?, only: :create
    
    def create
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            render json: {email: user.email, token: encode_token({user_id: user.id})}
        else
            render json {error: "invalid username or password"}    
        end
    end
end
