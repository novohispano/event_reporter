require "csv"
require "yaml"
require_relative "phone"
require_relative "zipcode"

Attendee = Struct.new(:first_name, :last_name, :email, :phone, :street, :city, :state, :zipcode)

class EventReporter

	def initialize
		puts "Initializing Event Reporter..."
		@contents
		@attendees = []
	end

	def load(file)
		if file == nil
			file = "event_attendees.csv"
		else
			file
		end

		@contents = CSV.open(file, :headers => true)

		@contents.each do |line|
			first_name = line["first_Name"]
			last_name = line["last_Name"]
			email = line["Email_Address"]
			
			phone = Phone.new(line["HomePhone"])
			
			street = line["Street"]
			city = line["City"]
			state = line["State"]

			zipcode = ZipCode.new(line["Zipcode"])

			attendee = Attendee.new(first_name, last_name, email, phone, street, city, state, zipcode)
			@attendees << attendee
		end
	end

	def save(file)
		if file == nil
			puts "I am sorry, but you did not specify a file to save the data."
		else
			File.open(file, 'w') do |file|
				file.puts "1,LAST NAME,FIRST NAME,EMAIL,ZIPCODE,CITY,STATE,ADDRESS,PHONE"
				id = 0
				@attendees.each do |attendee|
					id = id + 1
					file.puts "#{id},#{attendee.last_name},#{attendee.first_name},#{attendee.email},#{attendee.zipcode},#{attendee.city},#{attendee.state},#{attendee.street},#{attendee.phone}"
				end
			end
		end
	end

	def queue_count
		if @attendees.nil?
			@attendees = []
		else 
			@attendees.size
		end
	end

	def queue_clear
		@attendees = []
	end

	def queue_print
		if @attendees == []
			puts "I am sorry, you don't have any data loaded to print."
		else
			id = 0
			puts "1\tLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
			@attendees.each do |attendee|
				id = id + 1
				puts "#{id}\t#{attendee.last_name}\t#{attendee.first_name}\t#{attendee.email}\t#{attendee.zipcode}\t#{attendee.city}\t#{attendee.state}\t#{attendee.street}\t#{attendee.phone}"
			end
		end
	end

	def queue_print_by(attribute)
		if @attendees == []
			puts "I am sorry, you don't have any data loaded to print."
		else
			id = 0
			puts "1\tLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
			@attendees = @attendees.sort! {|attendee1, attendee2| attendee1.send(attribute) <=> attendee2.send(attribute)}
			@attendees.each do |attendee|
				id = id + 1
				puts "#{id}\t#{attendee.last_name}\t#{attendee.first_name}\t#{attendee.email}\t#{attendee.zipcode}\t#{attendee.city}\t#{attendee.state}\t#{attendee.street}\t#{attendee.phone}"
			end
		end
	end

	def help(command)
		help = YAML.load_file("help.yml")
 		if command == nil
			puts "#{help.keys}"
		else 
			puts "#{help["command"]}"
		end
	end

	def run
		puts "Welcome to Event Reporter."
		command = ""
		while command != "quit"
			printf "enter your command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]

			case command
			when "quit" then puts "Exiting Event Reporter."
			when "load" then load(parts[1])
			when "queue" then
				queue_command = parts[1]
				case queue_command
				when "count" then puts queue_count
				when "clear" then puts queue_clear
				when "save" then save(parts[3])
				when "print" then
					print_command = parts[2]
					case print_command
					when nil then queue_print
					when "by" then queue_print_by(parts[3])
					else puts "Sorry, I don't know how to '#{command}'"
					end
				else puts "Sorry, I don't know how to '#{command}'"
				end
			when "help" then help(parts[1..-1])
			else puts "Sorry, I don't know how to '#{command}'"
			end
		end
	end
end

eventreporter = EventReporter.new
eventreporter.run