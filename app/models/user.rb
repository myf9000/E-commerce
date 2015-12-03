class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :products
  
  extend FriendlyId
  friendly_id :email, use: :slugged

  acts_as_follower

  acts_as_messageable

  ratyrate_rater

  ratyrate_rateable 'culture', 'speed'

  def mailboxer_email(object)
    self.email
  end

  
end
