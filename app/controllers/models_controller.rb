class ModelsController < ApplicationController
  def approve
    @model = Model.where(:type => params[:type]).find(params[:id])
    authorize! :approve, @model
    @model.confirmed = true
    @model.save
    redirect_to @model.mediastar? ? mediastar_path(@model) : @model, :notice => "#{@model.full_name} has been approved"
  end

  def latest
    @search = Model.latest(15).search(params[:search])
    @models = @search.all
    render :index
  end

  def mediastars
    @search = Model.mediastar.search(params[:search])
    @models = @search.all
    @ms = true
    render :index
  end

  def show_mediastar
    @model = Model.find(params[:id])
    authorize! :read, @model
    @ms = true

    render :show
  end

  def new_applications
    authorize! :new_applications, Model
    @search = Model.nonconfirmed.search(params[:search])
    @models = @search.all
    render :index
  end

  def index
    if params[:type] == "Child"
      authorize! :read, Child
    end
    @search = Model.where(:type => params[:type], :confirmed => true, :mediastar => [false,nil]).search(params[:search])
    @models = @search.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @model = Model.where(:type => params[:type]).find(params[:id])
    authorize! :read, @model

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @model = Man.new if params[:type] == "Man"
    @model = Woman.new if params[:type] == "Woman"
    @model = Child.new if params[:type] == "Child"
    3.times { @model.photos.build }

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @model = Model.where(:type => params[:type]).find(params[:id])
    authorize! :edit, @model
  end

  def create
    @model = Man.new(params[:man]) if params[:type] == "Man"
    @model = Woman.new(params[:woman]) if params[:type] == "Woman"
    @model = Child.new(params[:child]) if params[:type] == "Child"
    (3 - @model.photos.length).times { @model.photos.build }

    respond_to do |format|
      if @model.save
        format.html { redirect_to root_url, notice: 'Thank you for your application. It will be now reviewed by the administrator' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @model = Model.where(:type => params[:type]).find(params[:id])
    authorize! :update, @model

    respond_to do |format|
      if @model.update_attributes(params[@model.type.downcase])
        format.html { redirect_to @model.mediastar? ? mediastar_path(@model) : @model, notice: 'Record was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @model = Model.where(:type => params[:type]).find(params[:id])
    authorize! :destroy, @model
    confirmed = @model.confirmed
    @model.destroy

    respond_to do |format|
      format.html { redirect_to (confirmed)? send("#{params[:type].downcase.pluralize}_path") : new_applications_url }
    end
  end
end
