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
     puts tokens.inspect
  end
  
end
