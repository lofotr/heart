class MetaModule

  def initialize()
  end

  def init(name, attributes)
    if(name == 'login')
      return true
    end
    #puts "#{name}"
    return true
  end

  def run(element)
    #puts "run #{element.name}"
  end

  def end()
  end

end
