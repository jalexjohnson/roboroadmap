class Job < ActiveRecord::Base

  has_many :bids, dependent: :destroy
  belongs_to :project

  validates_presence_of :name, :project_id
  validates_numericality_of :size, greater_than_or_equal_to: 0
  validates_numericality_of :total_value, greater_than_or_equal_to: 0

  def update_total_value
    total = 0
    self.bids.each do |bid|
      total = total + bid.amount
    end
    self.update(total_value: total)
  end

end
