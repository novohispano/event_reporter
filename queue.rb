class Queue
	attr_accessor :queue_data

	def initialize
		self.queue_data = []
	end

	def add(search_results)
		self.queue_data = search_results
	end

	def count
			puts queue_data.size
	end

	def clear
		self.queue_data = []
		puts "The queue was cleared."
	end

	def save(file)
		if file == ""
			puts "I am sorry, but you did not specify a file to save the data."
		else
			File.open(file, 'w') do |file|
				file.puts "1,LAST NAME,FIRST NAME,EMAIL,ZIPCODE,CITY,STATE,ADDRESS,PHONE"
				id = 0
				queue_data.each do |attendee|
					id = id + 1
					file.puts "#{id},#{attendee.last_name},#{attendee.first_name},#{attendee.email},#{attendee.zipcode},#{attendee.city},#{attendee.state},#{attendee.street},#{attendee.phone}"
				end
			end
		end
	end

	def print
		if queue_data == []
			puts "I am sorry, you don't have any data loaded to print."
		else
			print_table(queue_data)
		end
	end

	def print_by(attribute)
		if queue_data == []
			puts "I am sorry, you don't have any data loaded to print."
		else
			sorted_data = queue_data.sort {|attendee1, attendee2| attendee1.send(attribute) <=> attendee2.send(attribute)}
			print_table(sorted_data)
		end
	end

	def print_table(contents)
		puts "1".ljust(10, " ") + "LAST NAME".ljust(20, " ") + "FIRST NAME".ljust(15, " ") + "EMAIL".ljust(45, " ") + "ZIPCODE".ljust(10, " ") + "CITY".ljust(25, " ") + "STATE".ljust(7, " ") + "ADDRESS".ljust(55, " ") + "PHONE".ljust(10, " ")
		id = 0
		contents.each do |attendee|
			id = id + 1
			puts "#{id}".ljust(10) + "#{attendee.last_name}".ljust(20) + "#{attendee.first_name}"[0..10].ljust(15) + "#{attendee.email}".ljust(45) + "#{attendee.zipcode}".ljust(10) + "#{attendee.city}".ljust(25) + "#{attendee.state}".ljust(5) + "#{attendee.street}"[0..55].ljust(60) + "#{attendee.phone}".ljust(10)
		end
	end
end