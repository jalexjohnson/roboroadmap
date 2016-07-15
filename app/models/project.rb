class Project < ActiveRecord::Base

  has_many :jobs, dependent: :destroy
  has_many :bidders, dependent: :destroy
  belongs_to :user

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name

end
