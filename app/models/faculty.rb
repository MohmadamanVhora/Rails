class Faculty < ApplicationRecord

  HUMANIZED_ATTRIBUTES = {
    :date_of_birth => ""
  }
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_no, numericality: true, length: { is: 10 }
  validates_presence_of :email
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
  validate :birthdate_validation
  validates_exclusion_of :designation, in: ["HOD", "Senior Professor"], on: :create, message: "must not be %{value}"
  validates_inclusion_of :designation, in: ["Assistant Professor", "Professor"], on: :create, message: "can not be %{value}"
 

  def birthdate_validation
    if date_of_birth.nil?
      errors.add(:date_of_birth, "Birthdate can't be nil")
    else
      return unless date_of_birth.present? 
      if date_of_birth > Date.current
        errors.add(:date_of_birth, "Birthdate can't be in future")
      elsif date_of_birth < Date.parse('1907-03-04')
        errors.add(:date_of_birth, "No one is alive before Birth of 4th Mar 1907")
      end
    end
  end

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
