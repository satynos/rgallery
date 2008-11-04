class PhotosController < ApplicationController
  before_filter :find_gallery
  before_filter :find_photo, :only => [:show, :edit, :update, :destroy]
  
  def index
    if @gallery.nil?
      @photos = Photo.find(:all, :order => "created_at DESC", :limit => 5)
    else
      @photos = @gallery.photos.paginate :per_page => 50, :page => params[:page], :order => "created_at DESC"
    end
  end
  
  def show
  end
  
  def new
    @photo = Photo.new(params[:photo])
  end
  
  def create
    @photo = if @gallery
      @gallery.photos.build(params[:photo])
    else
      Photo.new(params[:photo])
    end
    
    if @photo.save
      flash[:success] = t(:photo_uploaded)
      redirect_to @gallery.nil? ? photo_path(@photo) : gallery_photo_path(@gallery, @photo)
    else
      flash[:failure] = t(:photo_not_uploaded)
      render :action => "new"
    end
  end
  
  def edit
  end
  
  def update
    if @photo.update_attributes(params[:photo])
      flash[:success] = t(:photo_updated)
      redirect_to gallery_photo_path(@gallery, @photo)
    else
      flash[:failure] = t(:photo_not_uploaded)
      render :action => "edit"
    end
  end
  
  def destroy
    @photo.destroy
    flash[:success] = t(:photo_deleted)
  end
  
  def large
    @photo = Photo.find(params[:id])
  end
  
  private
  
  def find_gallery
    @gallery = Gallery.find(params[:gallery_id]) unless params[:gallery_id].nil?
  end
  
  
  def find_photo
    @photo = if @gallery.nil?
      Photo.find(params[:id])
    else
      @gallery.photos.find(params[:id])
    end
  end
end
