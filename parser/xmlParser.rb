module HeartTokenizer
  @file
  @tokenStart

  def initialize(filename)
     @file = File.new(filename,"r")
     @tokenStart = Array["<",">","\s","=", "\"","/"]
  end

  def read()
    while(line = @file.gets)
      puts line
      tokenize(line)
    end
    @file.close
  end
  
  #tokenize one string at a time
  def tokenize(line)
    tokens = Array.new(0)
    tmp = String.new
    line.gsub!("\t","")

    line.each_char{|c|
      if(@tokenStart.include?(c))
        tokens << tmp 
        tokens << c
        tmp =""
      else
        tmp += c
      end
    }
    tokens.delete("")
    tokens.delete("\"")
    tokenParser(tokens)
  end

  def tokenParser(tokens)
    puts tokens.inspect
    
    startTag = false
    endTag = false

    isAttribute = false
    isValue = false
    


    tokens.each{|t|

      case t
      when "<"
        if startTag == false
          startTag = true
        else
          #error
        end

      when ">"
        if startTag == true
          startTag = false
          self.callTagEnd
          puts "TagEnd"
        else
          #error
        end

      when "="
        if startTag == true
          isValue = true
        else
          #error
        end

      when " "
        if startTag == true
          isAttribute = true
        else
          self.callValue
          puts "Value: #{t}"
        end

      when "/"
        if startTag == true
          endTag = true
        else
          #error
        end

      else
        if isAttribute == true
          self.callAttribute
          puts "attribute: #{t}"
          isAttribute = false
        elsif isValue == true
          self.callAttributeValue
          puts "attrtibute-value: #{t}"
          isValue = false
        elsif endTag == true
          puts "endElementTag: #{t}"
          self.callEndElementTag
        elsif startTag == true
          self.callStartElementTag(t)
          puts "startElementTag: #{t}"
        else
          self.callValue
          puts "value: #{t}"
        end
      end
    }
  end

end

if __FILE__ == $0
  
  #parser = HeartTokenizer.new("config.xml")
  #parser.read
end
