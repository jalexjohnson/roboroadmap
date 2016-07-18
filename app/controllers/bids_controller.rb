class BidsController < ApplicationController

  before_action :require_login
  before_action :find_bid, :only => [:show, :edit, :update, :destroy]
  before_action :find_job
  before_action :require_bidder, :only => [:create, :update]

  def find_job
    @job = Job.find_by_id(params[:job_id])
  end

  def require_bidder
    if !Bidder.find_by(user: current_user).present?
      redirect_to root_path, notice: "You must be a bidder on the project to perform that action."
    end
  end

  def find_bid
    @bid = Bid.find_by_id(params[:id])
  end

  def create
    bidder = Bidder.find_by_id(params[:bid][:bidder_id])
    if bidder.can_make_bid?(params[:bid][:amount].to_i)
      @bid = Bid.create(bid_params)
      redirect_to project_path(params[:project_id])
    else
      redirect_to project_path(params[:project_id]), notice: "Your bid is more than your remaining allowance."
    end
  end

  def update
    bidder = Bidder.find_by_id(params[:bid][:bidder_id])
    if bidder.can_make_bid?(params[:bid][:amount].to_i - @bid.amount)
      @bid.update(bid_params)
      redirect_to project_path(params[:project_id])
    else
      redirect_to project_path(params[:project_id]), notice: "Your bid is more than your remaining allowance."
    end
  end

  def bid_params
    params.require(:bid).permit(:amount, :bidder_id, :job_id)
  end

  def destroy
    require_owner(@job.project)
  end

end
