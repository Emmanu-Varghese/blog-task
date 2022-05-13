class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  scope :admin, -> { where(admin: true) }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  attr_readonly :email
  validates :name, presence: true

  has_person_name
  has_noticed_notifications

  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :articles, dependent: :destroy
end
