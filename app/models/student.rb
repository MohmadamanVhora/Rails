class Student < ApplicationRecord

  HUMANIZED_ATTRIBUTES = {
    :date_of_birth => "",
    :term_of_usage => ""
  }
 
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :birthdate_validation
  validates_presence_of :department
  validates :department, inclusion:{ in: %w(IT CE), message: "can't be '%{value}'"}, if: -> { department.present? } 
  validates :term_of_usage, acceptance: { message: "You cannot proceed without accepting Terms of Usage" }


  def birthdate_validation
    if date_of_birth.nil?
      errors.add(:date_of_birth, "Birthdate can't be nil")
    elsif date_of_birth > Date.current
      errors.add(:date_of_birth, "Birthdate can't be in future")
    elsif date_of_birth < Date.parse('1907-03-04')
      errors.add(:date_of_birth, "No one is alive before Birth of 4th Mar 1907")
    end
  end
 
  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
