class BadRequest < StandardError
  attr_reader :errors

  def initialize(errors = {})
    @errors = errors
  end

  class CustomerTypeInvalid < BadRequest
    def initialize
      super(customer_type: Asiantech.trans('invalid'))
    end
  end

  class PasswordInvalid < BadRequest
    def initialize
      super(current_password: Asiantech.trans("password_invalid"))
    end
  end
end
