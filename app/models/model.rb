class Model < ActiveRecord::Base
  attr_accessible :confirmed, :date_of_birth, :email, :eyes, :hair, :height, :full_name, :shoes

  validates :date_of_birth, :email, :eyes, :hair, :height, :full_name, :shoes, :presence => true
  validates :shoes, :height, :numericality => {:greater_than => 0}
  validates :full_name, :email, :uniqueness => true
  validate :birth_date_should_be_in_the_past

  default_scope where(:confirmed => true).order('created_at DESC')
  scope :nonconfirmed, lambda { where(:confirmed => false) }
  scope :latest, lambda {|n| limit(n)}

  has_many :photos, :dependent => :destroy

private

  def birth_date_should_be_in_the_past 
    if !date_of_birth.blank? and date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in the future")
    end
  end
end
