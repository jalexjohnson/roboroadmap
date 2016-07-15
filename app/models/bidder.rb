class Bidder < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  has_many :bids, dependent: :destroy

  validates_presence_of :allowance
  validates_uniqueness_of :user_id, :scope => :project_id
  validates_numericality_of :allowance, greater_than_or_equal_to: 0

  def remaining_allowance
    total = 0
    self.project.jobs.each do |job|
      job.bids.where(bidder_id: self.id).each do |bid|
        total = total + bid.amount
      end
    end
    return self.allowance - total
  end

  def can_make_bid?(new_bid)
    return self.remaining_allowance - new_bid >= 0
  end

end
