class ChildrenController < ApplicationController
  # GET /children
  # GET /children.json
  def index
    @search = Child.confirmed.search(params[:search]) 
    @children = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @children }
    end
  end

  # GET /children/1
  # GET /children/1.json
  def show
    @child = Child.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child }
    end
  end

  # GET /children/new
  # GET /children/new.json
  def new
    @child = Child.new
    3.times { @child.photos.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child }
    end
  end

  # GET /children/1/edit
  def edit
    @child = Child.find(params[:id])
  end

  # POST /children
  # POST /children.json
  def create
    @child = Child.new(params[:child])
    (3 - @child.photos.length).times { @child.photos.build }

    respond_to do |format|
      if @child.save
        format.html { redirect_to root_url, notice: 'Thank you for your application. It will be now reviewed by the administrator' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /children/1
  # PUT /children/1.json
  def update
    @child = Child.find(params[:id])

    respond_to do |format|
      if @child.update_attributes(params[:child])
        format.html { redirect_to @child, notice: 'Child was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1
  # DELETE /children/1.json
  def destroy
    @child = Child.find(params[:id])
    confirmed = @child.confirmed
    @child.destroy

    respond_to do |format|
      format.html { redirect_to (confirmed)? children_url : new_applications_path }
      format.json { head :no_content }
    end
  end
end
