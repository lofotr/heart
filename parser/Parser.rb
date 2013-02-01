require "./xmlTokenizer.rb"
class Parser
include XmlTokenizer
@ElementName


def callElementTag(element)
   puts element
end

def callTagEnd()
   puts "end"
end

def callAttribute(token)
    puts token
end

def callValue(value)
   puts "value: #{value}"
end

def callEndElementTag(element)
   puts "endElement: #{element}"
end


end

if __FILE__ == $0
 parser = Parser.new("config.xml")
 parser.read
end
