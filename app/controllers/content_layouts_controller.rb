class ContentLayoutsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_content, except: :publish
  before_filter :load_content_layout, :only => [:show, :edit, :update]
  before_filter :collect_endpoints, only: [:new, :edit, :create]
  before_filter :collect_layouts, only: [:new, :edit, :create]


  def create
    @content = Content.find(params[:content_id])
    @content_layout = @content.content_layouts.build(params[:content_layout])
    if @content.save
      redirect_to edit_content_content_layout_path(@content, @content_layout)
    else
      render 'new'
    end
  end

  def new
    @content_layout = ContentLayout.new
  end

  def edit
    @fields = @content_layout.layout.get_fields
    @data = @content_layout.data || {}
  end

  def show
    layout = @content_layout.layout.content
    data = @content_layout.data
    ret = layout.dup
    layout.scan(/<content type=\"text\">([\w|\s]*?)<\/content>/) do |x|
      if x
        ret.gsub!('<content type="text">' + x.first + '</content>', data[x.first] || "" )
      end
    end
    layout.scan(/<content type=\"image\">([\w|\s]*?)<\/content>/) do |x|
      if x
        ret.gsub!('<content type="image">' + x.first + '</content>', @content_layout.images ? '<img src="' + @content_layout.images.select {|img| img.content_tag_name == x.first}[0].source.url + '" />' : "" )
      end
    end
    return render :text => ret
  end

  def update
    if @content_layout.update_attributes(params[:content_layout])
      flash[:success] = "#{undo_link}"
      redirect_to edit_content_content_layout_path(@content_layout.content, @content_layout)
    else
      @fields = @content_layout.layout.get_fields
      @data = @content_layout.data || {}


      params[:content_layout].delete(:content_layout_endpoints_attributes)
      params[:content_layout].delete(:data)

      render 'edit'
    end
  end

  def destroy
    ContentLayout.find(params["id"]).destroy
    redirect_to edit_content_path(@content)
  end

  def view_content_layout
    @content_content_layout = ContentLayout.find(params[:id])

    @content_layout_fields = {}

    data = @content_content_layout.data
    @content_layout.layout.layout.scan(/<content>([\w|\s]*?)<\/content>/) do |x|
      @content_layout_fields[x.first.strip] = data[x.first.strip]
    end
  end

  def publish
    cl = ContentLayout.find(params[:id])

    if cl.publish(params[:path], params[:filename])
      flash[:success] = "Content Layout published."
    else
      flash[:error] = "Content Layout could not be published."
    end

    redirect_to contents_path
  end

private

  def undo_link
    view_context.link_to("undo", revert_version_path(@content_layout.versions.scoped.last), :method => :post)
  end

  def load_content
    @content = Content.find(params[:content_id])
  end

  def load_content_layout
    @content_layout = ContentLayout.find(params[:id])
  end

  def collect_endpoints
    @endpoints = Endpoint.all || []
  end

  def collect_layouts
    @layouts = Layout.all || []
  end
end
