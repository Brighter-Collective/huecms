class LayoutsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :xml, :json

  def index
    @layouts = Layout.where(type: "HtmlLayout")
    respond_with(@layouts)
  end

  def create
    @layout = Layout.new(params[:layout])
    if @layout.save
      flash[:success] = "Layout created."
      respond_with(@layout, :location => edit_layout_path(@layout))
    end
  end

  def new
    @layout = Layout.new
    respond_with(@layout)
  end

  def edit
    @layout = Layout.find(params[:id])
    respond_with(@layout)
  end

  def update
    puts params
    @layout = Layout.find(params[:id])
    if @layout.update_attributes(params[:layout])
      flash[:success] = "Layout updated. #{undo_link}"
    end
    respond_with(@layout, :location => edit_layout_url)
  end

  def destroy
    Layout.find(params[:id]).destroy
    flash[:success] = "Layout destroyed."
    respond_with(@layout)
  end

  private 

  def undo_link
    view_context.link_to("undo", revert_version_url(@layout.versions.scoped.last), :method => :post)
  end
end
