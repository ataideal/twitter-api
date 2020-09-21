# frozen_string_literal: true

# This module is responsible for implements Service Objects.
# To include this module is mandatory call super() on class's initialize, and define #peform method.
# Then public attributes will be available through to #result, #errors and a #success.

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
