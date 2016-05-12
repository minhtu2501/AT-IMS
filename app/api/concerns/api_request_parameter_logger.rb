module APIRequestParameterLogger
  extend ActiveSupport::Concern

  included do
    before do
      Rails.logger.info("Parameter: #{params.to_hash}")
    end
  end
end
