class Model < ActiveRecord::Base
  attr_accessible :confirmed, :date_of_birth, :email, :eyes, :hair, :height, 
                  :full_name, :shoes, :photos_attributes, :city, :phone, 
                  :first_name, :second_name, :mediastar, :description

  attr_accessor :first_name, :second_name

  validates :date_of_birth, :email, :eyes, :hair, :height, :full_name, :shoes, 
            :city, :phone, :presence => true
  validates :shoes, :height, :numericality => {:greater_than => 0}
  validates :full_name, :email, :uniqueness => true
  validate :birth_date_should_be_in_the_past

  default_scope order('created_at DESC')
  scope :confirmed, lambda { where(:confirmed => true) }
  scope :nonconfirmed, lambda { where(:confirmed => [false,nil]) }
  scope :latest, lambda {|n| confirmed.limit(n)}
  scope :mediastar, lambda { where(:mediastar => true) }

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos

  before_validation :combine_first_and_second_names
private
  def combine_first_and_second_names
    if full_name.blank?
      self.full_name = [first_name, second_name].join(" ")
    end
  end

  def birth_date_should_be_in_the_past 
    if !date_of_birth.blank? and date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in the future")
    end
  end
end
