module APIExtensions
  extend ActiveSupport::Concern

  included do
    include APIErrorHandler
    include APIRequestParameterConverter
    include APIRequestParameterLogger
    include Authorizable
  end
  
end
