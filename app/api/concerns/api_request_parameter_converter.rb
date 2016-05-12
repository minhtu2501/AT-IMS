module APIRequestParameterConverter
  extend ActiveSupport::Concern

  included do
    helpers do
      def converted_params()
        return ActionController::Parameters.new(params)
      end
    end
  end
end
