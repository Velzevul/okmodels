class MainController < ApplicationController
  def home
  end

  def contact
  end

  def latest
    @men = Man.latest(10)
    @women = Woman.latest(10)
    @children = Child.latest(10)
  end
end
