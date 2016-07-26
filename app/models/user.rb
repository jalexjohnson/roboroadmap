class User < ActiveRecord::Base

  has_many :projects, dependent: :restrict_with_exception
  has_many :bidders, dependent: :destroy
  has_many :bids, through: :bidders

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  has_secure_password #automatically deals with password confirmation

  #http://stackoverflow.com/questions/11992544/validating-password-using-regex
  #http://stackoverflow.com/questions/16811530/devise-3-rails-4-cant-update-user-without-password
  validates :password, presence: true, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: "Password must be at least 6 characters and include one number and one letter."}, on: :create
  validates :password, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: "Password must be at least 6 characters and include one number and one letter."}, on: :update, allow_blank: true
  before_validation :normalize_email

  def normalize_email
    if self.email.present?
      self.email = self.email.strip.downcase
    end
  end


end
