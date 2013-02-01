require_relative "./xmlTokenizer.rb"
require_relative "../XMLTree.rb"

class Parser
include XmlTokenizer

@stack
@element
@elementTag

@attributeName

def initialize(file)
  super(file)
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

def result()
  return @stack
end

end

if __FILE__ == $0
 file = File.new("config.xml")
 parser = Parser.new(file)
 parser.read
 puts parser.inspect
end
