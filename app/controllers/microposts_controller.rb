class MicropostsController < ApplicationController
  include MicropostsHelper
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::SanitizeHelper
  extend ActionView::Helpers::SanitizeHelper::ClassMethods

  before_filter :authenticate,    :only => [:create, :destroy]
  before_filter :authorized_user, :only => [:destroy]

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost[:content] = sanitize(raw(wrap(@micropost[:content])))
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

end
