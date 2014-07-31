require_relative '../services/templater.rb'

=begin
  This CoreModule loads options from the xml file.
=end
class TemplateLoader
  @service
  @templater

  #Adds options as a service
  def initialize(service)
    @service = service
    @templater = Templater.new(service)
    @service.addService('template', @templater)

  end

  def init(name, attributes)
    if(name == 'module')
      #@templater.push()
    end
    return true
  end

  def run(element)
    if(element.name == 'module') 
     # @templater.pop()
    end
    return true
  end

  def end()
  end

end