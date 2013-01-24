require "./xmlTokenizer.rb"
class Parser
include XmlTokenizer
@ElementName


def callStartElementTag(tag)
end

def callTagEnd(tag)
#   puts "end #{tag}"
end

def callAttribute(name)
end

def callAttributeValue(value)
#   puts "atrb: #{value}"
end

def callValue(value)
#   puts "value: #{value}"
end

def callEndElementTag(tag)
   puts "endElement: #{tag}"
end


end

if __FILE__ == $0
 parser = Parser.new("config.xml")
 parser.read
end
