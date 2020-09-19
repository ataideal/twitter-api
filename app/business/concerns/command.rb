# frozen_string_literal: true

module Command
  attr_reader :result, :errors

  def initialize
    raise "method 'perform' not implemented for this class" unless self.class.method_defined?(:perform)

    @errors = nil
    @result = perform
    @_success = errors.nil? ? true : false
  end

  def success?
    @_success
  end
end
