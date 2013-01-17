class MainController < ApplicationController
  def home
  end

  def contact
  end

  def latest
    @models = Model.latest(25)
    render :template => "main/list.html.erb"
  end

  def new_applications
    @models = Model.nonconfirmed
    render :template => "main/list.html.erb"
  end

  def approve
    @model = Model.find(params[:id])
    @model.confirmed = true
    @model.save
    redirect_to @model, :notice => "Model was approved"
  end
end
