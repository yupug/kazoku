#coding: utf-8
class KazokusController < ApplicationController
  # GET /kazokus
  # GET /kazokus.json
  def index
    @kazokus = Kazoku.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kazokus }
    end
  end

  # GET /kazokus/1
  # GET /kazokus/1.json
  def show
    @kazoku = Kazoku.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @kazoku }
    end
  end

  # GET /kazokus/new
  # GET /kazokus/new.json
  def new
    @kazoku = Kazoku.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @kazoku }
    end
  end

  # GET /kazokus/1/edit
  def edit
    @kazoku = Kazoku.find(params[:id])
  end

  # POST /kazokus
  # POST /kazokus.json
  def create
    @kazoku = Kazoku.new(params[:kazoku])

    respond_to do |format|
      if @kazoku.save
        format.html { redirect_to @kazoku, :notice => 'Kazoku was successfully created.' }
        format.json { render :json => @kazoku, :status => :created, :location => @kazoku }
      else
        format.html { render :action => "new" }
        format.json { render :json => @kazoku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kazokus/1
  # PUT /kazokus/1.json
  def update
    @kazoku = Kazoku.find(params[:id])

    respond_to do |format|
      if @kazoku.update_attributes(params[:kazoku])
        format.html { redirect_to @kazoku, :notice => 'Kazoku was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @kazoku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kazokus/1
  # DELETE /kazokus/1.json
  def destroy
    @kazoku = Kazoku.find(params[:id])
    @kazoku.destroy

    respond_to do |format|
      format.html { redirect_to kazokus_url }
      format.json { head :no_content }
    end
  end
end
