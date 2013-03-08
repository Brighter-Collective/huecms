class AddReviewToContent < ActiveRecord::Migration
  def change
    add_column :contents, :needs_review, :boolean, :default => 0
  end
end
