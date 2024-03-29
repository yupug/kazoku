#coding: utf-8
require 'RMagick'

class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  # render my photos
  def index
    @photos = Photo.where(:kazoku_id => @current_user.kazoku.id).order("id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  # render photo's detail
  def show
    @photo = Photo.where("id = ? and kazoku_id = ?", 
      params[:id], @current_user.kazoku.id).first

    if params.has_key?("data") then
      image =  Magick::Image.from_blob(@photo.content.data).first
      if scale = params[:scale] then
        image = image.change_geometry(scale) do |cols,rows,img|
          img.resize(cols, rows)
        end
      end
      send_data(image.to_blob, :type => @photo.mime_type, :disposition => 'inline')

    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @photo }
      end
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
=begin
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, :notice => 'Photo was successfully created.' }
        format.json { render :json => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
=end

 def create
    @photo = Photo.new(params[:photo])

    if @photo.save
      respond_to do |format|
        format.html {  
          render :json => [@photo.to_jq_upload].to_json, 
          :content_type => 'text/html',
          :layout => false
        }
        format.json {  
          render :json => [@photo.to_jq_upload].to_json     
        }
      end
    else 
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end


  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, :notice => 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
=begin
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
=end
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    render :json => true
  end


end
