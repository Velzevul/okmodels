class Woman < Model
  attr_accessible :bust, :heaps, :waist

  validates :bust, :heaps, :waist, :presence => true
  validates :bust, :waist, :heaps, :numericality => {:greater_than => 0}
end
