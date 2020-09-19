# frozen_string_literal: true

module Command
  attr_reader :result, :errors

  def initialize
    @errors = nil
    @result = perform
    @_sucess = errors.nil? ? true : false
  end

  def sucess?
    @_sucess
  end
end
