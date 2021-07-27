class ApplicationController < ActionController::Base

    helper_method :current_messagewriter

    def current_messagewriter
        return @current_messagewriter if @current_messagewriter.present?
        if session[:messagewriter_id].present?
            @current_messagewriter = Messagewriter.find(session[:messagewriter_id])
        else
            @current_messagewriter = Messagewriter.generate
            session[:messagewriter_id] = @current_messagewriter.id
            @current_messagewriter
        end
    end
end
