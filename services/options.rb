
require 'set'

=begin
	This class stores nested options. It works like a stack.
=end
class Options
	@list
	def initialize()
		@list = Array.new
	end


	def push()
		if(@list.empty?) #avoid the situation where there are no hastables left.
			@list.push(Hash.new)
			return
		end
		
		#Brings the older options to the next layer of the stack; Making them available.
		@list.push(@list.last.clone)
	end

	def pop()
		@list.pop()
		if(@list.empty?) #avoid the situation where there are no hastables left.
			@list.push(Hash.new)
		end
	end

	#Add options, takes a hastable as input
	def addOption(option)
		@list.last.merge!(option)
	end

	# Returns the value: value = options[name]
	def [](name)
		@list.last[name]
	end
end