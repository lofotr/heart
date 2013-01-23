require 'service.rb'
class Module

  @service
  def initialize()
    @service = Service.instance
  end

  def run()
  end
end
