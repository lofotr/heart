
class Element
  @name
  @attributes
  @children
  @value
  @visited = false

  attr_accessor :name
  attr_accessor :attributes
  attr_accessor :children
  attr_accessor :value
  attr_accessor :visited

  def initialize(name)
    @name = name
    @attributes = Hash.new
    @children = Array.new(0)
@value = String.new("")
end

  def addAttribute(name, value)
    @attributes.store(name,value)
  end

  def addElement(element)
    @children<< element
  end


end

if __FILE__ == $0
  puts "hello"
end
