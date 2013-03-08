class ContentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  respond_to :html, :xml, :json

  def index
    folder_id = params[:folder_id] || 1
    @folder = Folder.find(folder_id)
    @contents = Content.accessible_by( current_ability )
    respond_with(@contents)
  end

  def content_status_filter
    if params[:filter] == 1
      @contents = Content.where( :needs_review => 1 )
    elsif params[:filter] == 2
      @contents = Content.where( :published => 1 )
    else
      @contents = Content.all
    end

    render :partial => 'content'
  end

  def create
    @content = current_user.contents.build( params[:content] )
    if @content.save
      flash[:success] = "Content created."
    end
    respond_with(@content, :location => edit_content_path(@content))
  end

  def edit
    @content = Content.find( params[:id] )
    respond_with(@content)
  end

  def new
    @content = Content.new
    respond_with(@content)
  end

  def update
    @content = Content.find( params[:id] )

    if @content.update_attributes( params[:content] )
      flash[:success] = "Content updated."
    end
    respond_with(@content, :location => edit_content_path(@content))
  end

  def destroy
    Content.find( params[:id] ).destroy
    flash[:success] = "Content deleted."
    respond_with(@content)
  end

  def publish
    @content = Content.find( params[:content_id] )

    successes = []
    failures = []
    @content.content_layouts.each do |b|
      if !b.published? and b.publish
        successes << b.name
      else
        failures << b.name
      end
    end
    if failures.empty?
      flash[:success] = "Content published successfully."
    else
      flash[:success] = "#{successes.join(", ")} published."
      flash[:error] = "#{failures.join(", ")} could not be published."
    end
    ContentNotificationsMailer.content_published(@content).deliver
    @content.update_attributes(needs_review:false)
    respond_with(@content) do |format|
      format.html { redirect_to contents_url }
      format.xml { render @content.to_xml }
      format.json { render @content.to_json }
    end
  end

end
