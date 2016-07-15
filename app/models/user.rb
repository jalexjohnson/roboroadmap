class User < ActiveRecord::Base

  has_many :projects, dependent: :restrict_with_exception
  has_many :bidders, dependent: :destroy
  has_many :bids, through: :bidders

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  has_secure_password #automatically deals with password confirmation

  before_validation :normalize_email

  def normalize_email
    if self.email.present?
      self.email = self.email.strip.downcase
    end
  end


end
