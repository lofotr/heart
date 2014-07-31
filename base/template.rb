require_relative '../service.rb'
require 'logger'
class Template

  attr_accessor :service
  def initialize(service)
  	@service = service
  end

  def write(var)
  	@service.web.write(@name, var)
  end
end