module V1
  class AuthAPI < Grape::API
    helpers do
      def new_request_info
        Hash[ip: request.ip, user_agent: request.user_agent]
      end
    end

    resource :auth do

      desc "Login"
      post "/login", rabl: 'auth/login' do
        binding.pry
        if params[:email].blank? || params[:password].blank?
          error!({meta:{status: :failed, code: 500, messages: I18n.t('errors.messages.blank_user_pass') },data: nil})
        else
          @user = User.find_by_email(params[:email].downcase)
          if @user && @user.valid_password?(params[:password])
            # if @user.sesson_limited?
            #   error!({meta:{status: :failed, code: 500, messages: I18n.t('errors.messages.limited_session')},data: nil})
            # else
            # Create token
            token = ApiKey.find_by_user_id(@user.id)
            new_token = token.generate_access_token
            token.save()
            # $redis.sadd("session_user: #{@user.id}", new_request_info)
            @user
            # end
          else
            error!({meta:{status: :failed, code: 500, messages: I18n.t('errors.messages.wrong_user_pass')},data: nil})
          end
        end
      end

      desc "Logout"
      delete "/logout" do
        authentication?
        if @user
          @user.log_out
          # $redis.srem("session_user: #{@user.id}", new_request_info)
          {"meta":{"status":"successfully", "code":200, "message":"Logout successfully"}}
        end
      end
    end
  end
end