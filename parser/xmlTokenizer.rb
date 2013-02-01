module XmlTokenizer
  @file
  @symbols

  def initialize(filename)
     @file = File.new(filename,"r")
     @symbols = Array["\s", "</", "/>"]
     @lesser = Array["<", ">", "/"]
  end

  def read()
    while(line = @file.gets)
      tokenize(line)
    end
    @file.close
  end

  def tokenize(line)
#    puts line
    tokens = Array.new(0)
    tmp = String.new
    symbMode = true

    line.gsub!("\t","")
    line.gsub!("\""," ")
    line.gsub!("=","")
     
#    puts line 
    line.each_char{|c|
      if(c == " ")
	tokens << tmp
	tmp = ""
        next
      end
      if(@lesser.include?(c))
        if(c == "/")
          if(tmp == "")
            symbMode = true
	  end
        elsif(c == ">")
	  if(tmp == "/")
            tmp += c
            tokens << tmp
            tmp = ""
            next
	  end
	  tokens << tmp
	  tokens << ">"
          tmp = ""
          next
        elsif(!symbMode)
          tokens << tmp
          symbMode = true
          tmp = ""
        end
	tmp += c
      else
        if(symbMode)
          tokens << tmp
          tmp = ""
          symbMode = false
        end
        tmp += c
      end
    }
  tokens.delete("")
  tokenParser(tokens)

  end

  def tokenParser(tokens)
     #puts tokens.inspect

    element = false
    elementName = false
    endElementName = false
    value = ""
    tokens.each{ |t|
      case t
      when "<"
        elementName = true
        element = true
	next
      when ">"
        elementName = false
        element = false
        next
      when "/>"
        self.callEndElementTag(t)
        elementName = false
        element = false
        next
      when "</"
        endElementName = true
        if(value != "")
          self.callValue(value)
          value = ""
        end
        next
      else
       if(elementName)
         self.callElementTag(t)
         elementName = false
       elsif(element)
         self.callAttribute(t)
       elsif(endElementName)
	 self.callEndElementTag(t)
         endElementName = false
       else
	 value += " #{t}"
       end
      end
    }

  end
  
end
