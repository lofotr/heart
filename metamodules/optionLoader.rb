require_relative '../services/options.rb'

=begin
  This CoreModule loads options from the xml file.
=end
class OptionLoader
  @service
  @options

  #Adds options as a service
  def initialize()

    @service = Service.instance
    @options = Options.new
    @service.addService('options', @options)

  end

  def init(name, attributes)
    if(name != 'option')#gives no meaning to push here since it implies nestet options.
      #pushes all else
      @options.push()
    end
    return true
  end

  def run(element)
    
    if(element.name == 'option') 
      #Hashing the options
      tmp = Hash.new

      #There are two kinds of options; Make sure that both situations are handled. 
      if(element.attributes['value'])
        tmp[element.attributes['name']] = element.attributes['value']
      else
        tmp[element.attributes['name']] = element.value
      end
      
      #Adds the option to the service
      @options.addOption(tmp)
      return 
    end

    #pop all other elements.
    @options.pop()
  end

  def end()
    @options.pop() #pop in if the element is not accepted by other CoreModules
  end

end