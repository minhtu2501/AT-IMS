class RootV1 < Grape::API
  include APIExtensions
  prefix "api"
  version 'v1', using: :path 
  format :json
  formatter :json, Grape::Formatter::Rabl

  mount V1::UserAPI
  mount V1::RoleAPI
  mount V1::AuthAPI
end