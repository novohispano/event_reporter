require "csv"
require "yaml"
require "debugger"
require_relative "phone"
require_relative "zipcode"
require_relative "queue"

Attendee = Struct.new(:first_name, :last_name, :email, :phone, :street, :city, :state, :zipcode)

class EventReporter
	attr_accessor :attendees

	def initialize
		puts "Initializing Event Reporter..."
		@contents
		@parts
		@queue = Queue.new
		@attendees = []
		@help = YAML.load_file('help.yml')
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
			street = line["Street"].to_s
			city = line["City"].to_s
			state = line["State"].to_s
			zipcode = ZipCode.new(line["Zipcode"])
			attendee = Attendee.new(first_name, last_name, email, phone, street, city, state, zipcode)
			attendees << attendee
		end
	end

	def help(key)
		if key == ""
			@help.each { |key, value| puts "#{key.ljust(15)}: #{value}" }
		else 
			puts @help[key]
		end
	end

	def find(attribute, criteria)
		@queue.add(attendees.select{|attendee| attendee.send(attribute) == criteria})
	end

	def run
		puts "Welcome to Event Reporter."
		command = ""
		while command != "quit"
			printf "enter your command: "
			input = gets.chomp
			@parts = input.split(" ")
			command = @parts[0]
			case command
			when "quit" then puts "Exiting Event Reporter."
			when "load" then load(@parts[1])
			when "find" then find(@parts[1], @parts[2..-1].join(" "))
			when "queue" then
				queue_command = @parts[1]
				process_queue_command(queue_command)
			when "help" then help(@parts[1].to_s)
			else puts "Sorry, I don't know how to '#{command}'"
			end
		end
	end

	def process_print_command(print_command)
		case print_command
		when nil then @queue.print
		when "by" then @queue.print_by(@parts[3])
		else puts "Sorry, I don't know how to '#{print_command}'"
		end
	end

	def process_queue_command(queue_command)
		case queue_command
		when "count" then @queue.count
		when "clear" then @queue.clear
		when "save" then save(@parts[3])
		when "print" then
			print_command = @parts[2]
			process_print_command(print_command)
		else puts "Sorry, I don't know how to '#{queue_command}'"
		end
	end
end

eventreporter = EventReporter.new
eventreporter.run