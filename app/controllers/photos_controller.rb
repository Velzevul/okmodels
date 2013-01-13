class PhotosController < ApplicationController
  before_filter :determine_model_type_and_class

  def new
    @model = @model_class.find(params[@model_type])
    @photo = @model.photos.build
    render :template => @model_class.name.pluralize.downcase + "/new_photo"
  end

  def create
    model = @model_class.find(params[@model_type])
    @photo = model.photos.build(params[:photo])
    if @photo.save
      redirect_to model
    else
      render :action => "new"
    end
  end

  def destroy
    model = @model_class.find(params[@model_type])
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to model, :notice => "Photo was successfully deleted"
  end

private
  def determine_model_type_and_class
    if params[:man_id]
      @model_type = "man_id"
      @model_class = Man
    elsif params[:woman_id]
      @model_type = "woman_id"
      @model_class = Woman
    elsif params[:child_id]
      @model_type = "child_id"
      @model_class= Child
    end
  end
end
