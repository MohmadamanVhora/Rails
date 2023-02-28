class HomeController < ApplicationController
  def index
    @name = "Mohmadaman"
    @college = "Government Engineering College, Modasa."
    @date_of_birth = "04/08/2002"
    @hobbies = "Travelling, Playing Cricket"
    @strength = "Positive Attitude, Learnability, Adaptability"
    @weakness = "Public Speaking"
  end
end
