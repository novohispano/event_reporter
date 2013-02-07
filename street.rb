class Street
  include Comparable
  attr_reader :street

  def initialize(street)
    @street = street
  end

  def to_s
    clean
  end

  def clean
    @street = street.to_s.tr("-.\(\),", "").titleize
  end

  def <=>(other)
    street.to_s <=> other.street.to_s
  end
end