require "./xmlTokenizer.rb"
require "../XMLTree.rb"

class Parser
include XmlTokenizer

@stack
@element
@elementTag

@attributeName

def initialize(filename)
  super(filename)
  @elementTag = false
  @stack = Array.new(0)
  
  @attributeName = ""
  @attribyteValue = ""
end

def callElementTag(element)
   @stack.push(Element.new(element))
end

def callTagEnd()
end

def callAttribute(token)
   if(@attributeName == "")
     @attributeName = token
   else
     @stack.last.addAttribute(@attributeName, token)
     @attributeName = ""
   end
end

def callValue(value)
   @stack.last.setValue(value)
end

def callEndElementTag(element)
   tmp = @stack.pop
   if (@stack.last != nil)
     @stack.last.addElement(tmp)
   else
     @stack.push(tmp)
   end
end


end

if __FILE__ == $0
 parser = Parser.new("config.xml")
 parser.read
 puts parser.inspect
end
