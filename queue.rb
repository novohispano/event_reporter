class Queue
  attr_accessor :queue_data

  def initialize
    self.queue_data = []
  end

  def add(search_results)
    self.queue_data = search_results
  end

  def count
    puts "There are #{queue_data.size} records in your queue."
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
        file.puts "last_Name,first_Name,Email_Address,Zipcode,City,State,Street,HomePhone"
        queue_data.each do |attendee|
          file.puts "#{attendee.last_name},#{attendee.first_name},#{attendee.email},#{attendee.zipcode},#{attendee.city},#{attendee.state},#{attendee.street},#{attendee.phone}"
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
      sorted_data = queue_data.sort do |attendee1, attendee2| 
        attendee1.send(attribute) <=> attendee2.send(attribute)
      end
      print_table(sorted_data)
    end
  end

  def headers
    headers = 
    [
      "LAST NAME",
      "FIRST NAME",
      "EMAIL",
      "ZIPCODE",
      "CITY",
      "STATE",
      "ADDRESS",
      "PHONE"
    ]
  end

  def print_headers
    headers
    headers.each do |header|
      Kernel.print header.ljust(25)
    end
    puts
  end

  def print_table(contents)
    print_headers
    contents.each do |attendee|
      attendee.each do |attribute|
        Kernel.print attribute[0..20].ljust(25)
      end
      puts
    end
  end
end