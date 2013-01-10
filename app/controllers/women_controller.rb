class WomenController < ApplicationController
  # GET /women
  # GET /women.json
  def index
    @women = Woman.all

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

    respond_to do |format|
      if @woman.save
        format.html { redirect_to @woman, notice: 'Woman was successfully created.' }
        format.json { render json: @woman, status: :created, location: @woman }
      else
        format.html { render action: "new" }
        format.json { render json: @woman.errors, status: :unprocessable_entity }
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
    @woman.destroy

    respond_to do |format|
      format.html { redirect_to women_url }
      format.json { head :no_content }
    end
  end
end
