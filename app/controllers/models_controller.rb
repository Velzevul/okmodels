class ModelsController < ApplicationController
  def index
    @search = Model.where(:type => params[:type], :confirmed => true).search(params[:search])
    @models = @search.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @model = Model.new
    @model.type = params[:type]
    3.times { @model.photos.build }

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @model = Model.find(params[:id])
  end

  def create
    @model = Model.new(params[:model])
    @model.type = params[:type]
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
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to @model, notice: 'Record was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @model = Model.find(params[:id])
    confirmed = @model.confirmed
    @model.destroy

    respond_to do |format|
      format.html { redirect_to (confirmed)? send("#{params[:type].downcase.pluralize}_path") : new_applications_url }
    end
  end
end
