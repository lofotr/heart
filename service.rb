require 'singleton'
class Service
  include Singleton
  @serviceObjects
  attr_accessor :serviceObjects

  def initialize
    @serviceObjects = Hash.new()
  end

  def method_missing(m, *args, &block)
    return @serviceObjects[m]
  end
 
  def addService(name, service)
    hash.store(name, service)
  end
end


