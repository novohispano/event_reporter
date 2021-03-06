class LastName
  include Comparable
  attr_reader :last_name

  def initialize(last_name)
    @last_name = last_name.to_s.downcase.titleize
  end

  def to_s
    last_name
  end

  def <=>(other)
    last_name <=> other.last_name
  end
end