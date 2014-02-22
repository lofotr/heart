require 'singleton'
class Service
  include Singleton
  @serviceObjects
  attr_accessor :serviceObjects

  def initialize
    @serviceObjects = Hash.new()
  end

  def method_missing(m, *args, &block)

    return @serviceObjects[m.id2name]
  end
 
  def addService(name, service)
    @serviceObjects.store(name, service)
  end
end


