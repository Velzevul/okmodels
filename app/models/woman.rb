class Woman < ActiveRecord::Base
  attr_accessible :bust, :confirmed, :date_of_birth, :email, :eyes, :full_name, :hair, :heaps, :height, :shoes, :waist

  validates :date_of_birth, :email, :eyes, :hair, :height, :full_name, :shoes, :bust, :heaps, :waist, :presence => true
  validates :shoes, :height, :bust, :waist, :heaps, :numericality => {:greater_than => 0}
  validates :full_name, :email, :uniqueness => true
  validate :birth_date_should_be_in_the_past

  default_scope where(:confirmed => true).order('created_at DESC')
  scope :nonconfirmed, lambda { where(:confirmed => false) }
  scope :latest, lambda {|n| limit(n)}

private

  def birth_date_should_be_in_the_past 
    if !date_of_birth.blank? and date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in the future")
    end
  end

end
