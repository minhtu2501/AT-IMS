module Authorizable 
  extend ActiveSupport::Concern
  included do
    helpers do
      def authentication?
        fail Unauthorized unless current_user
      end

      def current_user
        token = ApiKey.find_by(access_token: headers['Access-Token'])
        unless token && !token.expired?
          false
        else
          binding.pry
          @user = User.find(token.user_id)
        end
      end
    end
  end
end