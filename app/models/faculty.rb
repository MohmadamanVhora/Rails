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


  # Callbacks

  after_initialize StudentsFacultiesCallbacks
  after_find StudentsFacultiesCallbacks

  before_create StudentsFacultiesCallbacks
  after_create StudentsFacultiesCallbacks
  around_create StudentsFacultiesCallbacks

  before_update StudentsFacultiesCallbacks, :update_counter
  after_update StudentsFacultiesCallbacks
  around_update StudentsFacultiesCallbacks

  before_destroy StudentsFacultiesCallbacks
  after_destroy StudentsFacultiesCallbacks, :after_delete_faculty
  around_destroy StudentsFacultiesCallbacks

  after_validation :age_calculation

  before_save StudentsFacultiesCallbacks

  after_commit :faculty_counter

  after_update_commit :update_faculty_counter

  before_validation StudentsFacultiesCallbacks


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

  def age_calculation
    p "after validation callback"
    self.age = Date.current.year - date_of_birth.year
  end

  def faculty_counter
    p "Total Faculties :- #{Faculty.count}"
  end

  def update_counter
    self.faculty_update_counter += 1
  end

  def update_faculty_counter
    p "This Faculty updated :- #{self.faculty_update_counter} times."
  end
    
  def after_delete_faculty
    p "Faculty #{self.first_name} #{self.last_name} is removed from system."
  end

end
