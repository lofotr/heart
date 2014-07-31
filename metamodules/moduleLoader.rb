require_relative '../base/module.rb'
require 'logger'
class ModuleLoader
  @path
  @service
  def initialize(service)
      @service = service
      @path = nil
      @module = nil
  end

  def init(name, attributes)
    if(name == "modulesetting")
      #@path = attributes["path"]
      $LOAD_PATH << attributes["path"]
    elsif(name =="module")
      #check for existance
    end
    return true
  end

  def run(element)
    if(element.name == "modulesetting")

    elsif(element.name == "module")
      name = element.attributes["name"]
      load "#{name}.rb" #Should use require in stead of load in production. Faster code!!!!
      m = Module.const_get(name).new
      m.service = @service
      m.run()
    end 
  end

  def end()
  end

end
