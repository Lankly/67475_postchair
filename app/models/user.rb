class User < ActiveRecord::Base
  has_many :manager_associations
  has_many :input_streams
  
  has_secure_password
  
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates_presence_of :first_name, :last_name
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password, message: "does not match"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov))\z/i, message: "is not a valid format"
  
  def self.authenticate(email,password)
    find_by_email(email).try(:authenticate, password)
  end
end
