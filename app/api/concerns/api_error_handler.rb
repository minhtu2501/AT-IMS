module APIErrorHandler
  extend ActiveSupport::Concern

  included do
    error_formatter :json, ->(message, backtrace, options, env) do
      Rails.logger.error("Responding error (data='#{message}').")
      message.to_json
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      e.record.errors.messages.each do |key, value|
        e.record.errors.messages[key] = value[0]
      end
      Rails.logger.error("Failed to validate (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { message:
          { 
            meta:{
              status: :failed ,
              code: 400,
              messages: e.record.errors.to_hash
            },
            data: nil
          }, 
          status: 400 
        })
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      Rails.logger.error("Failed to validate (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { message: 
          { 
            meta:{
              status: :failed ,
              code: 404,
              messages: "Record not found."
            },
            data: nil
          }, 
          status: 404 
        })
    end

    rescue_from BadRequest do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          {
            meta:{
              status: :failed ,
              code: 400,
              messages: e.errors
            },
            data: nil
          }, 
          status: 400 
        })
    end

    rescue_from ActionController::ParameterMissing do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
           meta:{
              status: :failed ,
              code: 400,
              messages: :parameter_missing
            },
            data: nil

          }, 
          status: 400 
        })
    end

    rescue_from Unauthorized do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
            meta:{
              status: :failed ,
              code: 401,
              messages: I18n.t('errors.messages.unauthorized')
            },
            data: nil
          }, 
          status: 401 
        })
    end

    rescue_from ResourceNotFound do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
            meta:{
              status: :failed ,
              code: 404,
              messages: "は見つかりませんでした。"
            },
            data: nil
          }, 
          status: 404 
        })
    end

    rescue_from CanCan::AccessDenied do |e|
      Rails.logger.error("Failed to validate (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { message: 
          { 
            meta:{
              status: :failed ,
              code: 404,
              messages: "Access denied. You are not authorized to access the requested page."
            },
            data: nil
          }, 
          status: 404 
        })
    end

    rescue_from :all do |e|
      Rails.logger.error("Internal server error occurred.")
      Rails.logger.error("  type: #{e.class.name}")
      Rails.logger.error("  message: #{e.message}")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
            meta:{
              status: :failed ,
              code: 500,
              messages: :internal_server_error
            },
            data: nil
          }, 
          status: 500 
        })
    end
  end
end
