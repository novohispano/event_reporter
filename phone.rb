class Phone
	include Comparable
	attr_reader :phone

	def initialize(phone)
		@phone = clean phone.to_s.tr("-. \(\)", "")
	end

	def to_s
		phone
	end

	def <=>(other)
		phone.to_s <=> other.phone.to_s
	end

	def clean(number)
		phone_length = number.length
		case phone_length
		when 0..9
			invalid_number
		when 10
			number
		when 11
			if number[0] == "1"
				number[1..-1]
			else
				invalid_number
			end
		else
			invalid_number
		end
	end

	def invalid_number
		"0000000000"
	end
end