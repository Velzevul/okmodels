class PhotosController < ApplicationController
  before_filter :determine_model_type

  def new
    @model = Model.find(params[@model_type])
    @photo = @model.photos.build
  end

  def create
    @model = Model.find(params[@model_type])
    @photo = @model.photos.build(params[:photo])
    if @photo.save
      redirect_to @model
    else
      render 'new'
    end
  end

  def destroy
    model = Model.find(params[@model_type])
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to model, :notice => "Photo was successfully deleted"
  end

private
  def determine_model_type
    if params[:man_id]
      @model_type = "man_id"
    elsif params[:woman_id]
      @model_type = "woman_id"
    elsif params[:child_id]
      @model_type = "child_id"
    end
  end
end
