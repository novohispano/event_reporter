class LastName
	include Comparable
	attr_reader :last_name

	def initialize(last_name)
		@last_name = last_name
	end

	def to_s
		clean
	end

	def clean
		@last_name = last_name.to_s.titleize
	end

	def <=>(other)
		last_name.to_s <=> other.last_name.to_s
	end
end