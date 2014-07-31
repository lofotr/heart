require_relative '../services/webService.rb'
class WebLoader
  @service
  @url
  @web
  def initialize(service, url)
    @service = service
    @url = url

    @web = WebService.new(url, service)
    @service.addService('web', @web)
  end

  def init(name, attributes)
    if(name =="web")
      #check for existance
    elsif(name == "module")
      @web.push()
    end
    return true
  end

  def run(element)
    @service.logger.debug "webloader #{@service.web.inspect}"
    if(element.name == 'module') 
      @web.pop()
    end
  end

  def end()
  end

end