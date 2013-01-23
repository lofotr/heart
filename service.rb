require 'singleton'
class Service
  include Singleton
  @serviceObjects = Hash.new()
  attr_accessor :serviceObjects
  def method_missing(m, *args,&block)
    return @serviceObjects[m]
  end
end


