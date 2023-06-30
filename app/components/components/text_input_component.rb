# frozen_string_literal: true

module Components
  class TextInputComponent < ViewComponent::Base
    def initialize(form:, field_name:, value: '', errors: nil, autofocus: false, field_type: nil)
      @form       = form
      @field_name = field_name
      @value      = value
      @autofocus  = autofocus
      @errors     = errors
      @field_type = field_type
    end
  end
end
