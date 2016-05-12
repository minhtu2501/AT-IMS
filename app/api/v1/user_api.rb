module V1
  class UserAPI < Grape::API
    helpers do
      def authorize!(*args)
      # you already implement current_user helper :)
      authentication?
      ::Ability.new(@user).authorize!(*args)
      end
    end
    resource :users do 
      desc "Return all users"
      get "/", rabl: "users/index" do
        authorize! :index, :user_api
        @users = User.all
      end

      desc "Return a user"
      get "/:id", rabl: 'users/show' do
        authorize! :show, :user_api
        @user = User.find(params[:id]) if params[:id]
      end

      desc "Create new user"
      post "/sign_up", rabl: 'users/new' do
        if params[:name].blank? || params[:email].blank? || params[:password].blank? || params[:password_confirmation].blank?
          error!({meta:{status: :failed, code: 500, messages: I18n.t('errors.messages.blank_user_pass') },data: nil})
        else
          if @user = User.create!(converted_params.permit(:name, :email, :password, :password_confirmation))
            @api_key = ApiKey.new
            @api_key.user = @user
            @api_key.save
            @user
          else
            error!({meta:{status: :failed, code: 500, messages: 'Cannot create new User.' },data: nil})
          end
                      
        end
      end
    end
  end
end