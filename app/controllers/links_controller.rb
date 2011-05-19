class LinksController < ApplicationController
  
  respond_to :html
  
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    flash[:success] = "Here's your new shortened url" if @link.save 
    respond_with(@link, :location => link_path(@link))

  end
  
end
