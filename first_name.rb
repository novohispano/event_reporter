class FirstName
	include Comparable
	attr_reader :first_name

	def initialize(first_name)
		@first_name = first_name
	end

	def to_s
		clean
	end

	def clean
		@first_name = first_name.to_s.titleize
	end

	def <=>(other)
		first_name.to_s <=> other.first_name.to_s
	end
end