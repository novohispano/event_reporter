class ZipCode
  include Comparable
  attr_reader :zipcode

  def initialize(zipcode)
    @zipcode = clean zipcode
  end

  def to_s
    zipcode
  end

  def <=>(other)
    zipcode <=> other.zipcode
  end

  def clean(zipcode)
    if zipcode.nil?
      "00000"
    else
      "0"*(5 - zipcode.length) + zipcode
    end
  end
end