class Faculty < ApplicationRecord

  HUMANIZED_ATTRIBUTES = {
    :date_of_birth => ""
  }
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_presence_of :phone_no
  validates :phone_no, numericality: true, length: { is: 10 , message: "should be 10 characters"}, if: -> { phone_no.present? }
  validates_presence_of :email
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: -> { email.present? }
  validate :birthdate_validation
  validates_presence_of :designation
  validates :designation, inclusion: {in: ["Assistant Professor", "Professor"], message: "can't be %{value}", unless: -> { ["HOD", "Senior Professor"].include?(designation) } }, if: -> { designation.present? }
  validates :designation, exclusion: {in: ["HOD", "Senior Professor"], message: "must not be %{value}"}

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
