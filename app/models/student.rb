class Student < ApplicationRecord

  HUMANIZED_ATTRIBUTES = {
    :date_of_birth => "",
    :term_of_usage => ""
  }
 
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :birthdate_validation
  validates_presence_of :email
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: -> { email.present? }
  validates_presence_of :department
  validates :department, inclusion:{ in: %w(IT CE), message: "can't be '%{value}'"}, if: -> { department.present? } 
  validates :term_of_usage, acceptance: { message: "You cannot proceed without accepting Terms of Usage" }

  # Callbacks

  after_initialize StudentsFacultiesCallbacks
  after_find StudentsFacultiesCallbacks

  before_create StudentsFacultiesCallbacks
  after_create StudentsFacultiesCallbacks, :display_message
  around_create StudentsFacultiesCallbacks

  before_update StudentsFacultiesCallbacks, :update_counter
  after_update StudentsFacultiesCallbacks
  around_update StudentsFacultiesCallbacks

  before_destroy StudentsFacultiesCallbacks
  after_destroy StudentsFacultiesCallbacks, :after_delete_student
  around_destroy StudentsFacultiesCallbacks

  before_validation :set_default_birthdate

  before_save StudentsFacultiesCallbacks

  after_commit :student_counter
  
  after_update_commit :update_student_counter
  
  after_save :skip_callback_example



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

  def set_default_birthdate
    self.date_of_birth = Date.parse('20010101') if date_of_birth.nil?
  end

  def display_message
    p "Email Validated"
  end
  
  def after_delete_student
    p "Student #{self.first_name} #{self.last_name} is removed from system."
    p "Conditional Callback for after deleting a student." if !Student.exists?(self.id)
  end

  def student_counter
    p "Total Students :- #{Student.count}"
  end

  def update_counter
    self.student_update_counter += 1
  end

  def update_student_counter
    p "This Student updated :- #{self.student_update_counter} times."
  end

  def skip_callback_example
    p "This is skip callback method for students"
  end

  Student.skip_callback(:save, :after, :skip_callback_example)

end
