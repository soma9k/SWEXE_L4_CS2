class TopController < ApplicationController
    def main
        if session[:login_uid]
            render 'main'
        else
            render 'login'
        end
    end
    
    def login
        user.pass = Bcypt::Password.create(User.find_by(pass: params[:pass]))
        if User.find_by(uid: params[:uid]) and Bcypt::Password.new(user.pass) == User.find_by(pass: params[:pass])
            session[:login_uid] = params[:uid]
            render 'main'
        else
            render 'login_failed'
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end
end
