class Bid < ActiveRecord::Base

  belongs_to :bidder
  belongs_to :job
  has_one :user, through: :bidder
  has_one :project, through: :bidder

  validates_presence_of :bidder_id, :job_id, :amount
  validates_uniqueness_of :bidder_id, :scope => :job_id
  validates_numericality_of :amount, greater_than_or_equal_to: 0

  after_commit :update_job_total_value

  def update_job_total_value
    self.job.update_total_value
    self.project.knapsack
  end

end
