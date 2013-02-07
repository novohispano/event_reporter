class City
  include Comparable
  attr_reader :city

  def initialize(city)
    @city = city.to_s.tr("-.\(\),", "").titleize
  end

  def to_s
    city
  end

  def <=>(other)
    city.to_s <=> other.city.to_s
  end
end