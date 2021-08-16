class ApplicationController < ActionController::Base
    #before_action :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, :alert => exception.message
    end

    helper_method :current_messagewriter

    def current_messagewriter
        return @current_messagewriter if @current_messagewriter.present?
        
        if session[:user_id].present?
            @current_messagewriter = Messagewriter.find_by(id: session[:user_id])
        else
            @current_messagewriter = Messagewriter.generate(current_user)
            session[:user_id] = @current_messagewriter.id
            @current_messagewriter
        end

        if @current_messagewriter.nil?
            @current_messagewriter = Messagewriter.generate(current_user)
            session[:user_id] = @current_messagewriter.id
            @current_messagewriter
        end
        
        @current_messagewriter
    end

    def after_sign_in_path_for(resource)
        rooms_path
    end
    
end
