class FirstName
  include Comparable
  attr_reader :first_name

  def initialize(first_name)
    @first_name = first_name.to_s.downcase.titleize
  end

  def to_s
    first_name
  end

  def <=>(other)
    first_name <=> other.first_name
  end
end