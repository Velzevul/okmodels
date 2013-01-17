class WomenController < ApplicationController
  # GET /women
  # GET /women.json
  def index
    @search = Woman.confirmed.search(params[:search]) 
    @women = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @women }
    end
  end

  # GET /women/1
  # GET /women/1.json
  def show
    @woman = Woman.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @woman }
    end
  end

  # GET /women/new
  # GET /women/new.json
  def new
    @woman = Woman.new
    3.times { @woman.photos.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @woman }
    end
  end

  # GET /women/1/edit
  def edit
    @woman = Woman.find(params[:id])
  end

  # POST /women
  # POST /women.json
  def create
    @woman = Woman.new(params[:woman])
    (3 - @woman.photos.length).times { @woman.photos.build }

    respond_to do |format|
      if @woman.save
        format.html { redirect_to root_url, notice: 'Thank you for your application. It will be now reviewed by the administrator' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /women/1
  # PUT /women/1.json
  def update
    @woman = Woman.find(params[:id])

    respond_to do |format|
      if @woman.update_attributes(params[:woman])
        format.html { redirect_to @woman, notice: 'Woman was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @woman.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /women/1
  # DELETE /women/1.json
  def destroy
    @woman = Woman.find(params[:id])
    confirmed = @woman.confirmed
    @woman.destroy

    respond_to do |format|
      format.html { redirect_to (confirmed)? women_url : new_applications_url }
    end
  end
end
