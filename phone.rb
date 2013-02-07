class Phone
	include Comparable
	attr_reader :phone

	def initialize(phone)
		@phone = phone.to_s.tr("-. \(\)", "")
	end
	
	def to_s
		clean
	end

	def <=>(other)
		phone.to_s <=> other.phone.to_s
	end

	def clean
		phone_length = @phone.length
		case phone_length
		when 0..9
			invalid_number
		when 10
			@phone
		when 11
			if @phone[0] == "1"
				@phone = @phone[1..-1]
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