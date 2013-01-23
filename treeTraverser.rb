require 'XMLTree.rb'
require "meta.rb"
require "service.rb"
require "moduleLoader.rb"
require "module.rb"

class Traverser

  @xmlTree
  @metaModules

  def initialize(tree)
    @xmlTree = tree
    @metaModules = Array.new(0)
  end
 
  def run()
    stack = Array.new(0) 
    stack << @xmlTree
    
    while(!stack.empty?) do
      element = stack.first
      if(element.visited)
	 runModules(element)
         stack.shift
	 next
      elsif(!initModules(element))
         stack.shift
         next
      end
      element.visited = true
      element.children.reverse.each do |c|
        stack.unshift(c) 
      end     
    end
      
  end

  def initModules(element)
    ok = true
    @metaModules.each do |m|
      new = m.init(element.name,element.attributes)
      ok = ok ? new : ok
    end
    return ok
  end

  def runModules(element)
    @metaModules.each do |m|
      m.run(element)
    end     
  end

  def endModules(element)
  end
  

  def addModule(mModule)
    @metaModules << mModule
  end
  
end

if __FILE__ == $0

 # Element.include(Visited)
  top = Element.new("config")
  tmp = Element.new("module")
  tmp.addAttribute("name", "TestModule")
  tmp.addAttribute("type", "lat")
  setting = Element.new("modulesetting")
  setting.addAttribute("path","../modules/")
  top.addElement(setting)
  tmp2 = Element.new("option")
  tmp2.addAttribute("name", "hello")
  tmp2.value = "Hello World"
  tmp.addElement(tmp2)
  top.addElement(tmp)
  tmp3 = Element.new("module")
  tmp3.addAttribute("name", "test2")
  #top.addElement(tmp3)

  m = MetaModule.new
  m2 = ModuleLoader.new
  trav = Traverser.new(top)
  trav.addModule(m) 
  trav.addModule(m2)
  trav.run()
  

  service = Service.instance
  service.options
end
