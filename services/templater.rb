require_relative '../base/template.rb'
class Templater

	@service
	
	def initialize(service)
		@service = service
		@service.logger.debug "Templater"
	end

	def method_missing(m, *args, &block)
		$LOAD_PATH << @service.options["templatePath"]

    	name = m.id2name
    	load "template.#{name}.rb"
    	t = Module.const_get(name).new(@service)
      	t.service = @service
      	t.run(args[0])
  	end

 


end