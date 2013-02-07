require "csv"
require "yaml"
require "debugger"
require "active_support/all"
require_relative "phone"
require_relative "zipcode"
require_relative "street"
require_relative "queue"
require_relative "first_name"
require_relative "last_name"
require_relative "city"

Attendee = Struct.new(
  :first_name, 
  :last_name, 
  :email, 
  :phone, 
  :street, 
  :city, 
  :state, 
  :zipcode
  )

class EventReporter
  attr_accessor :attendees

  def initialize
    puts "Initializing Event Reporter..."
    @contents
    @parts
    @queue = Queue.new
    @help = YAML.load_file('help.yml')
    @attendees = []
  end

  def load(file)
    if file == nil
      file = "event_attendees.csv"
    else
      file
    end
    csv_parser(file)
  end

  def csv_parser(file)
    @contents = CSV.open(file, :headers => true)
    @contents.each do |line|
      attendees << Attendee.new(*extract_attendee(line))
    end
  end

  def extract_attendee(line)
    [
      FirstName.new(line["first_Name"]).to_s,
      LastName.new(line["last_Name"]).to_s,
      line["Email_Address"].to_s,
      Phone.new(line["HomePhone"]).to_s,
      Street.new(line["Street"]).to_s,
      City.new(line["City"]).to_s,
      line["State"].to_s,
      ZipCode.new(line["Zipcode"]).to_s
    ]
  end

  def help(key)
    if key == ""
      @help.each { |key, value| puts "#{key.ljust(15)}: #{value}" }
    else 
      puts @help[key]
    end
  end

  def find(attribute, criteria)
    result = attendees.select do |attendee| 
      attendee.send(attribute).downcase == criteria.downcase 
    end
    @queue.add(result)
  end

  def run
    puts "Welcome to Event Reporter."
    command = ""
    while command != "quit"
      printf "enter your command: "
      input = gets.chomp
      @parts = input.split(" ")
      command = @parts[0]
      process_command(command)
    end
  end

  def process_command(command)
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
    when "save" then @queue.save(@parts[3])
    when "print" then
      print_command = @parts[2]
      process_print_command(print_command)
    else puts "Sorry, I don't know how to '#{queue_command}'"
    end
  end
end

eventreporter = EventReporter.new
eventreporter.run