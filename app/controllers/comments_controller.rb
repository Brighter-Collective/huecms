class CommentsController < ApplicationController
  
  def index
    
  end
  
  def new
    comment = Comment.create(params[:comment])
    render :partial => 'comment', :locals => { :comment => comment }
  end
  
  def create
    
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update_attributes(params[:comment])
    comment.edited_at = Time.now
    if comment.save
      render :text => "success"
    else
      render :text => "failure"
    end
  end
  
  def destroy
    comment = Comment.find(params[:id]).destroy
    if comment
      render :text => "success"
    else
      render :text => "failure"
    end
  end
  
end
