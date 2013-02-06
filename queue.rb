class Queue

	def initialize(attendees)
		@attendees = attendees
	end

	def count
		if @attendees.nil?
			@attendees = []
		else 
			@attendees.size
		end
	end

	def clear
		@attendees = []
		puts "The queue was cleared."
	end

	def print
		if @attendees == []
			puts "I am sorry, you don't have any data loaded to print."
		else
			@attendees
			print_table(@attendees)
		end
	end

	def print_by(attribute)
		if @attendees == []
			puts "I am sorry, you don't have any data loaded to print."
		else
			@attendees = @attendees.sort {|attendee1, attendee2| attendee1.send(attribute) <=>attendee2.send(attribute)}
			print_table(@attendees)
		end
	end

	def print_table(contents)
		puts "1".ljust(10, " ") + "LAST NAME".ljust(20, " ") + "FIRST NAME".ljust(15, " ") + "EMAIL".ljust(45, " ") + "ZIPCODE".ljust(10, " ") + "CITY".ljust(25, " ") + "STATE".ljust(7, " ") + "ADDRESS".ljust(55, " ") + "PHONE".ljust(10, " ")
		id = 0
		@attendees.each do |attendee|
			id = id + 1
			puts "#{id}".ljust(10) + "#{attendee.last_name}".ljust(20) + "#{attendee.first_name}"[0..10].ljust(15) + "#{attendee.email}".ljust(45) + "#{attendee.zipcode}".ljust(10) + "#{attendee.city}".ljust(25) + "#{attendee.state}".ljust(5) + "#{attendee.street}"[0..55].ljust(60) + "#{attendee.phone}".ljust(10)
		end
	end
end