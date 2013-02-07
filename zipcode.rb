class ZipCode
  include Comparable
  attr_reader :zipcode

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def to_s
    clean
  end

  def <=>(other)
    zipcode.to_s <=> other.zipcode.to_s
  end

  def clean
    if @zipcode.nil?
      "00000"
    else
      "0"*(5 - @zipcode.length) + @zipcode
    end
  end
end