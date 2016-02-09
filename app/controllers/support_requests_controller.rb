class SupportRequestsController < ApplicationController
  before_action :find_support_request, only: [:show, :edit, :update, :destroy]

  def new
    @support_request = SupportRequest.new
  end

  def create
    @support_request = SupportRequest.new support_request_params
    if @support_request.save
      redirect_to support_request_path(@support_request)
      flash[:notice] = "Support Request created successfully!"
    else
      flash[:alert] = "Support Request not created. Please see errors."
      render (:new)
    end
  end

  def index
    @support_requests = SupportRequest.order("completed DESC", "updated_at DESC").page params[:page]
  end

  def show
  end

  def edit
  end

  def update
    completed_status_before = @support_request.completed
    if @support_request.update support_request_params
      completed_status_after = @support_request.completed
      if completed_status_after != completed_status_before
        redirect_to support_requests_path
      else
        redirect_to support_request_path(@support_request)
      end
      flash[:notice] = "Support Request updated successfully!"
    else
      flash[:alert] = "Support Request not updated. See errors."
      render :edit
    end
  end

  def destroy
    @support_request.destroy
    redirect_to support_requests_path
    flash[:alert] = "Support Request deleted successfully."
  end

  def search
    session[:term] = params[:q]
    @results = SupportRequest.search(session[:term]).page params[:page]
  end

  private

  def find_support_request
    @support_request = SupportRequest.find params[:id]
  end

  def support_request_params
    params.require(:support_request).permit(:name, :email, :department, :message, :completed)
  end
end
