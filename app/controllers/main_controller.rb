class MainController < ApplicationController
  def home
  end

  def contact
  end

  def latest
    @models = Model.latest(25)
  end
end
