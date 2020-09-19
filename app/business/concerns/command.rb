module Command
  attr_reader :result, :errors

  def initialize
    @errors = []
    @result = perform
    @_sucess = errors.to_a.size == 0 ? true : false
  end

  def sucess?
    @_sucess
  end
end
