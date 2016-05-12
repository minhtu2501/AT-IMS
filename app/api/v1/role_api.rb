module V1
  class RoleAPI < Grape::API
    helpers do
      def authorize!(*args)
      # you already implement current_user helper :)
      binding.pry
      authentication?
      ::Ability.new(@user).authorize!(*args)
      end
    end
    resource :roles do
      desc "Return all roles"
      get "/", rabl: "roles/index" do
        authorize! :index, :role_api
        @roles = Role.all 
      end

      desc "Return a role"
      get "/:id", rabl: "roles/show" do
        authorize! :show, :role_api
        @role = Role.find(params[:id]) if params[:id]
      end

      desc "Create new role"
      post "/", rabl: "roles/new" do
        @role = Role.create(converted_params.permit(:name))
      end
    end
  end
end