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

  def print_table(contents)
    puts "LAST NAME".ljust(20) + "FIRST NAME".ljust(15) + "EMAIL".ljust(45) + "ZIPCODE".ljust(10) + "CITY"[0..20].ljust(25) + "STATE".ljust(7) + "ADDRESS".ljust(60) + "PHONE".ljust(10)
    contents.each do |attendee|
      puts "#{attendee.last_name}".ljust(20) + "#{attendee.first_name}"[0..10].ljust(15) + "#{attendee.email}".ljust(45) + "#{attendee.zipcode}".ljust(10) + "#{attendee.city}"[0..20].ljust(25) + "#{attendee.state}".ljust(7) + "#{attendee.street}"[0..55].ljust(60) + "#{attendee.phone}".ljust(10)
    end
  end
end