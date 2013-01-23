class ModuleLoader


  @path

  def initialize()
      @path = nil
      @module = nil
  end

  def init(name, attributes)
    if(name == "modulesetting")
      @path = attributes["path"]
    elsif(name =="module")
      #check for existance
    end
    return true
  end

  def run(element)
    if(element.name == "modulesetting")

    elsif(element.name == "module")
      name = element.attributes["name"]
      require "#{@path}#{name}.rb"
      m = Module.const_get(name).new
      m.run()
    end 
  end

  def end()
  end

end
