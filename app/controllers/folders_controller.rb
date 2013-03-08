class FoldersController < ApplicationController
  before_filter :authenticate_user!

  def create
    folder = Folder.find(params[:folder][:folder_id])
    folder.folders.build(params[:folder])
    if folder.save
      flash[:success] = "Folder created successfully."
      redirect_to contents_path(folder_id: folder.id)
    else
      flash[:error] = folder.errors.full_message
      redirect_to contents_path(folder_id: folder.id)
    end
  end

  def update
    folder = Folder.find(params[:id])
    if folder.update_attributes(params[:folder])
      flash[:success] = "Folder updated successfully."
      redirect_to contents_path
    else
      flash[:success] = folder.errors.full_messages.inspect
      redirect_to contents_path
    end
  end
end
