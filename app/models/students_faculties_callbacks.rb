class StudentsFacultiesCallbacks

  def self.after_initialize(record)
    p "after initialize callback"
  end

  def self.after_find(record)
    p "after find callback"
  end

  def self.before_create(record)
    p "before create callback"
  end

  def self.after_create(record)
    p "after create callback"
  end

  def self.around_create(record)
    p "before around create callback"
    yield
    p "after around create callback"
  end

  def self.before_update(record)
    p "before update callback"
  end

  def self.after_update(record)
    p "after update callback"
  end

  def self.around_update(record)
    p "before around update callback"
    yield
    p "after around update callback"
  end

  def self.before_destroy(record)
    p "before destroy callback"
  end

  def self.after_destroy(record)
    p "after destroy callback"
  end

  def self.around_destroy(record)
    p "before around destroy callback"
    yield
    p "after around destroy callback"
  end

  def self.before_save(record)
    record.email.downcase!
    record.email = "ror_demo" + record.email if !record.email.start_with?('ror_demo')
  end
end
