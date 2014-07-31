

class WebService
	attr_reader :url
	attr_reader :document
	@service
	push = false
	def initialize(url, service)
		@url = url
		@document = Array.new
		@service = service
		#@document = String.new

	end
	
	def method_missing(m, *args, &block)
		name = m.id2name
		name = name[0...-1]
		if(args[0] == nil)
    		return @document.last[m.id2name]
    	end
    	@service.logger.debug "web #{name} #{args[0]}"
    	@document.last[name] = args[0]
  	end

	def write(name, text)
		@document.last[name] = text
	end

	def push()
		push = true
		@document.push(Hash.new())
		#if(@document.empty?) #avoid the situation where there are no hastables left.
		#	@document.push(Hash.new)
		#	return
		#end
  		@service.logger.debug "WebService.push"
  	end

  	def pop()
  		if(push == true)
  			push == false
  			return
  		end
  		@document.pop()
		if(@document.empty?) #avoid the situation where there are no hastables left.
			@document.push(Hash.new)
		end
  		@service.logger.debug "WebService.pop"
  	end
end