# frozen_string_literal: true

module Components
  class ErrorTagComponent < ViewComponent::Base
    def initialize(errors:)
      @errors = errors
      super
    end
  end
end
