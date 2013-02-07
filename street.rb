class Street
	include Comparable
	attr_reader :street

	def initialize(street)
		@street = street.to_s.tr("-.\(\),", "").titleize
	end

	def to_s
		street
	end

	def <=>(other)
		street.to_s <=> other.street.to_s
	end
end