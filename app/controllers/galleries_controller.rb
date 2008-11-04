class GalleriesController < ApplicationController
  def index
    @galleries = current_user.galleries
  end
  
  def show
    redirect_to gallery_photos_path(params[:id])
  end
  
  def new
    @gallery = current_user.galleries.build
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
    render :layout => false
  end
  
  def create
    @gallery = current_user.galleries.build(params[:gallery])
    if @gallery.save
      flash[:success] = t(:gallery_created)
      redirect_to gallery_path(@gallery)
    else
      flash[:failure] = t(:gallery_not_created)
      render :action => "new"
    end
  end
  
end
